page 50000 "Test Loy"
{
    Caption = 'Test Page';
    PageType = List;
    UsageCategory = Administration;

    SourceTable = "IT4G-Log";
    SourceTableView = Sorting("Entry No.") order(descending);

    layout
    {
        area(content)
        {
            group("Input")
            {
                group("Member Card")
                {
                    field(Card; xinput) { }
                }
                group("Transaction")
                {
                    field(Store; xStore) { }
                    field(POS; xPOS) { }
                    field("Trans. No."; xTransNo) { }
                }
            }
            group(Messages)
            {
                field(Message; xRet)
                {
                    Editable = false;
                    MultiLine = true;
                }
            }
            repeater(Log)
            {
                field("Batch ID"; Rec."Batch ID")
                {
                    ToolTip = 'Specifies the value of the Batch ID field.';
                    ApplicationArea = All;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field(Errors; Rec.Errors)
                {
                    ToolTip = 'Specifies the value of the Errors field.';
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    ToolTip = 'Specifies the value of the Finished field.';
                    ApplicationArea = All;
                }
                field(Inserted; Rec.Inserted)
                {
                    ToolTip = 'Specifies the value of the Inserted field.';
                    ApplicationArea = All;
                }
                field("Job Finished"; Rec."Job Finished")
                {
                    ToolTip = 'Specifies the value of the Job Finished field.';
                    ApplicationArea = All;
                }
                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the Key field.';
                    ApplicationArea = All;
                }
                field(Modified; Rec.Modified)
                {
                    ToolTip = 'Specifies the value of the Modified field.';
                    ApplicationArea = All;
                }
                field(Module; Rec.Module)
                {
                    ToolTip = 'Specifies the value of the Module field.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Posting Time"; Rec."Posting Time")
                {
                    ToolTip = 'Specifies the value of the Posting Time field.';
                    ApplicationArea = All;
                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.';
                    ApplicationArea = All;
                }
                field(Skipped; Rec.Skipped)
                {
                    ToolTip = 'Specifies the value of the Skipped field.';
                    ApplicationArea = All;
                }
                field(Started; Rec.Started)
                {
                    ToolTip = 'Specifies the value of the Started field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Status Text"; Rec."Status Text")
                {
                    ToolTip = 'Specifies the value of the Status Text field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User field.';
                    ApplicationArea = All;
                }
                field("WEB Service Code"; Rec."WEB Service Code")
                {
                    ToolTip = 'Specifies the value of the WEB Service Code field.';
                    ApplicationArea = All;
                }
                field("WEB Service Status"; Rec."WEB Service Status")
                {
                    ToolTip = 'Specifies the value of the WEB Service Status field.';
                    ApplicationArea = All;
                }
                field("WEB Service URL"; Rec."WEB Service URL")
                {
                    ToolTip = 'Specifies the value of the WEB Service URL field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Member Info")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Get Member Info';
                trigger OnAction()
                var
                    cC: Codeunit "IT4G-WEB Service Functions";
                begin
                    cC.IT4G_getMember(xInput, xRet);
                end;
            }
            action("Send POBUCA Invoice")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Send POBUCA Invoice';
                trigger OnAction()
                var
                    cC: Codeunit "IT4G-WEB Service Functions";
                begin
                    cC.IT4G_SendLoyTransaction(xStore, xPOS, xTransNo, xRet);
                end;
            }
            action("Send AADE")
            {
                ApplicationArea = All;
                Tooltip = '';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Send AADE';
                trigger OnAction()
                var
                    cC: Codeunit "IT4G-WEB Service Functions";
                begin
                    cC.IT4G_SendAADETransaction(xStore, xPOS, xTransNo, xRet);
                end;
            }
        }
    }
    var
        xinput: text;
        xRet: Text;
        xStore: code[20];
        xPOS: code[20];
        xTransNo: Integer;
}
