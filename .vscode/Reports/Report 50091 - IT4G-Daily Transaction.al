report 50091 "IT4G-Daily Transaction"
{
    // Last Payment Entry Lines
    // 
    // 1, Opening Balance
    // 2, Cash In
    // 3, Cash Out
    // 4, Closing
    DefaultLayout = RDLC;
    RDLCLayout = './IT4G-Daily Transaction.rdlc';
    ApplicationArea = All;
    AdditionalSearchTerms = 'Daily Transaction Report';
    UsageCategory = Administration;

    dataset
    {
        dataitem(GlobalVars; "Integer")
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(xTitle; xTitle)
            {
            }
            column(xStore; xStore)
            {
            }
            column(xDate; xDate)
            {
            }
            column(bHideDoc; bHideDoc)
            {
            }
            column(bHidePayments; bHidePayments)
            {
            }
            column(bHideIncExp; bHideIncExp)
            {
            }

            trigger OnPreDataItem();
            begin
                IF ACCOpeningBal = 0 THEN
                    //                    ACCOpeningBal := cC.GetStoreCashOpeningBalance(xStore, CALCDATE('-1D', xDate));
                    rStore.GET(xStore);
                xTitle := rStore."No." + ' - ' + rStore.Name + '  -  ' + FORMAT(xDate);
            end;
        }
        dataitem(diTH; "LSC Transaction Header")
        {
            DataItemTableView = SORTING("Store No.", Date)
                                WHERE("Entry Status" = FILTER(<> Voided));
            column(FilterDate; xDate)
            {
            }
            column(FilterStore; xStore)
            {
            }
            column(FliterStoreName; rStore.Name)
            {
            }
            column(POS; diTH."POS Terminal No.")
            {
            }
            column(HStaff; "Staff ID" + ' - ' + rStaff."Name on Receipt")
            {
            }
            column(Date; diTH.Date)
            {
            }
            column(Time; diTH.Time)
            {
            }
            column(Doc; rDoc.Description)
            {
            }
            column(DocNo; diTH."Document No.")
            {
            }
            column(Net; diTH."Net Amount")
            {
            }
            column(VAT; diTH."Gross Amount" - diTH."Net Amount")
            {
            }
            column(Gross; diTH."Gross Amount")
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF ("Entry Status" = 1) OR (diTH."Income/Exp. Amount" <> 0) THEN BEGIN
                    CurrReport.SKIP;
                END ELSE BEGIN
                    CLEAR(rDoc);
                    IF rDoc.GET("Document Code") THEN;
                    IF rStaff.GET("Staff ID") THEN;
                END;
            end;

            trigger OnPreDataItem();
            begin
                diTH.SETRANGE("Store No.", xStore);
                diTH.SETRANGE(Date, xDate);
                IF xStaff <> '' THEN
                    diTH.SETRANGE("Staff ID", xStaff);


                IF (xStore = '') OR (xDate = 0D) THEN
                    ERROR(diTH.FIELDNAME("Store No.") + ' και ' + diTH.FIELDNAME(Date) + ' δεν μπορούν να είναι κενά!!!');
            end;
        }
        dataitem(diTPE; "LSC Trans. Payment Entry")
        {
            DataItemTableView = SORTING("Store No.");
            column(PDoc; rDoc.Description)
            {
            }
            column(pTT; diTPE."Tender Type")
            {
            }
            column(rTTS; rTTS.Description)
            {
            }
            column(PDocNo; rTH."Document No.")
            {
            }
            column(pAT; diTPE."Amount Tendered")
            {
            }
            column(pPOS; diTH."POS Terminal No.")
            {
            }
            column(PStaff; "Staff ID" + ' - ' + rStaff."Name on Receipt")
            {
            }

            trigger OnAfterGetRecord();
            var
                rCTPE: Record "LSC Trans. Payment Entry";
            begin
                IF "Amount Tendered" = 0 THEN
                    CurrReport.SKIP ELSE BEGIN

                    CLEAR(rCTPE);
                    rCTPE.SETRANGE("Store No.", "Store No.");
                    rCTPE.SETRANGE("POS Terminal No.", "POS Terminal No.");
                    rCTPE.SETRANGE("Transaction No.", "Transaction No.");
                    rCTPE.SETRANGE("Tender Type", "Tender Type");
                    rCTPE.CALCSUMS("Amount Tendered");
                    IF rCTPE."Amount Tendered" = 0 THEN CurrReport.SKIP;

                    rTH.GET("Store No.", "POS Terminal No.", "Transaction No.");
                    IF rDoc.GET(rTH."Document Code") THEN;
                    IF (rTH."Entry Status" = 1) OR (rTH."Transaction Type" = rTH."Transaction Type"::"Float Entry")
                       OR (rTH."Income/Exp. Amount" <> 0) THEN BEGIN
                        IF rTH."Transaction Type" = rTH."Transaction Type"::"Float Entry" THEN
                            IF diTPE."Tender Type" = '1' THEN
                                InsertTmpPayment("Staff ID", 1, "Amount Tendered");

                        CurrReport.SKIP
                    END ELSE BEGIN
                        CLEAR(rDoc);
                        IF rDoc.GET(rTH."Document Code") THEN;
                        CLEAR(rTTS);
                        rTTS.GET("Tender Type");
                        IF diTPE."Tender Type" = '1' THEN InsertTmpPayment("Staff ID", 2, "Amount Tendered");
                        IF rStaff.GET("Staff ID") THEN;
                    END;
                END;
            end;

            trigger OnPreDataItem();
            begin
                SETFILTER("Store No.", diTH.GETFILTER("Store No."));
                SETFILTER(Date, diTH.GETFILTER(Date));
                IF diTH.GETFILTER("Staff ID") <> '' THEN
                    SETFILTER("Staff ID", diTH.GETFILTER("Staff ID"));

                SETFILTER("Amount Tendered", '<>0');
            end;
        }
        dataitem(diTIEE; "LSC Trans. Inc./Exp. Entry")
        {
            DataItemTableView = SORTING("Store No.");
            column(iPOS; rTH."POS Terminal No.")
            {
            }
            column(iStaff; "Staff ID" + ' - ' + rStaff."Name on Receipt")
            {
            }
            column(iDOc; rTH."Document No.")
            {
            }
            column(iIE; diTIEE."No.")
            {
                IncludeCaption = true;
            }
            column(iIDescr; rIEAc.Description)
            {
            }
            column(iNet; diTIEE."Net Amount")
            {
            }
            column(iAMt; diTIEE.Amount)
            {
            }
            column(iVAT; diTIEE."VAT Amount")
            {
            }

            trigger OnAfterGetRecord();
            begin
                rTH.GET("Store No.", "POS Terminal No.", "Transaction No.");
                IF rTH."Entry Status" = 1 THEN
                    CurrReport.SKIP
                ELSE BEGIN
                    CLEAR(rIEAc);
                    rIEAc.GET("Store No.", "No.");
                    IF rStaff.GET("Staff ID") THEN;
                    InsertTmpPayment("Staff ID", 3, -diTIEE.Amount);
                END;
            end;

            trigger OnPreDataItem();
            begin
                SETFILTER("Store No.", diTH.GETFILTER("Store No."));
                SETFILTER(Date, diTH.GETFILTER(Date));
                IF diTH.GETFILTER("Staff ID") <> '' THEN
                    SETFILTER("Staff ID", diTH.GETFILTER("Staff ID"))
            end;
        }
        dataitem(TPE_tmp; "LSC Transaction Header")
        {
            DataItemTableView = SORTING("Store No.");
            UseTemporary = true;
            column(tStaff; "POS Terminal No." + ' - ' + rStaff."Name on Receipt")
            {
            }
            column(tmpType; tmpType)
            {
            }
            column(tNoOfTrans; "Net Amount")
            {
            }
            column(tAMt; "Gross Amount")
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(rStaff);
                IF rStaff.GET("POS Terminal No.") THEN;

                CASE TPE_tmp."Transaction No." OF
                    1:
                        BEGIN
                            tmpType := '01.ΑΝΟΙΓΜΑ ΤΑΜΕΙΟΥ - ΚΑΤΑΜΕΤΡΗΣΗ';
                            OpeningAmt += "Gross Amount";
                        END;
                    2:
                        BEGIN
                            tmpType := '02.ΕΙΣΠΡΑΞΕΙΣ';
                            CashIn += "Gross Amount";
                        END;
                    3:
                        BEGIN
                            tmpType := '03.ΠΛΗΡΩΜΕΣ';
                            CashOut += "Gross Amount";
                        END;
                    4:
                        BEGIN
                            tmpType := '04.ΣΥΝΟΛΟ ΗΜΕΡΑΣ';
                        END;
                    5:
                        BEGIN
                            tmpType := '05.ΚΛΕΙΣΙΜΟ ΤΑΜΕΙΟΥ - ΚΑΤΑΜΕΤΡΗΣΗ';
                            ClosingAmt += "Gross Amount";
                        END;
                    6:
                        BEGIN
                            tmpType := '06.ΥΠΟΛΟΙΠΟ';
                        END;
                END;
            end;

            trigger OnPreDataItem();
            begin
                //InsertTmpPayment('',0,0);
            end;
        }
        dataitem(diInteger; Integer)
        {
            DataItemTableView = SORTING("Number");
            column(XXID; diInteger.Number)
            {
            }
            column(AccOpenAmt; ACCOpeningBal)
            {
            }
            column(CashIn; CashIn)
            {
            }
            column(CashOut; CashOut)
            {
            }
            column(OpeningAmt; OpeningAmt)
            {
            }
            column(ClosingAmt; ClosingAmt)
            {
            }
            column(AccBal; AccBal)
            {
            }
            column(CountedBal; CountedBal)
            {
            }
            column(AccClosing; AccClosing)
            {
            }
            column(CountedClosing; CountedClosing)
            {
            }
            column(AccClosingTxt; AccClosingTxt)
            {
            }
            column(CountedClosingTxt; CountedClosingTxt)
            {
            }

            trigger OnAfterGetRecord();
            begin
                AccBal := ACCOpeningBal + CashIn + CashOut;
                CountedBal := OpeningAmt + CashIn + CashOut;

                AccClosing := ClosingAmt - AccBal;
                CountedClosing := ClosingAmt - CountedBal;

                IF AccClosing > 0 THEN
                    AccClosingTxt := 'ΠΛΕΟΝΑΣΜΑ'
                ELSE
                    IF AccClosing < 0 THEN
                        AccClosingTxt := 'ΕΛΛΕΙΜΑ'
                    ELSE
                        AccClosingTxt := '-----';

                IF CountedClosing > 0 THEN
                    CountedClosingTxt := 'ΠΛΕΟΝΑΣΜΑ'
                ELSE
                    IF CountedClosing < 0 THEN
                        CountedClosingTxt := 'ΕΛΛΕΙΜΑ'
                    ELSE
                        CountedClosingTxt := '-----';
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE(Number, 1);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(xStore; xStore)
                {
                    Caption = 'Κατάστημα';
                    TableRelation = "LSC Store"."No.";
                }
                field(xDate; xDate)
                {
                    Caption = 'Ημερομηνία';
                }
                field(xStaff; xStaff)
                {
                    Caption = 'Staff';
                    TableRelation = "LSC Staff".ID;
                }
                field(bHideDoc; bHideDoc)
                {
                    Caption = 'Απόκρυψη Παραστατκών';
                }
                field(bHidePayments; bHidePayments)
                {
                    Caption = 'Απόκρυψη Πληρωμών';
                }
                field(bHideIncExp; bHideIncExp)
                {
                    Caption = 'Απόκρυψη Εκροών';
                }
            }
        }

        actions
        {
        }

        trigger OnClosePage();
        begin
            //ACCOpeningBal := cC.GetStoreCashOpeningBalance(xStore, CALCDATE('-1D', xDate));
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        SELECTLATESTVERSION;
    end;

    var
        rDoc: Record "IT4G-LS Document";
        rTH: Record "LSC Transaction Header";
        rTTS: Record "LSC Tender Type Setup";
        rStore: Record "LSC Store";
        bHideDoc: Boolean;
        bHidePayments: Boolean;
        bHideIncExp: Boolean;
        rIEAc: Record "LSC Income/Expense Account";
        rStaff: Record "LSC Staff";
        tmpType: Text;
        ACCOpeningBal: Decimal;
        CashIn: Decimal;
        CashOut: Decimal;
        OpeningAmt: Decimal;
        ClosingAmt: Decimal;
        AccBal: Decimal;
        CountedBal: Decimal;
        AccClosing: Decimal;
        CountedClosing: Decimal;
        AccClosingTxt: Text;
        CountedClosingTxt: Text;
        xTitle: Text;
        xStore: Code[10];
        xStaff: Code[20];
        xDate: Date;

    local procedure InsertTmpPayment(xStaff: Code[10]; xType: Integer; xAmt: Decimal);
    begin
        IF NOT TPE_tmp.GET(xStore, xStaff, xType) THEN BEGIN
            TPE_tmp."Store No." := xStore;
            TPE_tmp."POS Terminal No." := xStaff;
            TPE_tmp."Transaction No." := xType;
            TPE_tmp."Net Amount" := 1;
            TPE_tmp."Gross Amount" := xAmt;
            IF TPE_tmp.INSERT THEN;
        END ELSE BEGIN
            TPE_tmp."Net Amount" += 1;
            TPE_tmp."Gross Amount" += xAmt;
            TPE_tmp.MODIFY;
        END;

        IF xType < 4 THEN
            IF NOT TPE_tmp.GET(xStore, xStaff, 4) THEN BEGIN
                TPE_tmp."Store No." := xStore;
                TPE_tmp."POS Terminal No." := xStaff;
                TPE_tmp."Transaction No." := 4;
                TPE_tmp."Net Amount" := 0;
                TPE_tmp."Gross Amount" := xAmt;
                IF TPE_tmp.INSERT THEN;
            END ELSE BEGIN
                TPE_tmp."Net Amount" += 0;
                TPE_tmp."Gross Amount" += xAmt;
                TPE_tmp.MODIFY;
            END;


        IF NOT TPE_tmp.GET(xStore, xStaff, 6) THEN BEGIN
            TPE_tmp."Store No." := xStore;
            TPE_tmp."POS Terminal No." := xStaff;
            TPE_tmp."Transaction No." := 6;
            TPE_tmp."Net Amount" := 0;
            IF xType = 5 THEN
                TPE_tmp."Gross Amount" := xAmt
            ELSE
                TPE_tmp."Gross Amount" := -xAmt;
            IF TPE_tmp.INSERT THEN;
        END ELSE BEGIN
            TPE_tmp."Net Amount" += 0;
            IF xType = 5 THEN
                TPE_tmp."Gross Amount" += xAmt
            ELSE
                TPE_tmp."Gross Amount" += -xAmt;
            TPE_tmp.MODIFY;
        END;


    end;
}

