table 60000 "IT4G-Registry"
{
    // version IT4G


    fields
    {
        field(1; "IT4G-USERID"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Key"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Value Code 1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Value Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Value Int 1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Value Int 2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Value Dec 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Value Dec 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Value Bool 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Value Bool 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Value Text 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Value Text 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Value Date 1"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Value Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(100; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(1001; Replicated; Boolean)
        {
            Caption = 'Replicated';
        }
        field(1002; "Replication Counter"; Integer)
        {
            Caption = 'Replication Counter';

            trigger OnValidate()
            var
                myRec: Record "It4G-Registry";
            begin
                myRec.SETCURRENTKEY("Replication Counter");
                IF myRec.FINDLAST THEN
                    "Replication Counter" := myRec."Replication Counter" + 1
                ELSE
                    "Replication Counter" := 1;
            end;
        }
    }

    keys
    {
        key(Key1; "IT4G-USERID", "Key", "Line No.")
        {
        }
        key(Key2; "Replication Counter")
        {
        }
    }

    fieldgroups
    {
    }
}

