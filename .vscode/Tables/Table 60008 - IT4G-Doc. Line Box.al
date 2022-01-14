table 60008 "IT4G-Doc. Line Box"
{
    Caption = 'IT4G-Doc. Line Box';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Doc. Header"."Document No.";
        }
        field(2; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Box No."; Text[50])
        {
            Caption = 'Box No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; code[20])
        {
            Caption = 'Number';
            DataClassification = ToBeClassified;
            TableRelation = "Item"."No.";
        }
        field(5; "Variant Code"; code[20])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant"."Code" where("Item No." = field("Item No."));
        }
        field(6; "Barcode No."; code[30])
        {
            Caption = 'Barcode No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Unit of Measure"; code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(21; "Base Unit of Measure"; code[20])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(30; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(31; "Quantity Base"; Decimal)
        {
            Caption = 'Quantity Base';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Document Line No.", "Box No.")
        {
            Clustered = true;
        }
    }

}
