tableextension 60001 "TE99001472-Transaction Header" extends "LSC Transaction Header"
{
    fields
    {
        field(60000; "Document Code"; Code[20])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document".Code;
        }
        field(60001; "Post Series"; Code[20])
        {
            Caption = 'Post Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(60002; "Offline Document No."; Code[20])
        {
            Caption = 'Offline Document No.';
            DataClassification = ToBeClassified;
        }
        field(60004; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(60101; "Trans. Document No."; Code[20])
        {
            Caption = 'Trans. Document No.';
            DataClassification = ToBeClassified;
        }
        field(70001; "From Store"; Code[10])
        {
            Caption = 'From Store';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store"."No.";
        }
        field(70002; "From Location"; Code[10])
        {
            Caption = 'From Location';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("From Store"));
        }
        field(70011; "To Store"; Code[10])
        {
            Caption = 'To Store';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store"."No.";
        }
        field(70012; "To Location"; Code[10])
        {
            Caption = 'To Location';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("To Store"));
        }
        field(70500; "Shipment Reason"; Code[20])
        {
            Caption = 'Shipment Reason';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Help Table" where("Type" = const("Shipment Reason"));
        }
        field(70501; "Shipment Method"; Code[10])
        {
            Caption = 'Shipment Method';
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method";
        }
        field(70502; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(71000; "IT4G-Loyalty Card"; Code[20])
        {
            Caption = 'IT4G-Loyalty Card';
            DataClassification = ToBeClassified;
        }
        field(71001; "IT4G-Loyalty ID"; Text[50])
        {
            Caption = 'IT4G-Loyalty ID';
            DataClassification = ToBeClassified;
        }
        field(80000; "External Doc. No."; Code[20])
        {
            Caption = 'External Doc. No.';
            DataClassification = ToBeClassified;
        }
        field(80001; "Related Doc. No."; Code[20])
        {
            Caption = 'Related Doc. No.';
            DataClassification = ToBeClassified;
        }
        field(80002; "WEB Order No."; Code[20])
        {
            Caption = 'WEB Order No.';
            DataClassification = ToBeClassified;
        }
        field(90000; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(60100; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("Store No."));
            DataClassification = ToBeClassified;
        }

    }
}
