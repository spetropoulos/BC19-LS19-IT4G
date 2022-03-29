pageextension 60005 "PE99001485-60010-POS Term.Card" extends "LSC POS Terminal Card"
{
    layout
    {
        addlast(content)
        {
            group(IT4G)
            {

                field("Fiscal Printer Software"; Rec."Fiscal Printer Software")
                {
                    ToolTip = 'Specifies the value of the Fiscal Printer Software field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}