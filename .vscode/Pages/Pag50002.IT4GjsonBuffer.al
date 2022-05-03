page 50002 "IT4G json Buffer"
{
    ApplicationArea = All;
    Caption = 'IT4G json Buffer';
    PageType = List;
    SourceTable = "JSON Buffer";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field(Depth; Rec.Depth)
                {
                    ToolTip = 'Specifies the value of the Depth field.';
                    ApplicationArea = All;
                }
                field(Path; Rec.Path)
                {
                    ToolTip = 'Specifies the value of the Path field.';
                    ApplicationArea = All;
                }
                field("Token type"; Rec."Token type")
                {
                    ToolTip = 'Specifies the value of the Token type field.';
                    ApplicationArea = All;
                }
                field("Value Type"; Rec."Value Type")
                {
                    ToolTip = 'Specifies the value of the Value Type field.';
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate")
            {
                trigger OnAction()
                var
                begin
                    codeunit.run(50003);
                end;

            }
        }
    }
}
