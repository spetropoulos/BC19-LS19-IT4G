pageextension 60002 "Transaction Register" extends "LSC Transaction Register"
{
    layout
    {
        addfirst(Control1)
        {
            field("Document Code"; Rec."Document Code")
            {
                ToolTip = 'Specifies the value of the Document Code field';
                ApplicationArea = All;
            }
            field("Document No."; Rec."Document No.")
            {
                ToolTip = 'Specifies the value of the Document No. field';
                ApplicationArea = All;
            }
            field("Post Series"; Rec."Post Series")
            {
                ToolTip = 'Specifies the value of the Post Series field';
                ApplicationArea = All;
            }
            field("External Doc. No."; Rec."External Doc. No.")
            {
                ToolTip = 'Specifies the value of the External Doc. No. field';
                ApplicationArea = All;
            }
            field("Trans. Document No."; Rec."Trans. Document No.")
            {
                ToolTip = 'Specifies the value of the Trans. Document No. field';
                ApplicationArea = All;
            }
        }
    }
}
