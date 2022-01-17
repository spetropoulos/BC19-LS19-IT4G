page 60008 "IT4G-Log"
{
    ApplicationArea = All;
    Caption = 'IT4G-Log';
    PageType = List;
    SourceTable = "IT4G-Log";
    SourceTableView = Sorting("Entry No.") order(descending);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field(Module; Rec.Module)
                {
                    ToolTip = 'Specifies the value of the Module field.';
                    ApplicationArea = All;
                }
                field("Batch ID"; Rec."Batch ID")
                {
                    ToolTip = 'Specifies the value of the Batch ID field.';
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the Key field.';
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
                field(Inserted; Rec.Inserted)
                {
                    ToolTip = 'Specifies the value of the Inserted field.';
                    ApplicationArea = All;
                }
                field(Modified; Rec.Modified)
                {
                    ToolTip = 'Specifies the value of the Modified field.';
                    ApplicationArea = All;
                }
                field(Errors; Rec.Errors)
                {
                    ToolTip = 'Specifies the value of the Errors field.';
                    ApplicationArea = All;
                }
                field("Job Finished"; Rec."Job Finished")
                {
                    ToolTip = 'Specifies the value of the Job Finished field.';
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
                field(Started; Rec.Started)
                {
                    ToolTip = 'Specifies the value of the Started field.';
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    ToolTip = 'Specifies the value of the Finished field.';
                    ApplicationArea = All;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
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
            }
        }
    }
}
