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
    }
    keys
    {
        key(PK; "Document No.", "Scan Identifier")
        {
            Clustered = true;
        }
    }

}
