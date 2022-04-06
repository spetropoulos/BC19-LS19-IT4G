page 60005 "IT4G-LS Document Relations"
{

    ApplicationArea = All;
    Caption = 'IT4G-LS Document Relations';
    PageType = List;
    SourceTable = "IT4G-LS Document Relations";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Relation)
            {
                field("Document Code"; Rec."Document Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Tooltip = '';
                }

                field("Description"; rDoc.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Tooltip = '';
                }

            }
            repeater(General)
            {

                field("Relation Type"; Rec."Relation Type")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Relation Code"; Rec."Relation Code")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Relation Description"; Rec.GetRelationDescr())
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Terminal No."; Rec."Terminal No.")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
                field("Staff ID"; Rec."Staff ID")
                {
                    ApplicationArea = All;
                    Tooltip = '';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Create Document Tender Type")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Create Document Tender Type';

                trigger OnAction();
                var
                    rDoc: Record "IT4G-LS Document";
                    rDR: Record "IT4G-LS Document Relations";
                    rTTS: Record "LSC Tender Type Setup";
                begin
                    clear(rDOc);
                    If rDoc.findset then
                        repeat
                            clear(rTTS);
                            if rTTS.findset then
                                repeat
                                    clear(rDR);
                                    rDR."Relation Type" := rDR."Relation Type"::"Tender Type";
                                    rDR."Document Code" := rDoc.Code;
                                    rDR."Relation Code" := rTTS.Code;
                                    if rDR.insert(true) then;
                                until rTTS.next = 0;
                        until rDoc.next = 0;
                end;

            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if not rDoc.get("Document Code") then clear(rDoc);

    end;

    var
        rDoc: Record "IT4G-LS Document";

}
