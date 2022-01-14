tableextension 60002 "TE10001416-Store Locations" extends "LSC Store Location"
{
    fields
    {
        field(60000; "Store Location Type"; Code[20])
        {
            Caption = 'Store Location Type';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Help Table".Code where(Type = const("Store Location Type"));
        }
        field(60001; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(60002; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(60003; "Visible on POS"; Boolean)
        {
            Caption = 'Visible on POS';
        }
    }
}
