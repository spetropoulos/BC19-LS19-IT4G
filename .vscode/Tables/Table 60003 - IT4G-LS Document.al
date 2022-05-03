table 60003 "IT4G-LS Document"
{
    // version IT4G

    DrillDownPageID = 60004;
    LookupPageID = 60003;


    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Printing Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Default for"; Enum "IT4G-Document Default type")
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Customer Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Document Type"; Enum "IT4G-Doc. Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(7; "Type"; Enum "IT4G-Document Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }

        field(10; "LS Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Logoff,Logon,Sales,Payment,Remove Tender,Float Entry,Change Tender,Tender Decl.,Voided,Open Drawer,NegAdj,PhysInv,Collect,Cancelation';
            OptionMembers = Logoff,Logon,Sales,Payment,"Remove Tender","Float Entry","Change Tender","Tender Decl.",Voided,"Open Drawer",NegAdj,PhysInv,Collect,Cancelation;
        }
        field(11; "Transfer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Ship,Receive,Scan,Order,Inv';
            OptionMembers = " ",Ship,Receive,Scan,"Order",Inv;
        }
        field(50000; "Negative Inventory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "Ledger Entries"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'IT4G';
        }
        field(70001; "Ledger Entry Type"; Option)
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
            Description = 'IT4G';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(70002; "Quantity Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'IT4G';
        }
        field(70003; "Value Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'IT4G';
        }
        field(70004; "Disable Discounts"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'IT4G';
        }
        field(80004; "Shipment Reason"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "It4G-help Table".Code where(Type = Const("Shipment Reason"));
        }
        field(80005; "Shipment Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method".Code;
        }
        field(80006; "Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code".Code;
        }
        field(60000; "Series Document"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document".Code where("Type" = const(Series));
        }
        field(60001; "Printing Document"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document".Code where("Type" = const(Printer));
        }
        field(60002; "Cancel Document Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document".Code where("Type" = const(Document),
                "LS Transaction Type" = field("LS Transaction Type"));
        }
        field(60003; "Refund Document Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document".Code where("Type" = const(Document),
                "LS Transaction Type" = field("LS Transaction Type"));
        }

        field(90100; "Change Doc. POS Behavior"; enum "IT4G-Change Doc. POS Behavior")
        {
            DataClassification = ToBeClassified;
        }
        //---------------------------------------- IT4G Doc.----------------------------------------
        field(70100; "Create IT4G-Doc."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "IT4G-Doc. Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document" where("Type" = const(Document));
        }
        //---------------------------------------- IT4G Document Menus----------------------------------------
        //---------------------------------------- IT4G Document Menus----------------------------------------
        //---------------------------------------- IT4G Document Menus----------------------------------------
        field(5000; "Doc. Main Menu"; Code[20])
        {
            Caption = 'Doc. Main Menu';
            TableRelation = "LSC POS Menu Header"."Menu ID";
        }
        field(5001; "Doc. Payment Menu"; Code[20])
        {
            Caption = 'Doc. Payment Menu';
            TableRelation = "LSC POS Menu Header"."Menu ID";
        }
        field(5600; "Doc. Additional Menu 1"; Code[20])
        {
            Caption = 'Doc. Additional Menu 1';
            TableRelation = "LSC POS Menu Header"."Menu ID";
        }
        field(5601; "Doc. Additional Menu 2"; Code[20])
        {
            Caption = 'Doc. Additional Menu 2';
            TableRelation = "LSC POS Menu Header"."Menu ID";
        }
        field(5602; "Doc. Additional Menu 3"; Code[20])
        {
            Caption = 'Doc. Additional Menu 3';
            TableRelation = "LSC POS Menu Header"."Menu ID";
        }
        field(5605; "Doc. Quick Cash Menu"; Code[20])
        {
            Caption = 'Doc. Quick Cash Menu';
            TableRelation = "LSC POS Menu Header"."Menu ID";
        }
        //---------------------------------------- IT4G Series----------------------------------------
        field(1000; "Yearly Series"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Yearly Series';
        }
        field(1001; "Series Length"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Series Length';
        }
        field(1002; "IT4G Auto Create Doc. Series"; Boolean)
        {
            Caption = 'IT4G Auto Create Document Series';
            DataClassification = ToBeClassified;
        }
        field(1003; "IT4G Document Series Type"; enum "IT4G-LS Series Creation Type")
        {
            Caption = 'IT4G Document Series Type';
            DataClassification = ToBeClassified;
        }
        field(1004; "No. Series Prefix"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(1005; "Collect To Series"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1006; "Collect Series Document"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-LS Document".Code where("Type" = const(Document));
        }
        field(1007; "Do not Export"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        //---------------------------------------- IT4G Locations----------------------------------------
        field(500; "Location Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(510; "Default Store From"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
        }
        field(511; "Default From Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("Default Store From"));
        }
        field(50012; "Location From Locked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(520; "Default Store To"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
        }
        field(521; "Default To Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store Location"."Location Code" where("Store No." = field("Default Store To"));
        }
        field(522; "Location To Locked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90006; "Confirm Post"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90008; "Tax Printer Doc. Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }


        /*
                            field(70006; "Do not make LS Posting"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(70007; "Create Document Trans."; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(70008; "Document Trans. Code"; Code[10])
                            {
                                DataClassification = ToBeClassified;

                            }
                           }
                            field(80000; "Document Cust. Type"; Option)
                            {
                                Caption = 'Source Type';
                                DataClassification = ToBeClassified;
                                OptionCaption = ' ,Customer,Vendor';
                                OptionMembers = " ",Customer,Vendor;
                            }
                            field(80001; "Location Locked"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(80002; "Location From Locked"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(90002; "No. Series Prefix"; Code[5])
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(90006; "Confirm Post"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(90000; "Export Transaction"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(90001; "Company Shipment Type"; Option)
                            {
                                DataClassification = ToBeClassified;
                                OptionCaption = ' ,Same Company,Diferent Company';
                                OptionMembers = " ","Same Company","Diferent Company";
                            }
                            field(90003; "Scan Document"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(90004; "Change Slip"; Option)
                            {
                                DataClassification = ToBeClassified;
                                OptionCaption = 'Never,Ask,Allways,Repeated';
                                OptionMembers = Never,Ask,Allways,Repeated;
                            }
                            field(90005; "Allow Scan Extra Items"; Option)
                            {
                                DataClassification = ToBeClassified;
                                OptionCaption = 'Ask,Allow,Not Allow';
                                OptionMembers = Ask,Allow,"Not Allow";
                            }
                            field(90007; "Reverse Float Entry"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(90009; "Export Manual"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(4; "Related Doc Code"; Code[20])
                            {
                                DataClassification = ToBeClassified;
                                TableRelation = "IT4G-LS Document".Code WHERE("LS Transaction Type" = FIELD("LS Transaction Type"),
                                                                          "Transfer Type" = FIELD("Transfer Type"));
                            }
                            field(5; "Scan Doc Code"; Code[20])
                            {
                                DataClassification = ToBeClassified;
                                TableRelation = "IT4G-LS Document".Code WHERE("LS Transaction Type" = FIELD("LS Transaction Type"),
                                                                          "Transfer Type" = CONST(Scan));
                            }
                            field(60000; "Sales Person Mandatory"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                            field(60001; "Clear Sales Person on new Line"; Boolean)
                            {
                                DataClassification = ToBeClassified;
                            }
                    */
    }

    keys
    {
        key(Key1; "Code")
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

    procedure CheckDoc()
    var
        rDoc: Record "IT4G-LS Document";
        lblErr: Label 'There is allready Document Code %1 for default Type %2';
    begin
        if "Default for" <> "Default for"::" " then begin
            rDoc.setrange("Default for", "Default for");
            if rDoc.findfirst then error(lblErr, rDoc.Code, "Default for");
        end;
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

