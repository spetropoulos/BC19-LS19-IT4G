tableextension 60010 "TE99001471 - 60010-POS Termina" extends "LSC POS Terminal"
{
    fields
    {
        field(50000; "Fiscal Printer Software"; Option)
        {
            OptionMembers = ,SignPro,TaxSpooler;
            Caption = 'Fiscal Printer Software';
            DataClassification = ToBeClassified;
        }
    }
}
