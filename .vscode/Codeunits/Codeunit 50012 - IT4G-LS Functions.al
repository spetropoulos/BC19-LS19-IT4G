codeunit 50012 "IT4G-LS Functions"
{
    var
        tmpPT: record "LSC POS Transaction" temporary;
        lblNoDoc: label 'No Document Selected!!!';
        cC: Codeunit "IT4G-POS Commands";

    procedure IsIT4GRetailActive(): Boolean
    var
        rRS: Record "LSC Retail Setup";
    begin
        if not rRS.get then exit(false);
        EXIT(rRS."IT4G Module Enabled");
    end;

    procedure USEIT4GtransWS(): Boolean
    var
        rRS: Record "LSC Retail Setup";
    begin
        if not rRS.get then exit(false);
        EXIT(rRS."Use IT4G Transaction WS");
    end;

    Procedure GetDocInfo(var POSTransaction: Record "LSC POS Transaction"): text;
    var
        rDoc: Record "IT4G-LS Document";
    begin
        if rDoc.get(POSTransaction."Document Code") then begin
            if rDoc."Printing Description" <> '' then
                exit(rDoc.Code + ' - ' + rDoc."Printing Description")
            else
                exit(rDoc.Code + ' - ' + rDoc."Description");
        end else
            exit(lblNoDoc);

    end;

    Procedure WriteDocumentCode(var rPT: record "LSC POS Transaction"; xDocCode: code[20]);
    var

        rDC: Record "IT4G-LS Document";
        rStore: Record "LSC Store";
    begin
        rDC.get(xDocCode);
        rPT."Document Code" := rDC."Code";

        If rPT."Location Code" = '' then begin
            If rStore.get(rPT."Store No.") then
                rPT."Location Code" := rStore."Location Code";
        end;

        rPT."To Location" := rDC."Default To Location";
        rPT."To Store" := rDC."Default Store To";

        case rDC."Transfer Type" of
            rDC."Transfer Type"::Ship:
                begin
                    rPT."From Location" := rPT."Location Code";
                    rPT."From Store" := rPT."Store No.";
                end;
            rDC."Transfer Type"::Receive:
                begin
                    rPT."To Location" := rPT."Location Code";
                    rPT."To Store" := rPT."Store No.";
                end;
            else begin
                    rPT."From Location" := '';
                    rPT."From Store" := '';
                    rPT."To Location" := '';
                    rPT."To Store" := '';
                end;
        end;
        /*
                if rPT."From Location" = '' then rPT."From Location" := rDC."Default From Location";
                if rPT."From Store" := 'From Sto';
        */
        if rPT."Reason Code" = '' then rPT."Reason Code" := rDC."Reason Code";
        if rPT."Shipment Method" = '' then rPT."Shipment Method" := rDC."Shipment Method";
        if rPT."Shipment Reason" = '' then rPT."Shipment Reason" := rDC."Shipment Reason";
        rPT.modify;

    end;

    procedure GetDocumentPrinter(DocCode: Code[10]; "Store": Code[10]; "POS": Code[10]): Integer;
    var
        rDSPS: Record "IT4G-Doc. Series Printer Setup";
        rDoc: Record "IT4G-LS Document";
    begin
        rDoc.get(DocCode);
        rDSPS.RESET;
        rDSPS.SETRANGE("Data Type", rDSPS."Data Type"::Printer);
        rDSPS.SETRANGE(Code, rDoc."Printing Document");
        rDSPS.SETRANGE("Store No.", "Store");
        rDSPS.SETRANGE("Terminal No.", "POS");
        IF rDSPS.FINDFIRST THEN
            EXIT(rDSPS."Document Report ID");

        rDSPS.SETRANGE("Terminal No.", '');
        IF rDSPS.FINDFIRST THEN
            EXIT(rDSPS."Document Report ID");

        rDSPS.SETRANGE("Store No.", '');
        IF rDSPS.FIND('-') THEN
            EXIT(rDSPS."Document Report ID");

        EXIT(0);
    end;

    procedure GetDocumentSeries(xDocCode: code[20]; xStore: code[10]; xPOS: Code[10]; xDate: Date; DocSeriesRetType: enum "IT4G-DocSeriesRetType"): Code[20];
    var
        rRetSetup: Record "LSC Retail Setup";
        rDoc: record "IT4G-LS Document";
        rPOS: record "LSC POS Terminal";
        rNS: Record "No. Series";
        rNSL: Record "No. Series Line";
        rDSPS: record "IT4G-Doc. Series Printer Setup";
        xNS: Text;
        xRetVal: code[20];
        bFound: Boolean;
    begin
        rRetSetup.get;
        if not rDoc.get(xDocCode) then exit;
        clear(rPOS);

        bFound := false;

        clear(rDSPS);
        rDSPS.setrange("Code", rDoc."Series Document");
        rDSPS.setrange("Store No.", xStore);
        rDSPS.setrange("Terminal No.", xPOS);
        if rDSPS.findfirst then
            bFound := true
        else begin
            rDSPS.setrange("Terminal No.");
            if rDSPS.findfirst then
                bFound := true
            else begin
                rDSPS.setrange("Store No.");
                if rDSPS.findfirst then bFound := true
            end;
        end;

        rDoc.get(rDoc."Series Document");

        if not rDoc."IT4G Auto Create Doc. Series" then
            if bFound then begin
                case DocSeriesRetType of
                    DocSeriesRetType::"No. Series":

                        exit(rDSPS."No. Series");
                    DocSeriesRetType::"Order No. Series":
                        exit(rDSPS."Order No. Series");

                end;
            end;


        if not bfound then
            if not rDoc."IT4G Auto Create Doc. Series" then exit('');

        if not (DocSeriesRetType = DocSeriesRetType::"No. Series") then exit('');

        if rPOS.get(xPOS) then
            case rDoc."IT4G Document Series Type" of
                rDoc."IT4G Document Series Type"::"POS Code":
                    begin
                        xNS := rPOS."No.";
                    end;
                rDoc."IT4G Document Series Type"::"POS Receipt barcode ID":
                    begin
                        xNS := format(rPOS."Receipt Barcode ID");
                    end;
            end;

        if rDoc."No. Series Prefix" <> '' then
            xNS += rDoc."No. Series Prefix"
        else
            xNS += rDoc."Code";

        if xDate = 0D then xDate := today;

        CLEAR(rNSL);
        rNSL.SetRange("Series Code", xNS);
        if rDoc."Yearly Series" then rNSL.setrange("Starting Date", CALCDATE('<-CY>', xDate));
        if not rNSL.findfirst then begin
            if not rNS.get(xNS) then begin
                clear(rNS);
                rNS.Code := xNS;
                rNS.Description := rDoc.Description;
                rNS."Date Order" := true;
                rNS.insert(TRUE);
            end;
            clear(rNSL);
            rNSL."Series Code" := rNS.code;
            if rDoc."Yearly Series" then begin
                rNSL."Starting Date" := CALCDATE('<-CY>', xDate);
                xNS += copystr(format(DATE2DMY(Today, 3)), 3);
            end;
            rNSL."Line No." := DATE2DMY(Today, 3);
            rNSL."Increment-by No." := 1;

            if rDoc."Series Length" = 0 then rDoc."Series Length" := 20;

            rNSL."Starting No." := xNS + PadStr('0', rDoc."Series Length" - strlen(xNS) - 1, '0') + '1';
            if rNSL.insert(true) then;

        end else
            rNS.get(xNS);

        if not rDSPS.get(rDSPS."Data Type"::Series, xDocCode, xStore, xPOS) then begin
            clear(rDSPS);
            rDSPS.Code := xDocCode;
            rDSPS."Store No." := xStore;
            rDSPS."Terminal No." := xPOS;
            rDSPS."Data Type" := rDSPS."Data Type"::Series;
            rDSPS."No. Series" := rNS.Code;
            if rDSPS.insert(true) then;
        end;

        exit(rDSPS."No. Series");

    end;

    procedure GetDocumentRelation(
            var rDocReltmp: record "IT4G-LS Document Relations" temporary;
            xType: Enum "IT4G-Document Relation Type";
            xCode: code[20];
            xStore: Code[10];
            xPOS: Code[10];
            xStaff: code[20]);
    var
        rDoc: Record "IT4G-LS Document";
        rDocRel: Record "IT4G-LS Document Relations";
        bOK: Boolean;
    begin
        If rDocReltmp.IsTemporary then begin
            rDocReltmp.reset;
            rDocReltmp.deleteall;
        end;

        rDoc.get(xCode);
        rDocRel.RESET;
        rDocRel.SetRange("Relation Type", xType);
        rDocRel.SetRange("Document Code", xCode);
        if xStore <> '' then rDocRel.SETRANGE("Store No.", "xStore");
        if xPOS <> '' then rDocRel.SETRANGE("Terminal No.", "xPOS");
        if xStaff <> '' then rDocRel.SETRANGE("Staff ID", "xStaff");
        IF rDocRel.FINDSET THEN bOK := true;
        if not bOK then begin
            if xStaff <> '' then rDocRel.SETRANGE("Staff ID");
            IF rDocRel.FINDSET THEN bOK := true;
        end;

        if not bOK then begin
            if xPOS <> '' then rDocRel.SETRANGE("Terminal No.");
            IF rDocRel.FINDSET THEN bOK := true;
        end;

        if not bOK then begin
            if xStaff <> '' then rDocRel.SETRANGE("Staff ID", "xStaff");
            IF rDocRel.FINDSET THEN bOK := true;
        end;

        if not bOK then begin
            if xStore <> '' then rDocRel.SETRANGE("Store No.");
            IF rDocRel.FINDSET THEN bOK := true;
        end;

        if not bOK then begin
            if xStaff <> '' then rDocRel.SETRANGE("Staff ID");
            IF rDocRel.FINDSET THEN bOK := true;
        end;

        if bOK then begin
            repeat
                clear(rDocReltmp);
                rDocRelTmp.TransferFields(rDocRel);
                if rDocReltmp.insert then;
            until rDocRel.Next = 0;

        end else begin

        end;
    end;

    procedure IsCodeRelationAllowed(
            xType: Enum "IT4G-Document Relation Type";
            xCode: code[20];
            xStore: Code[10];
            xPOS: Code[10];
            xStaff: code[20];
            xRelCode: code[20]): boolean;
    var
        rDocRel: Record "IT4G-LS Document Relations";
        rDocReltmp: record "IT4G-LS Document Relations" temporary;
    begin
        if rDocRel.get(xType, xCode, xStore, xPOS, xStaff, xRelCode) then exit(true);
        if rDocRel.get(xType, xCode, xStore, xPOS, '', xRelCode) then exit(true);
        if rDocRel.get(xType, xCode, xStore, '', xStaff, xRelCode) then exit(true);
        if rDocRel.get(xType, xCode, xStore, '', '', xRelCode) then exit(true);
        if rDocRel.get(xType, xCode, '', '', xStaff, xRelCode) then exit(true);
        if rDocRel.get(xType, xCode, '', '', '', xRelCode) then exit(true);

        GetDocumentRelation(rDocReltmp, xType, xCode, xStore, xPOS, xStaff);
        if rDocReltmp.IsEmpty then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckIT4GDoc(rPT: Record "LSC POS Transaction"; var retText: Text): boolean;
    var
        rDoc: Record "IT4G-LS Document";
        lblMissingDocCode: label 'Missing Document Code';
        lblPostTrans: label 'Post Transaction?';
        lblPostCancelled: Label 'Posting Cancelled!!!';
        lblCustomerMandatory: Label 'Customer No. is Mandatory!!!';
        lblPostCodeMandatory: Label 'You can not Post document without Document Code!!!';
        lblMissingLocation: Label 'You can not Post document without Location Code!!!';
    begin
        retText := '';
        if rPT."Entry Status" <> rPT."Entry Status"::" " then exit(True);

        if rPT."Document Code" = '' then begin
            retText := lblPostCodeMandatory;
            exit(false);
        end;
        if rDoc."Customer Mandatory" then
            if rPT."Customer No." = '' then begin
                retText := lblCustomerMandatory;
                exit(false);
            end;
        if not rDoc.get(rPT."Document Code") then begin
            retText := lblMissingDocCode;
            exit(false);
        end;
        If rPT."Location Code" = '' then begin
            retText := lblMissingDocCode;
            exit(false);
        end;
        if rDoc."Confirm Post" then
            if not cC.ConfirmBeep(lblPostTrans) then begin
                retText := lblPostCancelled;
                exit(false);
            end;
        exit(true);
    end;

    procedure CreateLSTaxSignature(pTransHeader: Record "LSC Transaction Header"; pTaxFree: Boolean) rSignature: Text[1000];
    var
        lRetailSetup: Record "LSC Retail Setup";
        lCompanyInfo: Record "Company Information";
        lStartSymbols: Label '"<%SL;"';
        lEndSymbols: Label '>';
        lSeparator: Label '";"';
        lCustomer: Record Customer;
        lTransSalesEntry: Record "LSC Trans. Sales Entry";
        lPOSVATCode: Record "LSC POS VAT Code";
        lNetAmount: array[5] of Decimal;
        lVATAmount: array[4] of Decimal;
        lTotalAmount: Decimal;
        lErr001: TextConst ELL = 'Δεν έχει οριστεί %1 για %2: %3', ENU = '%1 not set for %2: %3';
        lInfocode: Record "IT4G-LS Document";
        lInfocodePrinterSetup: Record "IT4G-Doc. Series Printer Setup";
        rPOS: Record "LSC POS Terminal";
    begin
        rPOS.GET(pTransHeader."POS Terminal No.");

        CASE rPOS."Fiscal Printer Software" OF
            rPOS."Fiscal Printer Software"::SignPro:
                EXIT(TaxSignature_SignPro(pTransHeader, pTaxFree));
            rPOS."Fiscal Printer Software"::TaxSpooler:
                EXIT(TaxSignature_TaxSpooler(pTransHeader, pTaxFree));
            ELSE
                EXIT('');
        END;
    end;

    procedure TaxSignature_SignPro(pTransHeader: Record "LSC Transaction Header"; pTaxFree: Boolean) rSignature: Text[1000];
    var
        lRetailSetup: Record "LSC Retail Setup";
        lCompanyInfo: Record "Company Information";
        lStartSymbols: Label '"<%SL;"';
        lEndSymbols: Label '>';
        lSeparator: Label '";"';
        lCustomer: Record Customer;
        lTransSalesEntry: Record "LSC Trans. Sales Entry";
        lPOSVATCode: Record "LSC POS VAT Code";
        lNetAmount: array[5] of Decimal;
        lVATAmount: array[4] of Decimal;
        lTotalAmount: Decimal;
        lErr001: TextConst ELL = 'Δεν έχει οριστεί %1 για %2: %3', ENU = '%1 not set for %2: %3';
        lInfocode: Record "IT4G-LS Document";
        lInfocodePrinterSetup: Record "IT4G-Doc. Series Printer Setup";
    begin
        lRetailSetup.GET();

        lCompanyInfo.GET;

        rSignature := lStartSymbols;

        //#1  ΑΦΜ ΕΚΔΟΤΗ
        rSignature += lCompanyInfo."VAT Registration No." + lSeparator;

        //#2  ΑΦΜ Παραλήπτη
        IF lCustomer.GET(pTransHeader."Customer No.") THEN
            rSignature += lCustomer."VAT Registration No." + lSeparator
        ELSE
            rSignature += lSeparator;

        //#3Αριθμός Κάρτας Αποδείξεων Πελάτη
        rSignature += lSeparator;

        rSignature += FORMAT(pTransHeader.Date, 0, '<Year4><Month,2><Day,2>') +
                    FORMAT(pTransHeader.Time, 0, '<Hours24><Minutes,2>') + lSeparator;   //#4Ημερομηνία και Ώρα

        //#5Περιγραφή Παραστατικού
        IF pTaxFree THEN
            rSignature += '#22' + lSeparator
        ELSE
            rSignature += lSeparator;   //Document Type

        rSignature += lSeparator;
        rSignature += lSeparator;
        rSignature += lSeparator;

        //#6Σειρά Θεώρησης
        IF lInfocode.GET(pTransHeader."Document Code") AND
          lInfocodePrinterSetup.GET(lInfocodePrinterSetup."Data Type"::Series, lInfocode."Series Document", pTransHeader."Store No.", pTransHeader."POS Terminal No.")
          AND (lInfocodePrinterSetup."Tax Printer Series" <> '') THEN
            rSignature += lInfocodePrinterSetup."Tax Printer Series" + lSeparator
        ELSE
            rSignature += pTransHeader."Post Series" + lSeparator;  //Document Series

        //#7Αριθμός Παραστατικού
        rSignature += COPYSTR(pTransHeader."Document No.", STRLEN(pTransHeader."Post Series") + 2) + lSeparator;  //Document No.

        lTransSalesEntry.SETRANGE("Store No.", pTransHeader."Store No.");
        lTransSalesEntry.SETRANGE("POS Terminal No.", pTransHeader."POS Terminal No.");
        lTransSalesEntry.SETRANGE("Transaction No.", pTransHeader."Transaction No.");
        IF lTransSalesEntry.FINDSET THEN
            REPEAT
                lPOSVATCode.GET(lTransSalesEntry."VAT Code");
                CASE lPOSVATCode."Tax Printer VAT Category" OF
                    lPOSVATCode."Tax Printer VAT Category"::A,
                    lPOSVATCode."Tax Printer VAT Category"::B,
                    lPOSVATCode."Tax Printer VAT Category"::C,
                    lPOSVATCode."Tax Printer VAT Category"::D:
                        BEGIN
                            lNetAmount[lPOSVATCode."Tax Printer VAT Category"] += -lTransSalesEntry."Net Amount";
                            lVATAmount[lPOSVATCode."Tax Printer VAT Category"] += -lTransSalesEntry."VAT Amount";
                        END;
                    lPOSVATCode."Tax Printer VAT Category"::E:
                        ;
                    ELSE
                        ERROR(lErr001, lPOSVATCode.FIELDCAPTION("Tax Printer VAT Category"), lPOSVATCode.FIELDCAPTION("VAT Code"), lPOSVATCode."VAT Code");
                END;
            UNTIL lTransSalesEntry.NEXT = 0;

        //#8Καθαρό Ποσό Α
        rSignature += FORMAT(lNetAmount[1], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount A
        //#9Καθαρό Ποσό Β
        rSignature += FORMAT(lNetAmount[2], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount B
        //#10Καθαρό Ποσό Γ
        rSignature += FORMAT(lNetAmount[3], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount C
        //#11Καθαρό Ποσό Δ
        rSignature += FORMAT(lNetAmount[4], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount D
        //#12Καθαρό Ποσό Ε
        rSignature += FORMAT(lNetAmount[5], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount E

        //#13ΦΠΑ Α
        rSignature += FORMAT(lVATAmount[1], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount A
        //#14ΦΠΑ Β
        rSignature += FORMAT(lVATAmount[2], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount B
        //#15ΦΠΑ Γ
        rSignature += FORMAT(lVATAmount[3], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount C
        //#16ΦΠΑ Δ
        rSignature += FORMAT(lVATAmount[4], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount D

        //#17Γενικό Σύνολο Παρ/κού
        rSignature += FORMAT(-pTransHeader."Gross Amount", 0, '<Precision,2:2><Precision,2:2><Standard Format,9>') + lSeparator;   //Gross Amount
        //#18Κωδικός νομίσματος
        rSignature += '0' + lEndSymbols;   //For Euro=0 , for other currencies use ISO code
    end;

    procedure TaxSignature_TaxSpooler(pTransHeader: Record "LSC Transaction Header"; pTaxFree: Boolean) rSignature: Text[1000];
    var
        lRetailSetup: Record "LSC Retail Setup";
        lCompanyInfo: Record "Company Information";
        lStartSymbols: Label '"<%SL;"';
        lEndSymbols: Label '>';
        lSeparator: Label '";"';
        lCustomer: Record Customer;
        lTransSalesEntry: Record "LSC Trans. Sales Entry";
        lPOSVATCode: Record "LSC POS VAT Code";
        lNetAmount: array[5] of Decimal;
        lVATAmount: array[4] of Decimal;
        lTotalAmount: Decimal;
        lErr001: TextConst ELL = 'Δεν έχει οριστεί %1 για %2: %3', ENU = '%1 not set for %2: %3';
        rI: Record "IT4G-LS Document";
        lInfocode: Record "IT4G-LS Document";
        lInfocodePrinterSetup: Record "IT4G-Doc. Series Printer Setup";
    begin

        lCompanyInfo.GET;

        rSignature := lStartSymbols;

        //#1  ΑΦΜ ΕΚΔΟΤΗ
        rSignature += lCompanyInfo."VAT Registration No." + lSeparator;

        //#2  ΑΦΜ Παραλήπτη
        IF lCustomer.GET(pTransHeader."Customer No.") THEN
            rSignature += lCustomer."VAT Registration No." + lSeparator
        ELSE
            rSignature += lSeparator;

        //#3Αριθμός Κάρτας Αποδείξεων Πελάτη
        rSignature += lSeparator;

        rSignature += FORMAT(pTransHeader.Date, 0, '<Year4><Month,2><Day,2>') +
                    FORMAT(pTransHeader.Time, 0, '<Hours24><Minutes,2>') + lSeparator;   //#4Ημερομηνία και Ώρα

        //#5Περιγραφή Παραστατικού

        rI.GET(pTransHeader."Document Code");
        IF pTaxFree THEN
            rSignature += '#22' + lSeparator
        ELSE
            rSignature += rI."Tax Printer Doc. Code" + lSeparator;   //Document Type

        //#6Σειρά Θεώρησης
        IF lInfocode.GET(pTransHeader."Document Code") AND
          lInfocodePrinterSetup.GET(lInfocodePrinterSetup."Data Type"::Series, lInfocode."Series Document", pTransHeader."Store No.", pTransHeader."POS Terminal No.")
          AND (lInfocodePrinterSetup."Tax Printer Series" <> '') THEN
            rSignature += lInfocodePrinterSetup."Tax Printer Series" + lSeparator
        ELSE
            rSignature += pTransHeader."Post Series" + lSeparator;  //Document Series

        //#7Αριθμός Παραστατικού
        //rSignature+=COPYSTR(pTransHeader."Document No.",STRLEN(pTransHeader."Post Series")+2)+lSeparator;  //Document No.

        rSignature += pTransHeader."Document No." + lSeparator;

        lTransSalesEntry.SETRANGE("Store No.", pTransHeader."Store No.");
        lTransSalesEntry.SETRANGE("POS Terminal No.", pTransHeader."POS Terminal No.");
        lTransSalesEntry.SETRANGE("Transaction No.", pTransHeader."Transaction No.");
        IF lTransSalesEntry.FINDSET THEN
            REPEAT
                lPOSVATCode.GET(lTransSalesEntry."VAT Code");
                CASE lPOSVATCode."Tax Printer VAT Category" OF
                    lPOSVATCode."Tax Printer VAT Category"::A,
                    lPOSVATCode."Tax Printer VAT Category"::B,
                    lPOSVATCode."Tax Printer VAT Category"::C,
                    lPOSVATCode."Tax Printer VAT Category"::D:
                        BEGIN
                            lNetAmount[lPOSVATCode."Tax Printer VAT Category"] += -lTransSalesEntry."Net Amount";
                            lVATAmount[lPOSVATCode."Tax Printer VAT Category"] += -lTransSalesEntry."VAT Amount";
                        END;
                    lPOSVATCode."Tax Printer VAT Category"::E:
                        ;
                    ELSE
                        ERROR(lErr001, lPOSVATCode.FIELDCAPTION("Tax Printer VAT Category"), lPOSVATCode.FIELDCAPTION("VAT Code"), lPOSVATCode."VAT Code");
                END;
            UNTIL lTransSalesEntry.NEXT = 0;

        //#8Καθαρό Ποσό Α
        rSignature += FORMAT(lNetAmount[1], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount A
        //#9Καθαρό Ποσό Β
        rSignature += FORMAT(lNetAmount[2], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount B
        //#10Καθαρό Ποσό Γ
        rSignature += FORMAT(lNetAmount[3], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount C
        //#11Καθαρό Ποσό Δ
        rSignature += FORMAT(lNetAmount[4], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount D
        //#12Καθαρό Ποσό Ε
        rSignature += FORMAT(lNetAmount[5], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //Net Amount E

        //#13ΦΠΑ Α
        rSignature += FORMAT(lVATAmount[1], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount A
        //#14ΦΠΑ Β
        rSignature += FORMAT(lVATAmount[2], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount B
        //#15ΦΠΑ Γ
        rSignature += FORMAT(lVATAmount[3], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount C
        //#16ΦΠΑ Δ
        rSignature += FORMAT(lVATAmount[4], 0, '<Precision,2:2><Standard Format,9>') + lSeparator;   //VAT Amount D

        //#17Γενικό Σύνολο Παρ/κού
        rSignature += FORMAT(-pTransHeader."Gross Amount", 0, '<Precision,2:2><Precision,2:2><Standard Format,9>') + lSeparator;   //Gross Amount
        //#18Κωδικός νομίσματος
        rSignature += '0' + lEndSymbols;   //For Euro=0 , for other currencies use ISO code
    end;

}
