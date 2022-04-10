pageextension 60012 "Tender Type Setup List" extends "LSC Tender Type Setup List"
{
    layout
    {
        addlast(Control1)
        {
            field("Loyalty Points"; Rec."Loyalty Points")
            {
                ToolTip = 'Specifies the value of the Loyalty Points field.';
                ApplicationArea = All;
            }
        }
    }
}
