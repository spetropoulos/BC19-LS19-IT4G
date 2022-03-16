pageextension 60003 "PE99001468 - 60003-Store Card" extends "LSC Store Card"
{
    layout
    {
        addlast(content)
        {
            group(IT4G)
            {

                field("Retail Customer"; Rec."Retail Customer")
                {
                    ToolTip = 'Specifies the value of the Retail Customer field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}