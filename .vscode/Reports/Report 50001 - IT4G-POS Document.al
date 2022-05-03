report 50001 "IT4G-POS Document"
{
    ApplicationArea = All;
    Caption = 'IT4G-POS Document';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './IT4G-POS Document.rdlc';
    dataset
    {
        dataitem("Transaction Header"; "LSC Transaction Header")
        {
            DataItemTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.");
            RequestFilterFields = "Store No.", "POS Terminal No.", "Transaction No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Transaction_Header__Receipt_No__; "Receipt No.")
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__Transaction_No__; "Transaction No.")
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__Date; Date)
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__Time; Time)
            {
            }
            column(Transaction_Header__POS_Terminal_No__; "POS Terminal No.")
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__Staff_ID_; "Staff ID")
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__CustomerName; CustomerName)
            {
            }
            column(Transaction_Header__CustomerRec__No__; CustomerRec."No.")
            {
            }
            column(Transaction_Header__Entry_Status_; "Entry Status")
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__Transaction_Type_; "Transaction Type")
            {
                IncludeCaption = true;
            }
            column(Transaction_Header__Store_No_; "Store No.")
            {
            }
            dataitem("Trans. Sales Entry"; "LSC Trans. Sales Entry")
            {
                DataItemLink = "Store No." = FIELD("Store No."), "POS Terminal No." = FIELD("POS Terminal No."), "Transaction No." = FIELD("Transaction No.");
                DataItemTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.", "Line No.");
                column(Trans__Sales_Entry___Store_No_; "Store No.")
                {
                }
                column(Trans__Sales_Entry___POS_Terminal_No_; "POS Terminal No.")
                {
                }
                column(Trans__Sales_Entry___Transaction_No_; "Transaction No.")
                {
                }
                column(Trans__Sales_Entry___Line_No_; "Line No.")
                {
                }
                column(Trans__Sales_Entry___Item_No__; "Item No.")
                {
                }
                column(Trans__Sales_Entry___ItemName; ItemName)
                {
                }
                column(Trans__Sales_Entry___Variant_Code_; "Variant Code")
                {
                }
                column(Trans__Sales_Entry___Price_; Price)
                {
                }
                column(Trans__Sales_Entry___Quantity____1; Quantity * -1)
                {
                }
                column(Trans__Sales_Entry___Discount_Amount_; "Discount Amount")
                {
                }
                column(Trans__Sales_Entry___Net_Amount_____1; "Net Amount" * -1)
                {
                }
                column(Trans__Sales_Entry___VAT_Amount_____1; "VAT Amount" * -1)
                {
                }
                column(Trans__Sales_Entry___Net_Amount; "Net Amount")
                {
                }
                column(Trans__Sales_Entry___VAT_Amount; "VAT Amount")
                {
                }
                column(Trans__Sales_Entry___ItemTotal____1; ItemTotal * -1)
                {
                }
                column(Trans__Sales_Entry___TotDiscText; TotDiscText)
                {
                }
                column(Transaction_Header___Total_Discount_; "Transaction Header"."Total Discount")
                {
                }
                dataitem("Trans. Discount Entry"; "LSC Trans. Discount Entry")
                {
                    DataItemLink = "Store No." = FIELD("Store No."), "POS Terminal No." = FIELD("POS Terminal No."), "Transaction No." = FIELD("Transaction No."), "Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.", "Line No.", "Offer Type", "Offer No.") ORDER(Ascending);
                    column(Trans__Discount_Entry___Store_No_; "Store No.")
                    {
                    }
                    column(Trans__Discount_Entry___POS_Terminal_No_; "POS Terminal No.")
                    {
                    }
                    column(Trans__Discount_Entry___Transaction_No_; "Transaction No.")
                    {
                    }
                    column(Trans__Discount_Entry___Line_No_; "Line No.")
                    {
                    }
                    column(Trans__Discount_Entry___Offer_Type; "Offer Type")
                    {
                    }
                    column(Trans__Discount_Entry___Offer_No_; "Offer No.")
                    {
                    }
                    column(Trans__Discount_Entry___Sequence_Code_; "Sequence Code")
                    {
                    }
                    column(Trans__Discount_Entry___Sequence_Function_; "Sequence Function")
                    {
                    }
                    column(Trans__Discount_Entry___DiscountDescription; DiscountDescription)
                    {
                    }
                    column(Trans__Discount_Entry___Discount_Amount_; "Discount Amount")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        DiscountDescription := Format("Offer Type");
                        if "Offer Type" = "Offer Type"::Coupon then begin
                            if CouponHeader.Get("Offer No.") then
                                DiscountDescription := CouponHeader.Description;
                        end
                        else
                            if PeriodicDiscount.Get("Offer No.") then
                                DiscountDescription := PeriodicDiscount.Description
                            else
                                if "Offer Type" = "Offer Type"::Total then
                                    DiscountDescription := Text001;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if ShowDiscountInfo <> ShowDiscountInfo::"Detail information for each line" then
                            CurrReport.Break;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if Item.Get("Item No.") then
                        ItemName := Item.Description
                    else
                        ItemName := "Item No.";

                    ItemTotal := "Net Amount" + "VAT Amount";

                    Clear(TotDiscText);
                    "Transaction Header"."Total Discount" := 0;

                    HasTransSalesEntryValues := true;
                end;

                trigger OnPostDataItem()
                begin
                    ItemTotal := "Net Amount" + "VAT Amount";
                    Clear(TotDiscText);
                    "Transaction Header"."Total Discount" := 0;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(HasTransSalesEntryValues);
                end;
            }
            dataitem(TransSalesEntryTotal; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TransSalesEntryTotal_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    if not HasTransSalesEntryValues then
                        CurrReport.Skip;
                end;
            }
            dataitem(DiscountSummary; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(DiscountSummary__Number; Number)
                {
                }
                column(DiscountSummary__Text002; Text002)
                {
                }
                column(DiscountSummary__PeriodicDiscountTEMP_Description; PeriodicDiscountTEMP.Description)
                {
                }
                column(DiscountSummary__PeriodicDiscountTEMP__Discount_Amount_Value_; PeriodicDiscountTEMP."Discount Amount Value")
                {
                }
                column(DiscountSummary__NoOfPeriodicDiscountTEMP; NoOfPeriodicDiscountTEMP)
                {
                }
                column(DiscountSummary__Text001; Text001)
                {
                }
                column(DiscountSummary__TotalSummaryDisc; TotalSummaryDisc)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        PeriodicDiscountTEMP.FindFirst
                    else
                        PeriodicDiscountTEMP.Next;
                    TotalSummaryDisc := TotalSummaryDisc + PeriodicDiscountTEMP."Discount Amount Value";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, NoOfPeriodicDiscountTEMP);
                    TotalSummaryDisc := 0;
                    PeriodicDiscountTEMP.Reset;
                end;
            }
            dataitem(TransIncomeExpensentry_Header; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TransIncomeExpensentry_Header__Number; Number)
                {
                }
            }
            dataitem("Trans. Income/Expense Entry"; "LSC Trans. Inc./Exp. Entry")
            {
                DataItemLink = "Store No." = FIELD("Store No."), "POS Terminal No." = FIELD("POS Terminal No."), "Transaction No." = FIELD("Transaction No.");
                DataItemTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.", "Line No.");
                column(Trans__Income_Expense___Entry_Store_No_; "Store No.")
                {
                }
                column(Trans__Income_Expense___Entry_POS_Terminal_No_; "POS Terminal No.")
                {
                }
                column(Trans__Income_Expense___Entry_Transaction_No_; "Transaction No.")
                {
                }
                column(Trans__Income_Expense___Entry_Line_No_; "Line No.")
                {
                }
                column(Trans__Income_Expense___No__; "No.")
                {
                }
                column(Trans__Income_Expense___IncExpAccName; IncExpAccName)
                {
                }
                column(Trans__Income_Expense___Amount; -Amount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    IncExpAcc: Record "LSC Income/Expense Account";
                begin
                    Clear(IncExpAccName);
                    if IncExpAcc.Get("Trans. Income/Expense Entry"."Store No.", "Trans. Income/Expense Entry"."No.") then
                        IncExpAccName := IncExpAcc.Description;
                end;
            }
            dataitem(TransIncomeExpensentry_Footer; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TransIncomeExpensentry_Footer__Number; Number)
                {
                }
            }
            dataitem(TransPaymentEntryHeader; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TransPaymentEntryHeader__Number; Number)
                {
                }
            }
            dataitem("<Trans. Payment Entry>"; "LSC Trans. Payment Entry")
            {
                DataItemLink = "Store No." = FIELD("Store No."), "POS Terminal No." = FIELD("POS Terminal No."), "Transaction No." = FIELD("Transaction No.");
                DataItemLinkReference = "Transaction Header";
                DataItemTableView = SORTING("Store No.", "POS Terminal No.", "Transaction No.", "Line No.");
                column(Trans__Payment_Entry___Store_No_; "Store No.")
                {
                }
                column(Trans__Payment_Entry___POS_Terminal_No_; "POS Terminal No.")
                {
                }
                column(Trans__Payment_Entry___Transaction_No_; "Transaction No.")
                {
                }
                column(Trans__Payment_Entry___Line_No_; "Line No.")
                {
                }
                column(Trans__Payment_Entry___TenderType; TenderType)
                {
                }
                column(Trans__Payment_Entry___PayDescription; PayDescription)
                {
                }
                column(Trans__Payment_Entry___Currency_Code_; "Currency Code")
                {
                    IncludeCaption = true;
                }
                column(Trans__Payment_Entry___Amount_in_Currency_; "Amount in Currency")
                {
                    IncludeCaption = true;
                }
                column(Trans__Payment_Entry___Exchange_Rate_; "Exchange Rate")
                {
                    IncludeCaption = true;
                }
                column(Trans__Payment_Entry___Amount_Tendered_; "Amount Tendered")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    if TenderTypeRec.Get("Store No.", "Tender Type") then begin
                        TenderType := TenderTypeRec.Description;
                        if "Change Line" then
                            PayDescription := TenderTypeRec."Change Line on Receipt"
                        else
                            PayDescription := '';
                    end else
                        TenderType := Format("Tender Type");

                    if (PayDescription = '') and
                       (TenderTypeCardSetup.Get("Store No.", "Tender Type", "Card No."))
                    then
                        PayDescription := TenderTypeCardSetup.Description;

                    HasTransPaymentEntryValues := true;
                end;

                trigger OnPreDataItem()
                begin
                    HasTransPaymentEntryValues := false;
                end;
            }
            dataitem(TransPaymentEntryFooter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TransPaymentEntryFooter__Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    if not HasTransPaymentEntryValues then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            var
                TransDiscountEntry: Record "LSC Trans. Discount Entry";
                OfferCode: Code[50];
            begin
                if CustomerRec.Get("Customer No.") then
                    CustomerName := CustomerRec.Name
                else
                    CustomerName := "Customer No.";

                if ShowDiscountInfo = ShowDiscountInfo::"Summary information below Sub-total" then begin
                    PeriodicDiscountTEMP.Reset;
                    PeriodicDiscountTEMP.DeleteAll;
                    NoOfPeriodicDiscountTEMP := 0;
                    if ShowDiscountInfo = ShowDiscountInfo::"Summary information below Sub-total" then begin
                        TransDiscountEntry.Reset;
                        TransDiscountEntry.SetRange("Store No.", "Store No.");
                        TransDiscountEntry.SetRange("POS Terminal No.", "POS Terminal No.");
                        TransDiscountEntry.SetRange("Transaction No.", "Transaction No.");
                        if TransDiscountEntry.FindSet then
                            repeat
                                if TransDiscountEntry."Offer No." = '' then
                                    OfferCode := CopyStr(Format(TransDiscountEntry."Offer Type"), 1, MaxStrLen(PeriodicDiscountTEMP."No."))
                                else
                                    OfferCode := TransDiscountEntry."Offer No.";
                                if PeriodicDiscountTEMP.Get(OfferCode) then begin
                                    PeriodicDiscountTEMP."Discount Amount Value" := PeriodicDiscountTEMP."Discount Amount Value" +
                                      TransDiscountEntry."Discount Amount";
                                    PeriodicDiscountTEMP.Modify;
                                end
                                else begin
                                    Clear(PeriodicDiscountTEMP);
                                    PeriodicDiscountTEMP."No." := OfferCode;
                                    PeriodicDiscountTEMP.Description := Format(TransDiscountEntry."Offer Type");
                                    if TransDiscountEntry."Offer Type" = TransDiscountEntry."Offer Type"::Coupon then begin
                                        if CouponHeader.Get(TransDiscountEntry."Offer No.") then
                                            PeriodicDiscount.Description := CopyStr(CouponHeader.Description, 1, MaxStrLen(PeriodicDiscount.Description));
                                    end
                                    else
                                        if PeriodicDiscount.Get(TransDiscountEntry."Offer No.") then
                                            PeriodicDiscountTEMP.Description := PeriodicDiscount.Description;
                                    PeriodicDiscountTEMP."Discount Amount Value" := TransDiscountEntry."Discount Amount";
                                    PeriodicDiscountTEMP.Insert;
                                    NoOfPeriodicDiscountTEMP := NoOfPeriodicDiscountTEMP + 1;
                                end;
                            until TransDiscountEntry.Next = 0;
                    end;
                end;
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
                field(ShowDiscountInfo; ShowDiscountInfo)
                {
                    ApplicationArea = All;
                    Caption = 'Show Discount Information';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        l_ReportName = 'Detailed Receipt';
        l_Page = 'Page';
        l_Total = 'Total';
        Customer = 'Customer';
        Account = 'Account';
        ItemNo = 'Item No.';
        ItemDescription = 'Item Description';
        VariantCode = 'Variant Code';
        Price = 'Price';
        Qty = 'Qty.';
        Discount = 'Discount';
        NetAmount = 'Net Amount';
        VAT = 'VAT';
        Payment = 'Payments';
        Description = 'Description';
        TotalPayment = 'Total Payment';
        AccountDescription = 'Account Description';
        TenderType = 'Tender Type';
    }

    var
        Text000: Label 'Training';
        CustomerRec: Record Customer;
        Item: Record Item;
        TenderTypeRec: Record "LSC Tender Type";
        TenderTypeCardSetup: Record "LSC Tender Type Card Setup";
        CustomerName: Text[50];
        ItemNo: Code[20];
        ItemName: Text[100];
        TenderType: Text[30];
        PayDescription: Text[30];
        ItemTotal: Decimal;
        IncExpAccName: Text[50];
        Text001: Label 'Total Discount';
        TotDiscText: Text[50];
        ShowDiscountInfo: Option "Summary information below Sub-total","Detail information for each line","No printing";
        PeriodicDiscountTEMP: Record "LSC Periodic Discount" temporary;
        DiscountDescription: Text[100];
        PeriodicDiscount: Record "LSC Periodic Discount";
        CouponHeader: Record "LSC Coupon Header";
        NoOfPeriodicDiscountTEMP: Integer;
        Text002: Label 'Discount Summary:';
        TotalSummaryDisc: Decimal;
        HasTransPaymentEntryValues: Boolean;
        HasTransSalesEntryValues: Boolean;
}
