report 50026 "IT4G-Retail Receipt Themal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IT4G-Retail Receipt Themal.rdlc';
    ApplicationArea = All;
    AdditionalSearchTerms = 'POS thermal Receipt';
    UsageCategory = Administration;


    dataset
    {
        dataitem("Transaction Header"; "LSC Transaction Header")
        {
            RequestFilterFields = "Store No.", "POS Terminal No.", "Transaction No.", "Receipt No.", "Document No.";
            column(etxt; cPF.CreateLSTaxSignature("Transaction Header", FALSE))
            {
            }
            column(ReceiptNoBarcode; ReceiptNoBarcode)
            {
            }
            column(CustomerPrintStatus; CustomerPrintStatus)
            {
            }
            column(ChooseImage; ChooseImage)
            {
            }
            column(TopText1; TopText[1])
            {
            }
            column(TopText2; TopText[2])
            {
            }
            column(TopText3; TopText[3])
            {
            }
            column(TopText4; TopText[4])
            {
            }
            column(TopText5; TopText[5])
            {
            }
            column(CompAddress; CompAddress)
            {
            }
            column(CompCity; CompCity)
            {
            }
            column(CompPostCode; CompPostCode)
            {
            }
            column(CompVATRegNo; CompVATRegNo)
            {
            }
            column(CompTaxOffice; CompTaxOffice)
            {
            }
            column(CompPhoneNo; CompPhoneNo)
            {
            }
            column(DefaultReceipt; DefaultReceipt)
            {
            }
            column(CustName; CustName)
            {
            }
            column(CustVAT; CustVAT)
            {
            }
            column(CustAddr; CustAddr)
            {
            }
            column(CustPhone; CustPhone)
            {
            }
            column(CustProfession; CustProfession)
            {
            }
            column(CustPostCode; CustPostCode)
            {
            }
            column(CustTaxOffice; CustTaxOffice)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(ReceiptText; ReceiptText)
            {
            }
            column(DateText; DateText)
            {
            }
            column(InfoText; InfoText)
            {
            }
            column(InfoText2; InfoText2)
            {
            }
            column(DocumentType; gInfocode.Description)
            {
            }
            column(VATText; VatText)
            {
            }
            column(mCardNo; mCardNo)
            {
            }
            column(mCardPoints; mCardPoints)
            {
            }
            column(mTodaysPoints; mTodaysPoints)
            {
            }
            column(mTotalPoints; mTotalPoints)
            {
            }
            column(mBurnedPoints; mBurnedPoints)
            {
            }
            column(mNextDiscount; mNextDiscount)
            {
            }
            column(gWithCustDetails; gWithCustDetails)
            {
            }
            column(RCTxt005; RCTxt005)
            {
            }
            column(ExtendedReceiptText1; ExtendedReceiptText[1])
            {
            }
            column(ExtendedReceiptText2; ExtendedReceiptText[2])
            {
            }
            column(ExtendedReceiptText3; ExtendedReceiptText[3])
            {
            }
            column(ExtendedReceiptText4; ExtendedReceiptText[4])
            {
            }
            column(ExtendedReceiptText5; ExtendedReceiptText[5])
            {
            }
            column(ExtendedReceiptText6; ExtendedReceiptText[6])
            {
            }
            column(ExtendedReceiptText7; ExtendedReceiptText[7])
            {
            }
            column(ExtendedReceiptText8; ExtendedReceiptText[8])
            {
            }
            column(ExtendedReceiptText9; ExtendedReceiptText[9])
            {
            }
            column(ExtendedReceiptText10; ExtendedReceiptText[10])
            {
            }
            column(IsBold1; IsBold[1])
            {
            }
            column(IsBold2; IsBold[2])
            {
            }
            column(IsBold3; IsBold[3])
            {
            }
            column(IsBold4; IsBold[4])
            {
            }
            column(IsBold5; IsBold[5])
            {
            }
            column(IsBold6; IsBold[6])
            {
            }
            column(IsBold7; IsBold[7])
            {
            }
            column(IsBold8; IsBold[8])
            {
            }
            column(IsBold9; IsBold[9])
            {
            }
            column(IsBold10; IsBold[10])
            {
            }
            column(CompName; CompName)
            {
            }
            column(CompProfession; CompProfession)
            {
            }
            column(StoreName; StoreName)
            {
            }
            column(StoreAddress; StoreAddress)
            {
            }
            column(StoreCity; StoreCity)
            {
            }
            column(StorePostCode; StorePostCode)
            {
            }
            column(StorePhone; StorePhone)
            {
            }
            column(HasReceiptText; HasReceiptText)
            {
            }
            column(StoreAddress2; StoreAddress2)
            {
            }
            column(CompAddress2; CompAddress2)
            {
            }
            column(MemberCardNo; "Transaction Header"."Member Card No.")
            {
            }
            column(recTmpBlob1_Blob; recBC1.Picture)
            {
            }
            column(recTmpBlob2_Blob; recBC2.Picture)
            {
            }
            column(bcT; bcT)
            {
            }
            dataitem(Integer4; Integer)
            {
                column(Temp3DescrCoupon; Temp3.Description)
                {
                }
                column(Temp3EntryNo; Temp3.Code)
                {
                }
                column(Temp3Text2; Temp3."Description 2")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF Integer4.Number = 1 THEN
                        Temp3.FINDSET
                    ELSE
                        Temp3.NEXT;
                end;

                trigger OnPreDataItem();
                begin
                    Temp3.RESET;
                    Integer4.SETRANGE(Number, 1, Temp3.COUNT);
                end;
            }
            dataitem("Trans. Sales Entry"; "LSC Trans. Sales Entry")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No."),
                               "Store No." = FIELD("Store No."),
                               "POS Terminal No." = FIELD("POS Terminal No.");
                DataItemTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.", "Line No.");
                column(ItemCode; ItemCode)
                {
                }
                column(ItemDescription; ItemDescription)
                {
                }
                column(LineNo; LineNo)
                {
                }
                column(LineQty; LineQty)
                {
                }
                column(LineAmt; LineAmt)
                {
                }
                column(LineVAT; LineVAT)
                {
                }
                column(LineDisc; LineDisc)
                {
                }
                column(LineDiscPerCent; "LineDisc%")
                {
                }
                column(TotalQty; TotalQty)
                {
                }
                column(LineStartValue; LineStartValue)
                {
                }
                column(Quantity_; "Trans. Sales Entry".Quantity * -Sign)
                {
                }

                trigger OnAfterGetRecord();
                var
                    Item: Record Item;
                    VATCode: Record "LSC POS VAT Code";
                    lUnitofMeasure: Record "Unit of Measure";
                begin
                    ItemCode := '';
                    IF PrintItemNo = 1 THEN
                        ItemCode += "Trans. Sales Entry"."Item No."
                    ELSE
                        IF PrintItemNo = 2 THEN
                            ItemCode += "Trans. Sales Entry"."Barcode No.";

                    IF ItemCode = '' THEN
                        ItemCode += "Trans. Sales Entry"."Item No." + "Trans. Sales Entry"."Variant Code";


                    IF Item.GET("Trans. Sales Entry"."Item No.") THEN
                        ItemDescription := Item.Description;
                    IF VATCode.GET("Trans. Sales Entry"."VAT Code") THEN
                        LineVAT := FORMAT(VATCode."VAT %") + ' %';

                    IF lUnitofMeasure.GET("Trans. Sales Entry"."Unit of Measure") THEN;
                    LineNo := "Trans. Sales Entry"."Line No.";
                    LineQty := FORMAT("Trans. Sales Entry".Quantity * -Sign) + ' ' + lUnitofMeasure.Description;
                    LineAmt := "Trans. Sales Entry"."Total Rounded Amt." * -Sign;
                    LineDisc := "Trans. Sales Entry"."Discount Amount" * -Sign;
                    LineStartValue := ABS(("Trans. Sales Entry".Price)); //RCID30112017.n
                    IF ("Trans. Sales Entry".Quantity * "Trans. Sales Entry".Price) <> 0 THEN
                        "LineDisc%" := FORMAT((ROUND("Trans. Sales Entry"."Discount Amount" / ("Trans. Sales Entry".Quantity * "Trans. Sales Entry".Price) * 100, 0.01, '<')) * -Sign) + ' %'
                    ELSE
                        CLEAR("LineDisc%");

                    TotalQty += ("Trans. Sales Entry".Quantity * -Sign);

                    VatPercentage := 1;
                    IF ("Trans. Sales Entry"."VAT Amount" <> 0) AND ("Trans. Sales Entry"."VAT Code" <> '') THEN
                        IF POSVATCode.GET("Trans. Sales Entry"."VAT Code") THEN
                            VatPercentage += POSVATCode."VAT %" / 100;
                    Temp2.SETRANGE("Item No.", "Trans. Sales Entry"."VAT Code");
                    IF Temp2.FINDFIRST THEN BEGIN
                        Temp2."VAT Amount" += "Trans. Sales Entry"."VAT Amount";
                        Temp2."Net Amount" += "Trans. Sales Entry"."Net Amount";
                        Temp2."Total Rounded Amt." += "Trans. Sales Entry"."Total Rounded Amt.";
                        Temp2.MODIFY;
                    END ELSE BEGIN
                        Temp2.INIT;
                        Temp2."Line No." += 1;
                        Temp2."Item No." := "Trans. Sales Entry"."VAT Code";
                        Temp2."VAT Amount" := "Trans. Sales Entry"."VAT Amount";
                        Temp2."Net Amount" := "Trans. Sales Entry"."Net Amount";
                        Temp2."Total Rounded Amt." := "Trans. Sales Entry"."Total Rounded Amt.";
                        Temp2."Store No." := '1';
                        Temp2.INSERT;
                    END;
                end;
            }
            dataitem(Payments; Integer)
            {
                DataItemTableView = SORTING(Number);
                UseTemporary = false;
                column(TenderAMount2; ROUND(Temp."Amount Tendered", 0.01))
                {
                }
                column(TenderType2; 'To be fixed')
                {
                }
                column(EntryNo; Temp."Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF Payments.Number = 1 THEN
                        Temp.FINDSET
                    ELSE
                        Temp.NEXT;
                end;

                trigger OnPreDataItem();
                begin
                    Temp.RESET;
                    Payments.SETRANGE(Number, 1, Temp.COUNT);
                end;
            }
            dataitem(Integer3; Integer)
            {
                UseTemporary = false;
                column(Temp2dec01; ROUND(Temp2."Net Amount", 0.01))
                {
                }
                column(Temp2dec02; ROUND(Temp2."VAT Amount", 0.01))
                {
                }
                column(Temp2dec03; ROUND(Temp2."Total Rounded Amt.", 0.01))
                {
                }
                column(Temp2code3; Temp2."Item No.")
                {
                }
                column(Temp2int01; Temp2."Store No.")
                {
                }
                column(NetAmt; ABS(Temp."Amount Tendered"))
                {
                }
                column(DiscTotal; ABS("Transaction Header"."Total Discount" + "Transaction Header"."Discount Amount"))
                {
                }
                column(GrandTotalItemVAT; ABS(("Transaction Header"."Gross Amount" - "Transaction Header"."Net Amount")))
                {
                }
                column(TotLine; ABS("Transaction Header".Payment))
                {
                }
                column(Temp2int02; Temp2."Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF Integer3.Number = 1 THEN
                        Temp2.FINDSET
                    ELSE
                        Temp2.NEXT;
                end;

                trigger OnPreDataItem();
                begin
                    Temp2.RESET;
                    Integer3.SETRANGE(Number, 1, Temp2.COUNT);
                end;
            }
            dataitem("POS Terminal Receipt Text"; "LSC POS Terminal Receipt Text")
            {
                DataItemTableView = WHERE(Type = FILTER(<> 5));
                UseTemporary = true;
                column(Receipt_Text; "POS Terminal Receipt Text"."Receipt Text")
                {
                }
                column(TermReceipt_Bold; "POS Terminal Receipt Text".Bold)
                {
                }
                column(Top_Bottom; Top_Bottom)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    HasReceiptText := TRUE; //RCEX.n
                    Top_Bottom := "POS Terminal Receipt Text".Bold;
                end;

                trigger OnPreDataItem();
                begin
                    //"POS Terminal Receipt Text".COPYFILTERS(POSText); //RCEX.n
                end;
            }

            trigger OnAfterGetRecord();
            var
                lTransPointEntry: Record "LSC Trans. Point Entry";
                POSTerminalReceiptTextL: Record "LSC POS Terminal Receipt Text";
                c: Integer;
                RemPoints: Decimal;
            begin
                //INIT GLOBALS
                Temp.RESET;
                Temp.DELETEALL;

                Temp2.RESET;
                Temp2.DELETEALL;

                Temp3.RESET;
                Temp3.DELETEALL;

                Store.GET("Transaction Header"."Store No.");
                PosTerm.GET("Transaction Header"."POS Terminal No.");
                IF NOT PosSetup.GET(PosTerm."Hardware Profile") THEN
                    PosSetup.GET(Store."Hardware Profile");

                bcT := 'T' + FORMAT(PosTerm."Receipt Barcode ID", 4, '<Integer,4><Filler Character,0>') +
                        FORMAT("Transaction No.", 9, '<Integer,9><Filler Character,0>');

                cduBarcodeMgt.EncodeCode128(bcT, 2, FALSE, recTmpBlob1);
                recBC1.Picture.CreateOutStream(streamOut);
                recTmpBlob1.CreateInStream(streamIn);
                CopyStream(streamOut, streamIn);

                cduBarcodeMgt.EncodeCode128("Document No.", 2, FALSE, recTmpBlob2);
                recBC2.Picture.CreateOutStream(streamOut);
                recTmpBlob2.CreateInStream(streamIn);
                CopyStream(streamOut, streamIn);

                StoreName := Store.Name;
                StoreAddress := Store.Address;
                StoreAddress2 := Store."Address 2";
                StoreCity := Store.City;
                StorePostCode := Store."Post Code";
                StorePhone := Store."Phone No.";

                if rRC.GET(Store."Responsibility Center") then begin
                    CompAddress := rRC.Address;
                    CompAddress2 := rRC."Address 2";
                    CompCity := rRC.City;
                    CompPostCode := rRC."Post Code";
                    //                CompVATRegNo := rRC."VAT Registration No.";
                    //                CompTaxOffice := rRC."Tax Office";
                    CompPhoneNo := rRC."Phone No.";
                    CompName := rRC.Name;
                    //                CompProfession := rRC.Profession;
                end;

                IF "Transaction Header"."Sale Is Return Sale" THEN
                    Sign := -1
                ELSE
                    Sign := 1;

                etxt := '<%SL ;094282416;;;;;;;222;;000374;0.00;17.70;16.26;0.00;0.00;0.00;2.30;3.74;0.00;40.00;EUR;>';

                ReceiptNoBarcode := '*' + COPYSTR("Transaction Header"."Receipt No.", 7) + '*'; //RCIDTEST.n

                //                IF gInfocode.GET("Transaction Header"."Document Code") THEN BEGIN
                //                    gWithCustDetails := gInfocode."Customer Requirement" <> gInfocode."Customer Requirement"::None;
                //                END;

                CustomerPrintStatus := 0;

                IF Customer.GET("Transaction Header"."Customer No.") THEN BEGIN
                    CustomerPrintStatus := 1;
                    CustName := Customer.Name;
                    CustAddr := Customer.Address;
                    CustPostCode := Customer."Post Code";
                    CustVAT := Customer."VAT Registration No.";
                    //                    CustTaxOffice := Customer."Tax Office";
                    CustPhone := Customer."Phone No.";
                    //                    CustProfession := Customer.Profession;
                    gWithCustDetails := TRUE;
                END ELSE BEGIN
                    TransInfoEntry.RESET;
                    TransInfoEntry.SETRANGE("Store No.", "Transaction Header"."Store No.");
                    TransInfoEntry.SETRANGE("POS Terminal No.", "Transaction Header"."POS Terminal No.");
                    TransInfoEntry.SETRANGE("Transaction No.", "Transaction Header"."Transaction No.");
                    TransInfoEntry.SETRANGE(Infocode, 'CUST_NAME');
                    IF TransInfoEntry.FINDFIRST THEN
                        CustName := TransInfoEntry.Information;
                    TransInfoEntry.SETRANGE(Infocode, 'CUST_TEL');
                    IF TransInfoEntry.FINDFIRST THEN
                        CustPhone := TransInfoEntry.Information;
                    TransInfoEntry.SETRANGE(Infocode, 'CUST_CITY');
                    IF TransInfoEntry.FINDFIRST THEN
                        CustProfession := TransInfoEntry.Information;
                    TransInfoEntry.SETRANGE(Infocode, 'CUST_ADDR');
                    IF TransInfoEntry.FINDFIRST THEN
                        CustAddr := TransInfoEntry.Information;
                    IF (CustName <> '') OR (CustPhone <> '') OR (CustProfession <> '') OR (CustAddr <> '') THEN BEGIN
                        CustomerPrintStatus := 2;
                        gWithCustDetails := TRUE;
                    END;
                END;

                //Staff Name
                IF Staff.GET("Transaction Header"."Staff ID") THEN;

                //Info Texts
                ReceiptText := 'Αρ. Παραστατικού: ' + FORMAT("Transaction Header"."Document No.");
                DateText := 'Ημερομηνία: ' + FORMAT("Transaction Header".Date) + ' ' + FORMAT("Transaction Header".Time);
                InfoText := 'Χειριστής: ' + FORMAT(Staff."Name on Receipt");
                InfoText2 := 'Τερματικό: ' + FORMAT("Transaction Header"."POS Terminal No.");
                //Receipt Text Printing
                POSText.RESET;
                IF PosTerm."Receipt Setup Location" = PosTerm."Receipt Setup Location"::Terminal THEN BEGIN
                    POSText.SETRANGE(Relation, POSText.Relation::Terminal);
                    POSText.SETRANGE(Number, "Transaction Header"."POS Terminal No.");
                END ELSE BEGIN
                    POSText.SETRANGE(Relation, POSText.Relation::Store);
                    POSText.SETRANGE(Number, "Transaction Header"."Store No.");
                END;
                //rcex
                IF POSText.FINDSET THEN
                    REPEAT
                        "POS Terminal Receipt Text" := POSText;
                        IF "POS Terminal Receipt Text".Type = "POS Terminal Receipt Text".Type::Bottom THEN
                            "POS Terminal Receipt Text".Bold := TRUE
                        //   Top_Bottom := TRUE
                        ELSE
                            IF "POS Terminal Receipt Text".Type = "POS Terminal Receipt Text".Type::Top THEN
                                "POS Terminal Receipt Text".Bold := FALSE;
                        //    Top_Bottom := FALSE;
                        "POS Terminal Receipt Text".INSERT;
                    UNTIL POSText.NEXT = 0;
                //rcex
                //Var Text
                VatText := 'Ανάλυση Υπολογισμού Φ.Π.Α.';
                TransInfo_2.RESET;
                TransInfo_2.SETRANGE("Store No.", "Store No.");
                TransInfo_2.SETRANGE("POS Terminal No.", "POS Terminal No.");
                TransInfo_2.SETRANGE("Transaction No.", "Transaction No.");
                TransInfo_2.SETRANGE("Transaction Type", TransInfo_2."Transaction Type"::"Sales Entry");
                TransInfo_2.SETRANGE(Infocode, Text021);
                IF TransInfo_2.FINDFIRST THEN BEGIN
                    InfoSub.GET(TransInfo_2.Infocode, TransInfo_2.Information);
                    VatText += ' - (Απαλλαγή Φ.Π.Α. Βάση ';
                    VatText += InfoSub.Description;
                    VatText += 'Α.Υ.Ο.)';
                END;
                /*
                //Header Text
                i := 1;
                POSText.SETRANGE(Type,POSText.Type::Top);
                
                IF POSText.FINDSET THEN
                  REPEAT
                    TopText[i] := POSText."Receipt Text";
                    i +=  1;
                  UNTIL (POSText.NEXT = 0) OR (i = 12);
                
                //Trailer Text
                i := 1;
                POSText.SETRANGE(Type,POSText.Type::Bottom);
                
                IF POSText.FINDSET THEN
                  REPEAT
                    BotText[i] := POSText."Receipt Text";
                    i +=  1;
                  UNTIL (POSText.NEXT = 0) OR (i = 6);
                */
                //PrintItemNo
                CLEAR(PrintItemNo);
                IF PosTerm."Receipt Setup Location" = PosTerm."Receipt Setup Location"::Terminal THEN BEGIN
                    CASE PosTerm."Item No. on Receipt" OF
                        PosTerm."Item No. on Receipt"::"Item Number":
                            PrintItemNo := 1;
                        PosTerm."Item No. on Receipt"::"Barcode/Item Number":
                            PrintItemNo := 2;
                    END;
                END ELSE BEGIN
                    CASE Store."Item No. on Receipt" OF
                        Store."Item No. on Receipt"::"Item Number":
                            PrintItemNo := 1;
                        Store."Item No. on Receipt"::"Barcode/Item Number":
                            PrintItemNo := 2;
                    END;
                END;
                //Total
                TotalAmt := "Transaction Header".Payment;

                //Tender Types
                TranPaymEntry.RESET;
                TranPaymEntry.SETRANGE("Store No.", "Store No.");
                TranPaymEntry.SETRANGE("POS Terminal No.", "POS Terminal No.");
                TranPaymEntry.SETRANGE("Transaction No.", "Transaction No.");
                IF TranPaymEntry.FINDSET THEN BEGIN
                    REPEAT
                        Temp.SETRANGE("Tender Type", TranPaymEntry."Tender Type");
                        IF TranPaymEntry."Change Line" THEN
                            Temp.SETRANGE("Store No.", '1')
                        ELSE
                            Temp.SETRANGE("Store No.", '0');
                        IF Temp.FINDFIRST THEN BEGIN
                            Temp."Amount Tendered" += TranPaymEntry."Amount Tendered";
                            Temp.MODIFY;
                        END ELSE BEGIN
                            Temp.INIT;
                            Temp."Line No." += 1;
                            "Trans. Sales Entry"."Line No." := 0;
                            Temp."Tender Type" := TranPaymEntry."Tender Type";
                            Temp."Amount Tendered" := (ROUND((TranPaymEntry."Amount Tendered" * Sign), 0.01));
                            Temp."Amount in Currency" := (ROUND(("Transaction Header"."Net Amount" * Sign), 0.01));

                            IF TranPaymEntry."Change Line" THEN BEGIN
                                Temp."Store No." := '1';
                                //                                Temp.Text1 := 'Ρέστα';
                            END ELSE BEGIN
                                Temp."Store No." := '0';
                                Tender.GET(TranPaymEntry."Store No.", TranPaymEntry."Tender Type");
                                //                                Temp.Text1 := Tender.Description;
                            END;
                            Temp.INSERT;
                        END;
                    UNTIL TranPaymEntry.NEXT = 0;
                END;

                //Coupon Descr
                mTransCouponEntry.RESET;
                mTransCouponEntry.SETRANGE("Coupon Function", mTransCouponEntry."Coupon Function"::Use);
                mTransCouponEntry.SETRANGE("Receipt No.", "Transaction Header"."Receipt No.");
                IF mTransCouponEntry.FINDSET THEN BEGIN
                    REPEAT
                        mCouponHeader.RESET;
                        mCouponHeader.SETRANGE(mCouponHeader.Code, mTransCouponEntry."Coupon Code");
                        IF mCouponHeader.FINDSET THEN BEGIN
                            Temp3.INIT;
                            Temp3.Code := Incstr(Temp3.Code);
                            Temp3.Description := mCouponHeader.Description;
                            Temp3."Description 2" := 'T. ' + FORMAT(Temp3.Code);
                            Temp3.INSERT;
                        END;
                    UNTIL mTransCouponEntry.NEXT = 0;
                END;

                //RCKMRCAS-16561-J4Y5.sn
                CLEAR(mCardNo);
                CLEAR(mCardPoints);
                CLEAR(mTodaysPoints);
                CLEAR(mTotalPoints);
                CLEAR(mNextDiscount);
                CLEAR(ExtendedReceiptText);
                CLEAR(IsBold);
                IF "Transaction Header"."Member Card No." <> '' THEN BEGIN
                    IF mMembershipCard.GET("Transaction Header"."Member Card No.") THEN BEGIN
                        mCardNo := RCTxt000 + ' ' + mMembershipCard."Card No."; //RCKMRCAS-16561-J4Y5.n
                        mCardPoints := RCTxt001 + ' ' + FORMAT("Transaction Header"."Starting Point Balance");
                        RemPoints := "Transaction Header"."Starting Point Balance";
                    END;
                    IF lTransPointEntry.GET("Store No.", "POS Terminal No.", "Transaction No.", "Receipt No.", lTransPointEntry."Entry Type"::Sale, lTransPointEntry."Point Type"::Award) THEN BEGIN
                        mTodaysPoints := RCTxt002 + ' ' + FORMAT(lTransPointEntry.Points);
                        RemPoints += lTransPointEntry.Points;
                    END;
                    IF lTransPointEntry.GET("Store No.", "POS Terminal No.", "Transaction No.", "Receipt No.", lTransPointEntry."Entry Type"::Payment, lTransPointEntry."Point Type"::Other) THEN BEGIN
                        mBurnedPoints := xx0006 + ' ' + FORMAT(lTransPointEntry.Points);
                        RemPoints += lTransPointEntry.Points;
                    END;
                    mTotalPoints := RCTxt003 + FORMAT(RemPoints);

                    gTransCouponEntry.SETRANGE("Store No.", "Transaction Header"."Store No.");
                    gTransCouponEntry.SETRANGE("POS Terminal No.", "Transaction Header"."POS Terminal No.");
                    gTransCouponEntry.SETRANGE("Transaction No.", "Transaction Header"."Transaction No.");
                    gTransCouponEntry.SETRANGE("Coupon Function", gTransCouponEntry."Coupon Function"::Issue);
                    gTransCouponEntry.CALCSUMS("Issued Amount");
                    IF gTransCouponEntry."Issued Amount" <> 0 THEN
                        mNextDiscount := STRSUBSTNO(RCTxt004, gTransCouponEntry."Issued Amount")
                    ELSE
                        mNextDiscount := '';
                    //RCXS.er
                    /*
                                        POSTerminalReceiptTextL.RESET;
                                        POSTerminalReceiptTextL.SETFILTER("No.", '%1', '');
                                        POSTerminalReceiptTextL.SETRANGE(Relation, POSTerminalReceiptTextL.Relation::Store);
                                        POSTerminalReceiptTextL.SETRANGE(Number, "Store No.");
                                        POSTerminalReceiptTextL.SETRANGE(Type, POSTerminalReceiptTextL.Type::"5");
                                        IF POSTerminalReceiptTextL.FINDSET THEN BEGIN
                                            c := 1;
                                            REPEAT
                                                ExtendedReceiptText[c] := POSTerminalReceiptTextL."Receipt Text";
                                                IsBold[c] := POSTerminalReceiptTextL.Bold;
                                                c += 1;
                                            UNTIL ((POSTerminalReceiptTextL.NEXT = 0) OR (c = 11));
                                        END;
                      */
                END;

            end;

            trigger OnPreDataItem();
            begin
                IF COUNT <> 1 THEN
                    ERROR(ErrTxt01);
                HasReceiptText := FALSE //RCEX.n
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        lTotal = 'Σύνολο €'; lDiscount = 'Έκπτωση'; lCustomer = 'Στοιχεία Πελάτη'; label(lCustName; ELL = 'Όνομα: ',
                                                                                                ENU = 'Όνομα:')
        label(lCustAddr; ELL = '',
                        ENU = 'Διεύθ/ση:')
        lCustPostCode = 'Τ.Κ.:'; lCustVat = 'ΑΦΜ:'; lCustTaxOffice = 'ΔΟΥ:'; lCustPhoneNo = 'Αρ. Τηλεφώνου:'; lCustProf = 'Επάγγελμα:'; lCustCity = 'Πόλη:'; label(lVAT; ELL = 'ΦΠΑ',
                                                                                                                                                                  ENU = 'Φ.Π.Α.')
        label(lNetAmount; ELL = 'Καθαρή Αξία',
                         ENU = 'Καθαρή Αξία')
        lVatValue = 'Αξία ΦΠΑ'; lTotalValue = 'Συνολική Αξία €'; GoCosmosLbl = 'VOI & NOI CLUB'; PremClubLbl = '-------------';
    }

    trigger OnInitReport();
    begin
        TotalQty := 0;
    end;

    trigger OnPreReport();
    begin
        Temp2.RESET;
        Temp2.DELETEALL;

        Temp3.RESET;
        Temp3.DELETEALL;

        CompanyInfo.GET;
    end;

    var
        ErrTxt01: Label 'Πρεπει να επιλέξετε μία συναλλαγή.';
        Store: Record "LSC Store";
        PosSetup: Record "LSC POS Hardware Profile";
        PosTerm: Record "LSC POS Terminal";
        POSText: Record "LSC POS Terminal Receipt Text";
        TranPaymEntry: Record "LSC Trans. Payment Entry";
        Tender: Record "LSC Tender Type";
        Staff: Record "LSC Staff";
        DocumentType: Text;
        Customer: Record Customer;
        CustName: Text;
        CustVAT: Text;
        CustAddr: Text;
        CustPostCode: Text;
        CustPhone: Text;
        CustProfession: Text;
        CustTaxOffice: Text;
        Sign: Integer;
        etxt: Text;
        ReceiptNoBarcode: Text;
        TopText: array[11] of Text;
        BotText: array[6] of Text;
        ReceiptText: Text;
        DateText: Text;
        InfoText: Text;
        InfoText2: Text;
        TotalAmt: Decimal;
        i: Integer;
        PrintItemNo: Integer;
        ItemCode: Text;
        ItemDescription: Text;
        LineNo: Integer;
        LineQty: Text;
        LineAmt: Decimal;
        LineVAT: Text;
        LineDisc: Decimal;
        "LineDisc%": Text;
        DefaultReceipt: Boolean;
        gInfocode: Record "IT4G-LS Document";
        TransInfoEntry: Record "LSC Trans. Infocode Entry";
        CustomerPrintStatus: Integer;
        TotalQty: Decimal;
        Temp: Record "LSC Trans. Payment Entry" temporary;
        Temp2: Record "LSC Trans. Sales Entry" temporary;
        Temp3: Record "LSC Coupon Header" temporary;
        VatPercentage: Decimal;
        POSVATCode: Record "LSC POS VAT Code";
        VatText: Text;
        TransInfo_2: Record "LSC Trans. Infocode Entry";
        Text021: Label 'VATCHANGE';
        InfoSub: Record "LSC Information Subcode";
        mCouponHeader: Record "LSC Coupon Header";
        mTransCouponEntry: Record "LSC Trans. Coupon Entry";
        mMembershipCard: Record "LSC Membership Card";
        mCardNo: Text[120];
        //        PosFunc: Codeunit "LSC POS"
        mMemberAccountTemp: Record "LSC Member Account";
        mCardPoints: Text[120];
        CompanyInfo: Record "Company Information";
        CompAddress: Text[50];
        CompCity: Text[30];
        CompPostCode: Code[20];
        CompVATRegNo: Text[20];
        CompTaxOffice: Text[30];
        CompPhoneNo: Text[30];
        CompName: Text[50];
        CompProfession: Text[40];
        StoreName: Text[30];
        StoreAddress: Text[30];
        StoreCity: Text[30];
        StorePostCode: Code[20];
        StorePhone: Text[30];
        HasReceiptText: Boolean;
        Top_Bottom: Boolean;
        StoreAddress2: Text[30];
        CompAddress2: Text[50];
        ChooseImage: Integer;
        LineStartValue: Decimal;
        mTodaysPoints: Text[50];
        RCTxt000: TextConst BGR = 'My Code:', ELL = 'Κωδικός μου:', ENU = 'Κωδικός μου:';
        RCTxt001: TextConst BGR = 'Previous Points:', ELL = 'Προηγούμενοι Πόντοι:', ENU = 'Προηγούμενοι Πόντοι';
        RCTxt002: TextConst BGR = 'Today''s Earned Points:', ELL = 'Κερδισμένοι Πόντοι Σήμερα:', ENU = 'Κερδισμένοι Πόντοι Σήμερα:';
        mTotalPoints: Text[50];
        RCTxt003: TextConst BGR = 'Total Points: ', ELL = 'Νέο Σύνολο Πόντων: ', ENU = 'Νέο Σύνολο Πόντων: ';
        RCTxt004: TextConst ELL = 'Έχω έκπτωση στην επόμενη αγορά: %1€', ENU = 'My discount on the next Transaction: %1€';
        mNextDiscount: Text[100];
        RCTxt005: TextConst BGR = 'My Account:', ELL = 'Ο Λογαρασμός μου:', ENU = ' Ο Λογαρασμός μου:';
        ExtendedReceiptText: array[10] of Text[100];
        IsBold: array[10] of Boolean;
        gTransCouponEntry: Record "LSC Trans. Coupon Entry";
        gWithCustDetails: Boolean;
        cduBarcodeMgt: Codeunit "IT4G-Barcode Mgt.";
        [InDataSet]
        bcT: Text[30];
        bcDoc: Text[30];
        rRC: Record "Responsibility Center";
        rL: Record Location;
        mBurnedPoints: Text;
        xx0006: TextConst BGR = 'Used Points:', ELL = 'Πόντοι Εξαργύρωσης:', ENU = 'Πόντοι Εξαργύρωσης:';
        recTmpBlob1: Codeunit "Temp Blob";
        recTmpBlob2: Codeunit "Temp Blob";
        recBC1: Record "Company Information" temporary;
        recBC2: Record "Company Information" temporary;
        streamIn: InStream;
        streamOut: OutStream;
        cPF: Codeunit "IT4G-LS Functions";
}

