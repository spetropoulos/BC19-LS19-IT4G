table 60002 "IT4G-Help Table"
{
    // version IT4G

    DrillDownPageID = 60002;
    LookupPageID = 60002;

    fields
    {
        field(1; Type; enum "IT4G-Help Table Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Special Group Prefix"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(100; Prefix; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(1000; "Sort Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        CreateAction(2);
    end;

    trigger OnInsert()
    begin
        CreateAction(0);
    end;

    trigger OnModify()
    begin
        CreateAction(1);
    end;

    trigger OnRename()
    begin
        CreateAction(3);
    end;

    [Scope('OnPrem')]
    procedure CreateAction(xType: Integer)
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ActionsMgt: Codeunit "LSC Actions Management";
    begin
        //CreateAction
        //Type: 0 = INSERT, 1 = MODIFY, 2 = DELETE, 3 = RENAME
        RecRef.GetTable(Rec);
        xRecRef.GetTable(xRec);
        ActionsMgt.SetCalledByTableTrigger(true);
        ActionsMgt.CreateActionsByRecRef(RecRef, xRecRef, xType);
        RecRef.Close;
        xRecRef.Close;
    end;
}

