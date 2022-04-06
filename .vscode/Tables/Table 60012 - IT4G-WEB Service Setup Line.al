table 60012 "IT4G-WEb Service Setup Line"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "IT4G-WEb Service Setup" where(Code = field(Code));
        }
        field(2; "SubCode"; Code[20])
        {
            Caption = 'SubCode';
        }
        field(5; Description; Text[100])
        {
        }
        field(10; Method; Enum "IT4G-WEB Service Methods")
        {
        }
        field(11; Protocol; Enum "IT4G-WEB Service Protocol")
        {
        }
        field(12; URL; Text[100])
        {
        }
        field(15; "Timeout (ms)"; Integer)
        {
        }
    }

    keys
    {
        key(PK; "Code", "SubCode")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }

    var
        rWSS: Record "IT4G-WEb Service Setup";

    procedure GetURL() retURL: Text
    begin
        clear(rWSS);
        rWSS.setrange(Code, Code);
        rWSS.SetRange(Active, true);
        If rWSS.FindFirst() then begin
            retURL := format(rec.Protocol) + '://';
            retURL += rWSS."Base URL";
            retURL += rec."URL";
        end;
    end;


}

