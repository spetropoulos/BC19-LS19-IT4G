table 60011 "IT4G-WEb Service Setup"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Type"; Option)
        {
            OptionMembers = Test,Live;
            Caption = 'Type';
            Editable = false;
        }
        field(3; "Active"; Boolean)
        {
            Caption = 'Active';
            trigger OnValidate()
            var
            begin
                Clear(rRec);
                case rec.Type of
                    rec.type::Live:
                        rRec.Get(rec.Code, rec.Type::Test);
                    rec.type::Test:
                        rRec.Get(rec.Code, rec.Type::Live);
                end;
                rRec.Active := Not Active;
                rRec.modify;
            end;
        }
        field(5; Description; Text[100])
        {
        }
        field(12; "Base URL"; Text[100])
        {
        }
        field(13; "URL var 1"; Text[100])
        {
        }
        field(14; "URL var 2"; Text[100])
        {
        }
        field(15; "URL var 3"; Text[100])
        {
        }
        field(16; "URL var 4"; Text[100])
        {
        }
        field(20; "Authentication Key"; Text[100])
        {
        }
        field(100; "Debug"; Boolean)
        {
        }
        field(101; "Debug Path"; Text[100])
        {
        }
        field(110; "Logging"; Option)
        {
            OptionMembers = None,"Only Errors",All;
        }
        field(200; "User Name"; text[100])
        {
        }
        field(201; "User Password"; text[100])
        {
        }
        field(500; "No. of Services"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("IT4G-WEb Service Setup Line" where("Code" = FIELD("Code")));
        }

    }

    keys
    {
        key(PK; "Code", "Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        rRec: Record "IT4G-WEb Service Setup";

    trigger OnInsert()
    begin
        rec.Active := true;
        rec.Logging := Logging::All;
    end;

    trigger OnDelete()
    var
        rL: Record "IT4G-WEb Service Setup Line";
    begin
        rRec.SetRange(Code, rec.Code);
        rL.setrange(Code, rec.Code);
        rRec.Deleteall();
        rL.DeleteAll();
    end;

    procedure createMirrorService()
    var
        rNew: Record "IT4G-WEb Service Setup";
    begin
        clear(rNEW);
        rNew.TransferFields(rec);
        rNew.Active := not rNew.Active;
        rNew.Type := rNew.Type::Live;
        if not rNew.insert then begin
            rNew.Type := rNew.Type::Test;
            if rNew.insert then;
        end;
    end;
}

