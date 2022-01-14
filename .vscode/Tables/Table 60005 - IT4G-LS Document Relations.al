table 60005 "IT4G-LS Document Relations"
{
    // version LSGR8.0,IT4G

    Caption = 'IT4G-LS Document Relations';
    //    LookupPageID = 10016800;

    fields
    {
        field(1; "Relation Type"; enum "IT4G-Document Relation Type")
        {
            Caption = 'Relation Type';
        }
        field(2; "Document Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "IT4G-LS Document";
        }
        field(20; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            TableRelation = "LSC Store";
        }
        field(21; "Terminal No."; Code[10])
        {
            Caption = 'Terminal No.';
            TableRelation = "LSC POS Terminal"."No." WHERE("Store No." = FIELD("Store No."));
        }
        field(22; "Staff ID"; Code[10])
        {
            Caption = 'Staff ID';
            TableRelation = "LSC Staff".ID;
        }
        field(100; "Relation Code"; Code[20])
        {
            Caption = 'Relation Code';
            TableRelation = IF ("Relation Type" = CONST(Document)) "IT4G-LS Document"
            ELSE
            IF ("Relation Type" = CONST(Store)) "LSC Store"
            ELSE
            IF ("Relation Type" = CONST("Tender Type")) "LSC Tender Type Setup"
            ELSE
            IF ("Relation Type" = CONST(Prommotion)) "LSC Offer"
            ELSE
            IF ("Relation Type" = CONST("Discount Offer")) "LSC Periodic Discount";
        }
        field(101; "Dynamic Menu Order"; Integer)
        {
            Caption = 'Dynamic Menu Order';
        }
    }

    keys
    {
        key(Key1; "Relation Type", "Relation Code", "Document Code", "Store No.", "Terminal No.", "Staff ID")
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

    procedure GetRelationDescr(): text;
    var
        rTTS: Record "LSC Tender Type Setup";
        rStore: Record "LSC Store";
        rDoc: Record "IT4G-LS Document";
    begin
        case "Relation Type" of
            "Relation Type"::"Tender Type":
                if rTTS.get("Relation Code") then
                    exit(rTTS.Description);
            "Relation Type"::"Store":
                if rStore.get("Relation Code") then
                    exit(rStore.Name);
            "Relation Type"::"Document":
                if rDoc.get("Document Code") then
                    exit(rDoc.Description);
        end;
    end;

}

