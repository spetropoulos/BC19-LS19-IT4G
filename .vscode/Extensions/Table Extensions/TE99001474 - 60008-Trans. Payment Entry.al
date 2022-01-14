tableextension 60008 "TE99001474-Trans. Pay Entry" extends "LSC Trans. Payment Entry"
{
    fields
    {
        field(60000; "IT4G-Doc. No."; Code[20])
        {
            Caption = 'IT4G-Doc. No.';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Doc. Header"."Document No.";
        }
        field(60001; "IT4G-Doc. Line No."; Integer)
        {
            Caption = 'IT4G-Doc. Line No.';
            DataClassification = ToBeClassified;
        }
    }
}
