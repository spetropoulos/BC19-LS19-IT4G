table 60001 "IT4G-Log"
{
    // version IT4G


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Module; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Key"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Batch ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(101; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bridge Job,Rec,Batch';
            OptionMembers = "Bridge Job",Rec,Batch;
        }
        field(10000; User; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10001; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10002; "Posting Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10003; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Error,Success';
            OptionMembers = Error,Success;
        }
        field(10004; "Status Text"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20000; Started; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20001; Finished; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20002; Duration; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(20003; Processed; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20004; Errors; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20005; Inserted; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20006; Modified; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20007; Skipped; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20008; "Job Finished"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Module, Status)
        {
        }
        key(Key3; Module, "Table ID", "Key")
        {
        }
    }

    fieldgroups
    {
    }
}

