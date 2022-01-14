table 60007 "IT4G-Doc. Line"
{
    Caption = 'IT4G-Doc. Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Doc. Header"."Document No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Line Type"; Enum "IT4G-Doc. Line type")
        {
            Caption = 'Line Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Number"; code[20])
        {
            Caption = 'Number';
            DataClassification = ToBeClassified;
            TableRelation = if ("Line Type" = const(Item)) "Item"."No." else
            If ("Line Type" = const(Payment)) "LSC Tender Type Setup".Code;
        }
        field(12; "Variant Code"; code[20])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
            TableRelation = if ("Line Type" = const(Item)) "Item Variant"."Code" where("Item No." = field(Number));
        }
        field(20; "Unit of Measure"; code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = if ("Line Type" = const(Item)) "Item Unit of Measure"."Code" where("Item No." = field(Number));
        }
        field(21; "Base Unit of Measure"; code[20])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = if ("Line Type" = const(Item)) "Item Unit of Measure"."Code" where("Item No." = FIELD(Number), "Qty. per Unit of Measure" = CONST(1));
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
        field(100; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Quantity Base";

        }
    }
    trigger OnDelete()
    var
        rLB: Record "IT4G-Doc. Line Box";
        rScan: Record "IT4G-Doc. Scan";
        rSource: Record "IT4G-Doc. Source";
        lblErr: Label 'There are scann Lines. Delete then first in order to Delete the line %2 of Document %1';
    begin
        rScan.SetRange("Document No.", "Document No.");
        if not rScan.IsEmpty then error(StrSubstNo(lblErr, "Document No.", "Line No."));

        rLB.SetRange("Document No.", "Document No.");
        rLB.Deleteall;
        rScan.SetRange("Document No.", "Document No.");
        rScan.Deleteall;
    end;
}
