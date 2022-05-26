page 50005 "label Printing 1"
{
    Caption = 'Barcode label Printing';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "LSC Item Label";
    SourceTableTemporary = true;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Barcodes)
            {
                field(Barcode; yBarcode)
                {
                    trigger OnValidate()
                    begin
                        QuickPrintItemLabels(yBarcode);

                    end;
                }
            }
            repeater(Control1200070000)
            {
                ShowCaption = false;
                Editable = false;
                Visible = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Variant; Rec.Variant)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Label Code"; Rec."Label Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //                    PrintBarcodes();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("Store No.", Rec."Store No.");
        Rec.SetRange("Item No.", Rec."Item No.");
        Rec.SetRange("Label Is Valid on Date", Today);
    end;

    procedure QuickPrintItemLabels(xBarcode: code[50]);
    var
        rB: Record "LSC Barcodes";
        ItemNo: Code[20];
        VariantNo: Code[20];
        TempItemLabel: Record "LSC Item Label" temporary;
        ItemLabelSetup: Record "LSC Item Label Setup";
        RetailUsers: Record "LSC Retail User";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        Store: Record "LSC Store";
        BOUtils: Codeunit "LSC BO Utils";
        BarcodeNo: Code[22];
        Qty: Decimal;
        cC: codeunit "LSC Label Utility";
    begin
        rB.Get(xBarcode);
        ItemNo := rB."Item No.";
        VariantNo := rB."Variant Code";

        Item.Get(ItemNo);
        if VariantNo <> '' then
            ItemVariant.SetFilter(Code, VariantNo);

        RetailUsers.GetUserSetup(RetailUsers, true);
        Store.Get(RetailUsers."Store No.");
        cC.FindItemLabelSetup(ItemLabelSetup, Item."No.", RetailUsers."Store No.");

        Item.SetFilter("Location Filter", Store."Location Code");
        Item.SetFilter("LSC Store Filter", Store."No.");

        TempItemLabel.DeleteAll;
        if ItemLabelSetup.FindSet then
            repeat
                TempItemLabel."Store No." := RetailUsers."Store No.";
                TempItemLabel."Item No." := ItemNo;
                TempItemLabel.Variant := '';
                TempItemLabel."Unit of Measure" := Item."Sales Unit of Measure";
                TempItemLabel."Label Is Valid on Date" := Today;
                TempItemLabel."Label Code" := ItemLabelSetup."Label Code";
                TempItemLabel.Quantity := ItemLabelSetup."Fixed Quantity";
                TempItemLabel.InitRecord(ItemLabelSetup);


                ItemVariant.SetFilter("Item No.", Item."No.");
                if ItemVariant.FindSet then
                    repeat
                        Qty := 1;
                        TempItemLabel.Variant := ItemVariant.Code;
                        if TempItemLabel.Variant <> '' then begin
                            BarcodeNo := xBarcode;
                            if BarcodeNo <> '' then
                                TempItemLabel."Barcode No." := BarcodeNo;
                        end;
                        if TempItemLabel.Insert then;
                    until ItemVariant.Next = 0;

            until ItemLabelSetup.Next = 0;

        if TempItemLabel.FindFirst then PrintBarcodes(TempItemLabel);
    end;

    procedure PrintBarcodes(var TempItemLabel: Record "LSC Item Label" temporary)

    var
        ItemLabel: Record "LSC Item Label";
        TempLabelCommand: Record "LSC Label Functions" temporary;
        LabelCommand: Record "LSC Label Functions";
    begin
        if TempItemLabel.FindSet then
            repeat
                if TempItemLabel."Label Code" <> '' then begin
                    TempLabelCommand."Label Code" := TempItemLabel."Label Code";
                    if TempLabelCommand.Insert then;
                    if ItemLabel.Get(TempItemLabel."Store No.", TempItemLabel."Item No.", TempItemLabel.Variant, TempItemLabel."Unit of Measure",
                        TempItemLabel."Label Is Valid on Date", TempItemLabel."Label Code") then begin
                        ItemLabel.TransferFields(TempItemLabel);
                        ItemLabel.Printed := false;
                        ItemLabel."Order From Code" := 'I' + TempItemLabel."Item No.";
                        ItemLabel.CalculatePrice;
                        ItemLabel.Modify;
                    end else begin
                        Clear(ItemLabel);
                        ItemLabel.TransferFields(TempItemLabel);
                        ItemLabel."Order From Code" := 'I' + TempItemLabel."Item No.";
                        ItemLabel.Insert;
                    end;
                end;
            until TempItemLabel.Next = 0;

        if TempLabelCommand.FindSet then
            repeat
                ItemLabel.SetRange("Store No.", TempItemLabel."Store No.");
                ItemLabel.SetRange("Label Code", TempLabelCommand."Label Code");
                ItemLabel.SetRange("Label Is Valid on Date", TempItemLabel."Label Is Valid on Date");
                ItemLabel.SetRange(Printed, false);
                ItemLabel.SetRange("Order From Code", 'I' + TempItemLabel."Item No.");
                LabelCommand.Get(LabelCommand.Type::"Item Label", TempLabelCommand."Label Code");
                CODEUNIT.Run(LabelCommand."Run Codeunit", ItemLabel);
            until TempLabelCommand.Next = 0;


    end;


    var
        yBarcode: code[50];

}