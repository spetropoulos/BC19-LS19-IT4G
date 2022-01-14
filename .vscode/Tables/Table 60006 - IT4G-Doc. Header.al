table 60006 "IT4G-Doc. Header"
{
    Caption = 'IT4G-Doc. Header';
    DataClassification = ToBeClassified;
    LookupPageId = 60006;
    DrillDownPageId = 60006;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Enum "IT4G-Doc. Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Destination Store"; Code[10])
        {
            Caption = 'Destination Store';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store"."No.";
        }
        field(5; "Document Code"; Code[10])
        {
            Caption = 'Document Code';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document";
        }
        field(10; "Created by Store No."; Code[10])
        {
            Caption = 'Created by Store No.';
            TableRelation = "LSC Store"."No.";
        }
        field(11; "Created by POS Terminal No."; Code[10])
        {
            Caption = 'Created by POS Terminal No.';
            TableRelation = "LSC POS Terminal"."No.";
            ValidateTableRelation = false;
        }
        field(12; "Created by Transaction No."; Integer)
        {
            Caption = 'Created by Transaction No.';
        }
        field(13; "Created by System"; Enum "IT4G-Doc. System Type")
        {
            Caption = 'Created by System';
        }
        field(14; "Created by Document No."; code[20])
        {
            Caption = 'Created by Document No.';
        }
        field(20; "From Store"; Code[10])
        {
            Caption = 'From Store';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store"."No.";
        }
        field(21; "From Location"; Code[10])
        {
            Caption = 'From Location';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("From Store"));
        }
        field(22; "To Store"; Code[10])
        {
            Caption = 'To Store';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store"."No.";
        }
        field(23; "To Location"; Code[10])
        {
            Caption = 'To Location';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("To Store"));
        }
        field(90; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = true;
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;

            trigger OnValidate()
            begin
                if "Source Type" <> xrec."Source Type" then "Source No." := '';
            end;
        }

        field(91; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = true;
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor;
        }
        field(100; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(101; "External Document Date"; Date)
        {
            Caption = 'External Document Date';
            DataClassification = ToBeClassified;
        }
        field(102; "Related Document No."; Code[20])
        {
            Caption = 'Related Document No.';
            DataClassification = ToBeClassified;
        }
        field(500; "Number of Lines"; Integer)
        {
            Caption = 'Number of Lines';
            DataClassification = ToBeClassified;
        }
        field(501; "Number of Items"; Decimal)
        {
            Caption = 'Number of Items';
            DataClassification = ToBeClassified;
        }
        field(600; "Calc. Number of Lines"; Integer)
        {
            Caption = 'Calc. Number of Lines';
            FieldClass = FlowField;
            CalcFormula = count("IT4G-Doc. Line" where("Document No." = field("Document No.")));
        }
        field(601; "Calc. Number of Items"; Decimal)
        {
            Caption = 'Calc. Number of Items';
            FieldClass = FlowField;
            CalcFormula = sum("IT4G-Doc. Line"."Quantity Base" where("Document No." = field("Document No.")));
        }

    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        Key(ToStore; "To Store") { }

    }

    trigger OnDelete()
    var
        rL: Record "IT4G-Doc. Line";
        rLB: Record "IT4G-Doc. Line Box";
        rScan: Record "IT4G-Doc. Scan";
        rSource: Record "IT4G-Doc. Source";
    begin
        rL.SetRange("Document No.", "Document No.");
        rL.Deleteall;
        rLB.SetRange("Document No.", "Document No.");
        rLB.Deleteall;
        rScan.SetRange("Document No.", "Document No.");
        rScan.Deleteall;
        rSource.SetRange("Document No.", "Document No.");
        rSource.Deleteall;

    end;
}
