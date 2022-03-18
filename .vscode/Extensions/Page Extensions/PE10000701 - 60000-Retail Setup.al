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
                field("Use IT4G Transaction WS"; Rec."Use IT4G Transaction WS")
                {
                    ToolTip = 'Specifies the value of the Use IT4G Transaction WS field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
