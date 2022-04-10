pageextension 60011 "PE99001690-60011-POS VAT Codes" extends "LSC POS VAT Codes"
{
    layout
    {
        addlast(Control1)
        {
            field("Tax Printer VAT Category"; Rec."Tax Printer VAT Category")
            {
                ToolTip = 'Specifies the value of the Tax Printer VAT Category field.';
                ApplicationArea = All;
            }
        }
    }
}
