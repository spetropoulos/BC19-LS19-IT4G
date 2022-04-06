page 60000 "IT4G-Doc. Series Printer Setup"
{

    ApplicationArea = All;
    Caption = 'IT4G-Doc. Series Printer Setup';
    PageType = List;
    SourceTable = "IT4G-Doc. Series Printer Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Terminal No."; Rec."Terminal No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Series Info"; Rec."Series Info")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Tax Printer Series"; Rec."Tax Printer Series")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Order No. Series"; Rec."Order No. Series")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Document Report ID"; Rec."Document Report ID")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Document Trans. Report ID"; Rec."Document Trans. Report ID")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Printing Language"; Rec."Printing Language")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Report Labels"; Rec."Report Labels")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Voucher Report Id"; Rec."Voucher Report Id")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Coupon Report Id"; Rec."Coupon Report Id")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Change Card Report ID"; Rec."Change Card Report ID")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Change Card WINPrint"; Rec."Change Card WINPrint")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Coupon Report WINPrint"; Rec."Coupon Report WINPrint")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Document Report WINPrint"; Rec."Document Report WINPrint")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Voucher Report WINPrint"; Rec."Voucher Report WINPrint")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
        }
    }

}
