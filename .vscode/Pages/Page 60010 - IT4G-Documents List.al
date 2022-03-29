page 60010 "IT4G-Documents List"
{
    ApplicationArea = All;
    Caption = 'IT4G-Documents List';
    PageType = List;
    SourceTable = "IT4G-Doc. Header";
    CardPageId = "IT4G-Document Card";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Calc. Number of Lines"; Rec."Calc. Number of Lines")
                {
                    ToolTip = 'Specifies the value of the Calc. Number of Lines field.';
                    ApplicationArea = All;
                }
                field("Created by Document No."; Rec."Created by Document No.")
                {
                    ToolTip = 'Specifies the value of the Created by Document No. field.';
                    ApplicationArea = All;
                }
                field("Created by POS Terminal No."; Rec."Created by POS Terminal No.")
                {
                    ToolTip = 'Specifies the value of the Created by POS Terminal No. field.';
                    ApplicationArea = All;
                }
                field("Created by Store No."; Rec."Created by Store No.")
                {
                    ToolTip = 'Specifies the value of the Created by Store No. field.';
                    ApplicationArea = All;
                }
                field("Created by System"; Rec."Created by System")
                {
                    ToolTip = 'Specifies the value of the Created by System field.';
                    ApplicationArea = All;
                }
                field("Created by Transaction No."; Rec."Created by Transaction No.")
                {
                    ToolTip = 'Specifies the value of the Created by Transaction No. field.';
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                }
                field("Destination Store"; Rec."Destination Store")
                {
                    ToolTip = 'Specifies the value of the Destination Store field.';
                    ApplicationArea = All;
                }
                field("Source Document Code"; Rec."Source Document Code")
                {
                    ToolTip = 'Specifies the value of the Document Code field.';
                    ApplicationArea = All;
                }
                field("Dest. Document Code"; Rec."Dest. Document Code")
                {
                    ToolTip = 'Specifies the value of the Dest. Document Code field.';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                    ApplicationArea = All;
                }
                field("External Document Date"; Rec."External Document Date")
                {
                    ToolTip = 'Specifies the value of the External Document Date field.';
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ToolTip = 'Specifies the value of the From Location field.';
                    ApplicationArea = All;
                }
                field("From Store"; Rec."From Store")
                {
                    ToolTip = 'Specifies the value of the From Store field.';
                    ApplicationArea = All;
                }
                field("Number of Items"; Rec."Number of Items")
                {
                    ToolTip = 'Specifies the value of the Number of Items field.';
                    ApplicationArea = All;
                }
                field("Number of Lines"; Rec."Number of Lines")
                {
                    ToolTip = 'Specifies the value of the Number of Lines field.';
                    ApplicationArea = All;
                }
                field("Related Document No."; Rec."Related Document No.")
                {
                    ToolTip = 'Specifies the value of the Related Document No. field.';
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.';
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.';
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    ToolTip = 'Specifies the value of the To Location field.';
                    ApplicationArea = All;
                }
                field("To Store"; Rec."To Store")
                {
                    ToolTip = 'Specifies the value of the To Store field.';
                    ApplicationArea = All;
                }
                field("Updated by Document No."; Rec."Updated by Document No.")
                {
                    ToolTip = 'Specifies the value of the Updated by Document No. field.';
                    ApplicationArea = All;
                }
                field("Updated by POS Terminal No."; Rec."Updated by POS Terminal No.")
                {
                    ToolTip = 'Specifies the value of the Updated by POS Terminal No. field.';
                    ApplicationArea = All;
                }
                field("Updated by Store No."; Rec."Updated by Store No.")
                {
                    ToolTip = 'Specifies the value of the Updated by Store No. field.';
                    ApplicationArea = All;
                }
                field("Updated by Transaction No."; Rec."Updated by Transaction No.")
                {
                    ToolTip = 'Specifies the value of the Updated by Transaction No. field.';
                    ApplicationArea = All;
                }
                field("Calc. Quantity"; Rec."Calc. Quantity")
                {
                    ToolTip = 'Specifies the value of the Calc. Quantity field.';
                    ApplicationArea = All;
                }
                field("Calc. Scanned Quantity"; Rec."Calc. Scanned Quantity")
                {
                    ToolTip = 'Specifies the value of the Calc. Scanned Quantity  field.';
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                    ApplicationArea = All;
                }
                field("Created by Staff"; Rec."Created by Staff")
                {
                    ToolTip = 'Specifies the value of the Created by Staff field.';
                    ApplicationArea = All;
                }
                field("Created by User"; Rec."Created by User")
                {
                    ToolTip = 'Specifies the value of the Created by User field.';
                    ApplicationArea = All;
                }
                field("Created on Host"; Rec."Created on Host")
                {
                    ToolTip = 'Specifies the value of the Created on Host field.';
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ToolTip = 'Specifies the value of the Updated On field.';
                    ApplicationArea = All;
                }
                field("Updated by Staff"; Rec."Updated by Staff")
                {
                    ToolTip = 'Specifies the value of the Updated by Staff field.';
                    ApplicationArea = All;
                }
                field("Updated by User"; Rec."Updated by User")
                {
                    ToolTip = 'Specifies the value of the Updated by User field.';
                    ApplicationArea = All;
                }
                field("Updated on Host"; Rec."Updated on Host")
                {
                    ToolTip = 'Specifies the value of the Updated on Host field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        /*
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
        */
    }
}
