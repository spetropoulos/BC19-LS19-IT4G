page 60007 "IT4G-Doc. Lines"
{

    Caption = 'IT4G-Doc. Lines';
    PageType = ListPart;
    SourceTable = "IT4G-Doc. Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Line Type"; Rec."Line Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Quantity Base"; Rec."Quantity Base")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
        }
    }

}
