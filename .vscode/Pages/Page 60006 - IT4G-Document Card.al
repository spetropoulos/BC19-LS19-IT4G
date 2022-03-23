page 60006 "IT4G-Document Card"
{
    ApplicationArea = All;
    Caption = 'IT4G-Document Card';
    PageType = Card;
    SourceTable = "IT4G-Doc. Header";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Source Document Code"; Rec."Source Document Code")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Dest. Document Code"; Rec."Dest. Document Code")
                {
                    ToolTip = 'Specifies the value of the Dest. Document Code field.';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Destination Store"; Rec."Destination Store")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
            group(Other)
            {
                field("Calc. Number of Items"; Rec."Calc. Number of Items")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Calc. Number of Lines"; Rec."Calc. Number of Lines")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Created by Document No."; Rec."Created by Document No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Created by POS Terminal No."; Rec."Created by POS Terminal No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Created by Store No."; Rec."Created by Store No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Created by System"; Rec."Created by System")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Created by Transaction No."; Rec."Created by Transaction No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("External Document Date"; Rec."External Document Date")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("From Store"; Rec."From Store")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Number of Items"; Rec."Number of Items")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Number of Lines"; Rec."Number of Lines")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Related Document No."; Rec."Related Document No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("To Store"; Rec."To Store")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
            group(More)
            {

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
                field("Created On"; Rec."Created On")
                {
                    ToolTip = 'Specifies the value of the Created On field.';
                    ApplicationArea = All;
                }
                field("Created on Host"; Rec."Created on Host")
                {
                    ToolTip = 'Specifies the value of the Created on Host field.';
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
                field("Updated by Staff"; Rec."Updated by Staff")
                {
                    ToolTip = 'Specifies the value of the Updated by Staff field.';
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
                field("Updated by User"; Rec."Updated by User")
                {
                    ToolTip = 'Specifies the value of the Updated by User field.';
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ToolTip = 'Specifies the value of the Updated On field.';
                    ApplicationArea = All;
                }
                field("Updated on Host"; Rec."Updated on Host")
                {
                    ToolTip = 'Specifies the value of the Updated on Host field.';
                    ApplicationArea = All;
                }
            }
            Group(Details)
            {
                part(Lines; "IT4G-Doc. Lines")
                {
                    Caption = 'Lines';
                    ApplicationArea = All;
                    //Editable = DynamicEditable;
                    SubPageLink = "Document No." = FIELD("Document No.");
                    UpdatePropagation = Both;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Send)
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Send Document';

                trigger OnAction();
                var
                    cIT4GTSU: Codeunit "IT4G-Trans. Server Util";
                    errTxt: Text;
                begin
                    if not cIT4GTSU.SendIt4GDoc(rec, errTxt) then message(errTxt);

                end;
            }
            action(Receive)
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Receive Document';

                trigger OnAction();
                var
                    cIT4GTSU: Codeunit "IT4G-Trans. Server Util";
                    errTxt: Text;
                    cU: Codeunit 50020;
                begin
                    cU.run;
                    if not cIT4GTSU.GetIT4GDoc(rec, rec."Document No.", errTxt) then message(errTxt);

                end;
            }
            action(GetXML)
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Get XML';

                trigger OnAction();
                var
                    cSQL: Codeunit "IT4G-SQL Management";
                begin
                    message(cSQL.GetSQLDataAsXML);

                end;
            }
        }
    }
}
