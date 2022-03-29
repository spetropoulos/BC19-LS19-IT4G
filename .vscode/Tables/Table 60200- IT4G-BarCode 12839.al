table 60200 "IT4G-BarCode 128/39"
{
    // version IT4G,BARCODE v1.5


    fields
    {
        field(1; CharA; Code[10])
        {
        }
        field(2; CharB; Code[10])
        {
        }
        field(3; CharC; Code[10])
        {
        }
        field(4; Value; Code[3])
        {
        }
        field(5; Encoding; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; CharA)
        {
        }
        key(Key2; Value)
        {
        }
    }

    fieldgroups
    {
    }
}

