page 60001 "IT4G-Registry"
{
    ApplicationArea = All;
    Caption = 'IT4G-Registry';
    PageType = List;
    SourceTable = "IT4G-Registry";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("IT4G-USERID"; Rec."IT4G-USERID")
                {
                    ToolTip = 'Specifies the value of the IT4G-USERID field.';
                    ApplicationArea = All;
                }
                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the Key field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Value Bool 1"; Rec."Value Bool 1")
                {
                    ToolTip = 'Specifies the value of the Value Bool 1 field.';
                    ApplicationArea = All;
                }
                field("Value Bool 2"; Rec."Value Bool 2")
                {
                    ToolTip = 'Specifies the value of the Value Bool 2 field.';
                    ApplicationArea = All;
                }
                field("Value Code 1"; Rec."Value Code 1")
                {
                    ToolTip = 'Specifies the value of the Value Code 1 field.';
                    ApplicationArea = All;
                }
                field("Value Code 2"; Rec."Value Code 2")
                {
                    ToolTip = 'Specifies the value of the Value Code 2 field.';
                    ApplicationArea = All;
                }
                field("Value Dec 1"; Rec."Value Dec 1")
                {
                    ToolTip = 'Specifies the value of the Value Dec 1 field.';
                    ApplicationArea = All;
                }
                field("Value Dec 2"; Rec."Value Dec 2")
                {
                    ToolTip = 'Specifies the value of the Value Dec 2 field.';
                    ApplicationArea = All;
                }
                field("Value Int 1"; Rec."Value Int 1")
                {
                    ToolTip = 'Specifies the value of the Value Int 1 field.';
                    ApplicationArea = All;
                }
                field("Value Int 2"; Rec."Value Int 2")
                {
                    ToolTip = 'Specifies the value of the Value Int 2 field.';
                    ApplicationArea = All;
                }
                field("Value Text 1"; Rec."Value Text 1")
                {
                    ToolTip = 'Specifies the value of the Value Text 1 field.';
                    ApplicationArea = All;
                }
                field("Value Text 2"; Rec."Value Text 2")
                {
                    ToolTip = 'Specifies the value of the Value Text 2 field.';
                    ApplicationArea = All;
                }
                field(Replicated; Rec.Replicated)
                {
                    ToolTip = 'Specifies the value of the Replicated field.';
                    ApplicationArea = All;
                }
                field("Replication Counter"; Rec."Replication Counter")
                {
                    ToolTip = 'Specifies the value of the Replication Counter field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
