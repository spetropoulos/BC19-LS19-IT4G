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
                    cC: Codeunit "IT4G - WEB Service Functions";
                begin
                    cC.Pobuca_RetrieveAccount(xInput, xRet);
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
                    cC: Codeunit "IT4G - WEB Service Functions";
                begin
                    cC.Pobuca_SubmitInvoice(xStore, xPOS, xTransNo, xRet);
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
