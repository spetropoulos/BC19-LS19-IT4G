pageextension 60000 "Retail Setup" extends "LSC Retail Setup"
{
    layout
    {
        addlast(content)
        {
            group(IT4G)
            {
                field("IT4G Module Enabled"; Rec."IT4G Module Enabled")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
