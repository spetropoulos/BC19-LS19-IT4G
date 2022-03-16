tableextension 60004 "TE99001470 - 60004-Store" extends "LSC Store"
{
    fields
    {
        field(50000; "Retail Customer"; Code[20])
        {
            Caption = 'Retail Customer';
            TableRelation = "LSC Store"."No.";
            DataClassification = ToBeClassified;
        }
    }
}
