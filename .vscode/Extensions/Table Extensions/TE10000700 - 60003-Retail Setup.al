tableextension 60003 "TE10000700-Retail Setup" extends "LSC Retail Setup"
{
    fields
    {
        field(60000; "IT4G Module Enabled"; Boolean)
        {
            Caption = 'IT4G Module Enabled';
            DataClassification = ToBeClassified;
        }
        field(60001; "Use IT4G Transaction WS"; Boolean)
        {
            Caption = 'Use IT4G Transaction WS';
            DataClassification = ToBeClassified;
        }
    }
}
