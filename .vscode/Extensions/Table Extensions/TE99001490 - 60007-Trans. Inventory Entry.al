tableextension 60007 "TE99001490-Trans. Inv. Entry" extends "LSC Trans. Inventory Entry"
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
        field(60100; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("Store No."));
            DataClassification = ToBeClassified;
        }

    }
}
