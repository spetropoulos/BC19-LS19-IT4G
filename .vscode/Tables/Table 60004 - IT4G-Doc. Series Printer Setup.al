table 60004 "IT4G-Doc. Series Printer Setup"
{
    // version LSGR8.0,IT4G

    Caption = 'IT4G-Document Series Printer Setup';
    LookupPageID = 60000;

    fields
    {
        field(5; "Data Type"; Option)
        {
            Caption = 'Data Type';
            OptionCaption = 'Printer,Series,Order Printer';
            OptionMembers = Printer,Series,OrderPrint;
        }
        field(10; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "IT4G-LS Document";
        }
        field(20; "Store No."; Code[10])
        {
            Caption = 'Store No.';
            TableRelation = "LSC Store";
        }
        field(30; "Terminal No."; Code[10])
        {
            Caption = 'Terminal No.';
            TableRelation = "LSC POS Terminal"."No." WHERE("Store No." = FIELD("Store No."));
        }
        field(40; "Document Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(50; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(51; "Order No. Series"; Code[20])
        {
            Caption = 'Order No. Series';
            TableRelation = "No. Series";
        }
        field(60; "Report Labels"; Boolean)
        {
            Caption = 'Report Labels';
        }
        field(61; "Series Info"; Text[150])
        {
            Caption = 'Series Info';
        }
        field(62; "Tax Printer Series"; Code[10])
        {
            Caption = 'Tax Printer Series';
        }
        field(50140; "Change Card Report ID"; Integer)
        {
            Caption = 'Change Card Report ID';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(50141; "Voucher Report Id"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(50142; "Coupon Report Id"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(50143; "Document Trans. Report ID"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(60000; "Document Report WINPrint"; Code[10])
        {
            Caption = 'Report ID';
            TableRelation = "LSC POS Hardware Profile"."Profile ID";
        }
        field(60001; "Change Card WINPrint"; Code[10])
        {
            Caption = 'Change Card Report ID';
            TableRelation = "LSC POS Hardware Profile"."Profile ID";
        }
        field(60002; "Voucher Report WINPrint"; Code[10])
        {
            TableRelation = "LSC POS Hardware Profile"."Profile ID";
        }
        field(60003; "Coupon Report WINPrint"; Code[10])
        {
            TableRelation = "LSC POS Hardware Profile"."Profile ID";
        }
        field(60004; "Printing Language"; Code[10])
        {
            TableRelation = Language.Code;
        }
    }

    keys
    {
        key(Key1; "Data Type", "Code", "Store No.", "Terminal No.")
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

