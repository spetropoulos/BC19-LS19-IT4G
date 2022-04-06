pageextension 60012 "PE99001483-60012-POS VAT Codes" extends "LSC Tender Type Setup List"
{
    layout
    {
        addlast(content)
        {
            group(IT4G)
            {
                field("Loyalty Points"; Rec."Loyalty Points")
                {
                    ToolTip = 'Specifies the value of the Loyalty Points field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
