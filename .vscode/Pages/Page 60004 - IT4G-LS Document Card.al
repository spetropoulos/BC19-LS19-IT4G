page 60004 "IT4G-LS Document Card"
{

    Caption = 'IT4G-LS Document Card';
    PageType = Card;
    SourceTable = "IT4G-LS Document";

    layout
    {
        area(content)
        {
            field("Change Doc. POS Behavior"; Rec."Change Doc. POS Behavior")
            {
                ApplicationArea = All;
                Tooltip = '';
            }
            group(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Printing Description"; Rec."Printing Description")
                {
                    Enabled = (rec."Type" = rec."Type"::Document);
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Default For"; Rec."Default For")
                {
                    Enabled = (rec."Type" = rec."Type"::Document);
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("LS Transaction Type"; Rec."LS Transaction Type")
                {
                    Enabled = (rec."Type" = rec."Type"::Document);
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Series Document"; Rec."Series Document")
                {
                    Enabled = (rec."Type" = rec."Type"::Document);
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Printing Document"; Rec."Printing Document")
                {
                    Enabled = (rec."Type" = rec."Type"::Document);
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Confirm Post"; Rec."Confirm Post")
                {
                    ToolTip = 'Specifies the value of the Confirm Post field';
                    ApplicationArea = All;
                }
            }
            group(Series)
            {
                Enabled = (rec."Type" = rec."Type"::Series);

                field("IT4G Auto Create Doc. Series"; Rec."IT4G Auto Create Doc. Series")
                {
                    ToolTip = 'Specifies the value of the IT4G Auto Create Document Series field';
                    ApplicationArea = All;
                }
                field("Series Length"; Rec."Series Length")
                {
                    ToolTip = 'Specifies the value of the Series Length field';
                    ApplicationArea = All;
                }
                field("IT4G Document Series Type"; Rec."IT4G Document Series Type")
                {
                    ToolTip = 'Specifies the value of the IT4G Document Series Type field';
                    ApplicationArea = All;
                }
                field("Yearly Series"; Rec."Yearly Series")
                {
                    ToolTip = 'Specifies the value of the Yearly Series field';
                    ApplicationArea = All;
                }
                field("No. Series Prefix"; Rec."No. Series Prefix")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Collect To Series"; Rec."Collect To Series")
                {
                    ToolTip = 'Specifies the value of the Collect To Series field.';
                    ApplicationArea = All;
                }
                field("Collect Series Document"; Rec."Collect Series Document")
                {
                    ToolTip = 'Specifies the value of the Collect Series Document field.';
                    ApplicationArea = All;
                }
                field("Do not Export"; Rec."Do not Export")
                {
                    ToolTip = 'Specifies the value of the Do not Export field.';
                    ApplicationArea = All;
                }
                field("Tax Printer Doc. Code"; Rec."Tax Printer Doc. Code")
                {
                    ToolTip = 'Specifies the value of the Tax Printer Doc. Code field.';
                    ApplicationArea = All;
                }
            }
            group(Menus)
            {
                Enabled = (rec."Type" = rec."Type"::Document);
                field("Main Menu"; Rec."Doc. Main Menu")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Payment Menu"; Rec."Doc. Payment Menu")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Additional Menu 1"; Rec."Doc. Additional Menu 1")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Additional Menu 2"; Rec."Doc. Additional Menu 2")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Additional Menu 3"; Rec."Doc. Additional Menu 3")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Quick Cash Menu"; Rec."Doc. Quick Cash Menu")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
            group(Inventory)
            {
                Enabled = (rec."Type" = rec."Type"::Document);

                field("Ledger Entries"; Rec."Ledger Entries")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Ledger Entry Type"; Rec."Ledger Entry Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Negative Inventory"; Rec."Negative Inventory")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Quantity Entry"; Rec."Quantity Entry")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Value Entry"; Rec."Value Entry")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Disable Discounts"; Rec."Disable Discounts")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Shipment Method"; Rec."Shipment Method")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Shipment Reason"; Rec."Shipment Reason")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Create IT4G-Doc."; Rec."Create IT4G-Doc.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("IT4G-Doc. Code"; Rec."IT4G-Doc. Code")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
            group(Customer)
            {
                Enabled = (rec."Type" = rec."Type"::Document);

                field("Customer Mandatory"; Rec."Customer Mandatory")
                {
                    ToolTip = 'Specifies the value of the Customer Mandatory field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Document Relations")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Document Relations';
                RunObject = page "IT4G-LS Document Relations";
                RunPageLink = "Document Code" = field(Code);
            }
            action("Series Printer Setup")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Series Printer Setup';
                RunObject = page "IT4G-Doc. Series Printer Setup";
                RunPageLink = "Code" = field(Code);
            }
        }
    }

}
