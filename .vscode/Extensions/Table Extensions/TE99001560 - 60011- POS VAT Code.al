tableextension 60011 "TE99001560-60011-POS VAT Code" extends "LSC POS VAT Code"
{
    fields
    {
        field(50000; "Tax Printer VAT Category"; Option)
        {
            OptionMembers = ,A,B,C,D,E;
            Caption = 'Tax Printer VAT Category';
            DataClassification = ToBeClassified;
        }
    }
}
