page 60002 "IT4G-Help Table"
{

    ApplicationArea = All;
    Caption = 'IT4G-Help Table';
    PageType = List;
    SourceTable = "IT4G-Help Table";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Sort Order"; Rec."Sort Order")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Special Group Prefix"; Rec."Special Group Prefix")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Prefix; Rec.Prefix)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
        }
    }

}
