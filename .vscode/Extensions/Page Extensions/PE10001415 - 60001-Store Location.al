pageextension 60001 "Store Location" extends "LSC Store Locations"
{
    layout
    {
        addlast(Control1100409000)
        {
            field("Store Location Type"; Rec."Store Location Type")
            {
                ApplicationArea = All;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("Ship-to Code"; Rec."Ship-to Code")
            {
                ApplicationArea = All;
            }
            field("Visible On POS"; Rec."Visible on POS")
            {
                ApplicationArea = All;
            }
        }
    }
}