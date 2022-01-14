page 60003 "IT4G-LS Document List"
{
    ApplicationArea = All;
    Caption = 'IT4G-LS Document List';
    PageType = List;
    SourceTable = "IT4G-LS Document";
    CardPageId = "IT4G-Document Card";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(General)
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
                field("LS Transaction Type"; Rec."LS Transaction Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
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
                field("Printing Description"; Rec."Printing Description")
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
                field("No. Series Prefix"; Rec."No. Series Prefix")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Series Document"; Rec."Series Document")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Printing Document"; Rec."Printing Document")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Change Doc. POS Behavior"; Rec."Change Doc. POS Behavior")
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
