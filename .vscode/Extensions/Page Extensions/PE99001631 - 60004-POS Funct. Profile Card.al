pageextension 60004 "POS Funct. Profile" extends "LSC POS Func. Profile Card"
{
    layout
    {
        addlast(content)
        {
            group("IT4G WEB Services")
            {
                Caption = 'IT4G WEB Services';
                grid(Controlx1)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group("Send Transaction Doc.")
                    {

                        field("TS Send IT4GDoc"; Rec."TS Send IT4GDoc")
                        {
                            Caption = 'Enabled';
                            ToolTip = 'Specifies the value of the TS Send IT4GDoc field.';
                            ApplicationArea = All;
                        }
                        field("Send IT4GDoc"; Rec."Send IT4GDoc")
                        {
                            Caption = 'Distribution Location';
                            ToolTip = 'Specifies the value of the Send IT4GDoc field.';
                            ApplicationArea = All;
                        }
                    }
                }
                grid(Controlx2)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                }
            }
        }
    }

}
