page 60011 "IT4G-WEB Service Setup"
{
    ApplicationArea = All;
    Caption = 'IT4G-WEB Service Setup';
    PageType = List;
    SourceTable = "IT4G-WEb Service Setup";
    UsageCategory = Administration;
    CardPageId = "IT4G-WEB Service card";
    InsertAllowed = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Base URL"; Rec."Base URL")
                {
                    ToolTip = 'Specifies the value of the Base URL field.';
                    ApplicationArea = All;
                }
                field("URL var 1"; Rec."URL var 1")
                {
                    ToolTip = 'Specifies the value of the URL var 1 field.';
                    ApplicationArea = All;
                }
                field("URL var 2"; Rec."URL var 2")
                {
                    ToolTip = 'Specifies the value of the URL var 2 field.';
                    ApplicationArea = All;
                }
                field("URL var 3"; Rec."URL var 3")
                {
                    ToolTip = 'Specifies the value of the URL var 3 field.';
                    ApplicationArea = All;
                }
                field("URL var 4"; Rec."URL var 4")
                {
                    ToolTip = 'Specifies the value of the URL var 4 field.';
                    ApplicationArea = All;
                }
                field("No. of Services"; Rec."No. of Services")
                {
                    ToolTip = 'Specifies the value of the No. of Services field.';
                    ApplicationArea = All;
                }
                field(Debug; Rec.Debug)
                {
                    ToolTip = 'Specifies the value of the Debug field.';
                    ApplicationArea = All;
                }
                field("Debug Path"; Rec."Debug Path")
                {
                    ToolTip = 'Specifies the value of the Debug Path field.';
                    ApplicationArea = All;
                }
                field(Logging; Rec.Logging)
                {
                    ToolTip = 'Specifies the value of the Logging field.';
                    ApplicationArea = All;
                }
                field("Authentication Key"; Rec."Authentication Key")
                {
                    ToolTip = 'Specifies the value of the Authentication Key field.';
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                    ApplicationArea = All;
                }
                field("User Password"; Rec."User Password")
                {
                    ToolTip = 'Specifies the value of the User Password field.';
                    ApplicationArea = All;
                }
            }
            part("WEB Service Methods"; "IT4G-WEB Service Setup Methods")
            {
                ApplicationArea = All;
                SubPageLink = "Code" = field("Code");
                UpdatePropagation = Both;
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("test")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Test PAGE';
                trigger OnAction()
                var

                begin
                    Page.run(50000);

                end;
            }
        }
    }

}
