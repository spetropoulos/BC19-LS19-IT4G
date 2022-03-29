table 60009 "IT4G-Doc. Scan"
{
    Caption = 'IT4G-Doc. Line Scan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Doc. Header"."Document No.";
        }
        field(2; "Scan Identifier"; Guid)
        {
            Caption = 'Scan Identifier';
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
        field(30; "Scanned Quantity"; Decimal)
        {
            Caption = 'Scanned Quantity';
            DataClassification = ToBeClassified;
        }
        field(31; "Scanned Quantity Base"; Decimal)
        {
            Caption = 'Scanned Quantity Base';
            DataClassification = ToBeClassified;
        }
        field(700; "Created On"; DateTime)
        {
            Caption = 'Created On';
        }
        field(701; "Created by User"; text[100])
        {
            Caption = 'Created by User';
        }
        field(702; "Created by Staff"; Code[20])
        {
            Caption = 'Created by Staff';
        }
        field(703; "Created by Store No."; Code[10])
        {
            Caption = 'Created by Store No.';
            TableRelation = "LSC Store"."No.";
        }
        field(704; "Created by POS Terminal No."; Code[10])
        {
            Caption = 'Created by POS Terminal No.';
            TableRelation = "LSC POS Terminal"."No.";
            ValidateTableRelation = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Scan Identifier")
        {
            Clustered = true;
        }
        key(key1; "Document No.", "Item No.", "Variant Code")
        {
            SumIndexFields = "Scanned Quantity", "Scanned Quantity Base";
        }
    }

}
