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
    begin
        rDC.get(xDocCode);
        rPT."Document Code" := rDC."Code";
        /*
                rPT."To Location" := 'To Loc';
                rPT."To Store" := 'To Store';
                rPT."From Location" := 'From Loc';
                rPT."From Store" := 'From Sto';
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
        if rDoc."Confirm Post" then
            if not cC.ConfirmBeep(lblPostTrans) then begin
                retText := lblPostCancelled;
                exit(false);
            end;
        exit(true);
    end;
}
