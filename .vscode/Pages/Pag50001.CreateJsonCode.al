page 50001 "Create Json Code"
{
    Caption = 'Create Json Code';
    PageType = Card;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group("Input Text")
            {
                field(Input; xInput)
                {
                    MultiLine = true;
                }
            }
            group("Output Text")
            {
                field(Output; xOutput)
                {
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Code")
            {
                trigger OnAction()
                var
                    cC: Codeunit "IT4G-Generate Json Code";
                begin
                    xOutput := cC.GenerateJsonCode(xInput);
                end;
            }
            action("Generate Json")
            {
                trigger OnAction()
                var
                begin
                    codeunit.run(50003);
                end;
            }
        }
    }
    var
        xInput: Text;
        xOutPut: Text;
}
