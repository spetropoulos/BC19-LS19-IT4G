tableextension 60006 "TE99001473-Trans. Sales Entry" extends "LSC Trans. Sales Entry"
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
