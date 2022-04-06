page 60013 "IT4G-WEB Service Setup Methods"
{
    Caption = 'IT4G-WEB Service Setup Methods';
    PageType = ListPart;
    SourceTable = "IT4G-WEb Service Setup Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."SubCode")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Method; Rec.Method)
                {
                    ToolTip = 'Specifies the value of the Method field.';
                    ApplicationArea = All;
                }
                field(Protocol; Rec.Protocol)
                {
                    ToolTip = 'Specifies the value of the Protocol field.';
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ToolTip = 'Specifies the value of the URL field.';
                    ApplicationArea = All;
                }
                field("Timeout (ms)"; Rec."Timeout (ms)")
                {
                    ToolTip = 'Specifies the value of the Timeout (ms) field.';
                    ApplicationArea = All;
                }

                field(Endpoint; rec.GetURL())
                {
                    ToolTip = 'Specifies the value of the URL field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
