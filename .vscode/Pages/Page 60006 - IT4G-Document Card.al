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
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                    Tooltip = '';
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
                    if not cIT4GTSU.GetIT4GDoc(rec, "Document No.", errTxt) then message(errTxt);

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
