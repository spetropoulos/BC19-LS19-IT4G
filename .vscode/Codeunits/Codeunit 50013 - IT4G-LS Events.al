codeunit 50013 "IT4G-LS Events"
{
    EventSubscriberInstance = StaticAutomatic;

    var
        OposUtil: Codeunit "LSC POS OPOS Utility";
        POSGUI: Codeunit "LSC POS GUI";
        cC: Codeunit "IT4G-LS Functions";
        POSView: Codeunit "LSC POS View";
        cPTF: Codeunit "LSC POS Transaction Functions";

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Transaction", 'OnBeforePostTransaction', '', false, false)]
    procedure OnBeforePostTransaction_IT4G(var Rec: Record "LSC POS Transaction"; var IsHandled: boolean)
    var
        rRetailSetup: Record "LSC Retail Setup";
        retText: Text;
        POSTransPostingStateTmp: Record "LSC POS Trans. Posting State" temporary;
    begin
        IsHandled := false;
        if not rRetailSetup.get then exit;
        if not cC.IsIT4GRetailActive() then exit;

        if not cC.CheckIT4GDoc(Rec, retText) then begin
            if retText <> '' then POSGUI.PosMessage(retText);
            IsHandled := true;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnAfterInsertTransaction', '', false, false)]
    procedure OnAfterInsertTransaction_IT4G(var POSTrans: Record "LSC POS Transaction"; var Transaction: Record "LSC Transaction Header")
    var
        cNSM: Codeunit NoSeriesManagement;
        rRetailSetup: Record "LSC Retail Setup";
        lblSeriesNotFound: label 'No Document series setup found for Document Code ';
        enSerType: enum "IT4G-DocSeriesRetType";
    begin
        if not rRetailSetup.get then exit;
        if not cC.IsIT4GRetailActive() then exit;
        if POSTrans."Entry Status" = POSTrans."Entry Status"::Voided then exit;

        Transaction."Document Code" := POSTrans."Document Code";
        Transaction."Post Series" := cC.GetDocumentSeries(POSTrans."Document Code", POSTrans."Store No.", POSTrans."POS Terminal No.", Transaction.Date, enSerType::"No. Series");

        if Transaction."Post Series" = '' then error(lblSeriesNotFound + Transaction."Document Code");
        Transaction."Document No." := cNSM.GetNextNo(Transaction."Post Series", Today, true);

        Transaction.Comment := Transaction."Document No.";

        Transaction."Offline Document No." := POSTrans."Offline Document No.";
        Transaction."External Doc. No." := POSTrans."External Doc. No.";
        Transaction."To Location" := POSTrans."To Location";
        Transaction."To Store" := POSTrans."To Store";
        Transaction."From Location" := POSTrans."From Location";
        Transaction."From Store" := POSTrans."From Store";
        Transaction."Reason Code" := POSTrans."Reason Code";
        Transaction."Related Doc. No." := POSTrans."Related Doc. No.";
        Transaction."Shipment Method" := POSTrans."Shipment Method";
        Transaction."Shipment Reason" := POSTrans."Shipment Reason";
        Transaction."WEB Order No." := POSTrans."WEB Order No.";

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'SalesEntryOnBeforeInsertV2', '', false, false)]
    local procedure SalesEntryOnBeforeInsert_IT4G(var pPOSTransLineTemp: Record "LSC POS Trans. Line" temporary; var pTransSalesEntry: Record "LSC Trans. Sales Entry")
    var
    begin
        if not cC.IsIT4GRetailActive() then exit;
        pTransSalesEntry."IT4G-Doc. No." := pPOSTransLineTemp."IT4G-Doc. No.";
        pTransSalesEntry."IT4G-Doc. Line No." := pPOSTransLineTemp."IT4G-Doc. Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnBeforeInsertTransInventoryEntry', '', false, false)]
    local procedure OnBeforeInsertTransInventoryEntry_IT4G(var InventoryEntry: Record "LSC Trans. Inventory Entry"; var PosTransLineTmp: Record "LSC POS Trans. Line" temporary)
    var
    begin
        if not cC.IsIT4GRetailActive() then exit;
        InventoryEntry."IT4G-Doc. No." := PosTransLineTmp."IT4G-Doc. No.";
        InventoryEntry."IT4G-Doc. Line No." := PosTransLineTmp."IT4G-Doc. Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnBeforeInsertPaymentEntryV2', '', false, false)]
    local procedure OnBeforeInsertPaymentEntry_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLineTemp: Record "LSC POS Trans. Line"; var TransPaymentEntry: Record "LSC Trans. Payment Entry")
    var
    begin
        if not cC.IsIT4GRetailActive() then exit;
        TransPaymentEntry."IT4G-Doc. No." := POSTransLineTemp."IT4G-Doc. No.";
        TransPaymentEntry."IT4G-Doc. Line No." := POSTransLineTemp."IT4G-Doc. Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnAfterPostTransaction', '', false, false)]
    local procedure OnAfterPostTransaction_IT4G(var TransactionHeader_p: Record "LSC Transaction Header")
    var
        cC: Codeunit "IT4G-Doc. Management";

    begin
        cC.LSCreateIT4GDoc(TransactionHeader_p."Store No.", TransactionHeader_p."POS Terminal No.", TransactionHeader_p."Transaction No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterStartNewTransaction', '', false, false)]
    local procedure OnAfterStartNewTransaction_IT4G(var POSTransaction: Record "LSC POS Transaction");
    var
        rDoc: Record "IT4G-LS Document";
    begin
        if not cC.IsIT4GRetailActive() then exit;

        POSTransaction."Document Code" := '';
        POSTransaction."Offline Document No." := '';
        POSTransaction."Offline Doc. Date" := 0D;

        POSTransaction."From Store" := '';
        POSTransaction."From Location" := '';
        POSTransaction."To Store" := '';
        POSTransaction."To Location" := '';
        POSTransaction."Shipment Reason" := '';
        POSTransaction."Shipment Method" := '';
        POSTransaction."Reason Code" := '';
        POSTransaction."External Doc. No." := '';
        POSTransaction."Related Doc. No." := '';
        POSTransaction."WEB Order No." := '';

        if POSTransaction."Transaction Type" = POSTransaction."Transaction Type"::Sales then
            If POSTransaction."Sale Is Return Sale" then
                rDoc.SetRange("Default for", rDoc."Default for"::"Refund Sale")
            else
                rDoc.SetRange("Default for", rDoc."Default for"::Sales);

        if rDoc.findfirst then cC.WriteDocumentCode(POSTransaction, rDoc.Code);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterGetContext', '', false, false)]
    local procedure OnAfterGetContext_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text)
    var
        cPosSession: Codeunit "LSC POS Session";
    begin
        if not cC.IsIT4GRetailActive() then exit;
        cPosSession.SetValue('IT4G_DocInfo', cC.GetDocInfo(POSTransaction));
        cPosSession.SetValue('IT4G_FromStore', POSTransaction."From Store");
        cPosSession.SetValue('IT4G_FromLoc', POSTransaction."From Location");
        cPosSession.SetValue('IT4G_ToStore', POSTransaction."To Store");
        cPosSession.SetValue('IT4G_ToLoc', POSTransaction."To Location");
        cPosSession.SetValue('IT4G_OfflineDoc', POSTransaction."Offline Document No.");
        cPosSession.SetValue('IT4G_OfflineDate', format(POSTransaction."Offline Doc. Date"));
        cPosSession.SetValue('IT4G_ShipReason', POSTransaction."Shipment Reason");
        cPosSession.SetValue('IT4G_ShipMethod', POSTransaction."Shipment Method");
        cPosSession.SetValue('IT4G_ReasonCode', POSTransaction."Reason Code");
        cPosSession.SetValue('IT4G_ExtDocNo', POSTransaction."External Doc. No.");
        cPosSession.SetValue('IT4G_RelDocNo', POSTransaction."Related Doc. No.");
        cPosSession.SetValue('IT4G_WEBOrderNo', POSTransaction."WEB Order No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterTenderKeyPressedEx', '', false, false)]
    local procedure OnAfterTenderKeyPressedEx_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text; var TenderTypeCode: Code[10]; var TenderAmountText: Text; var IsHandled: Boolean)
    var
        xType: Enum "IT4G-Document Relation Type";
        lblTenerTypeErr: Label 'Tender Type %1 not Allowed!!! \Check Document Relation Setup';
    begin
        if not cC.IsIT4GRetailActive() then exit;
        if not cC.IsCodeRelationAllowed(xType::"Tender Type",
            POSTransaction."Document Code",
            POSTransaction."Store No.",
            POSTransaction."POS Terminal No.",
            POSTransaction."Staff ID",
            TenderTypeCode) then begin
            ErrorBeep(StrSubstNo(lblTenerTypeErr, TenderTypeCode));
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeInsertItemLine', '', false, false)]
    local procedure OnBeforeInsertItemLine_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text)
    var
        rDoc: Record "IT4G-LS Document";
    begin
        if not cC.IsIT4GRetailActive() then exit;
        if not rDoc.get(POSTransaction."Document Code") then exit;
        if (not rDoc."Value Entry") or (rDoc."Disable Discounts") then begin
            POSTransLine."System-Block Manual Discount" := true;
            POSTransLine."System-Block Periodic Discount" := true;
            POSTransLine."System-Block Promotion Price" := true;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Price Utility", 'OnAfterGetPrice', '', false, false)]
    local procedure OnAfterGetPrice_IT4G(var POSTransLine: Record "LSC POS Trans. Line")
    var
        rH: Record "LSC POS Transaction";
        rDoc: Record "IT4G-LS Document";
    begin
        if not cC.IsIT4GRetailActive() then exit;
        If not rH.get(POSTransLine."Receipt No.") then exit;
        if not rDoc.get(rH."Document Code") then exit;
        if (not rDoc."Value Entry") then begin
            POSTransLine.Price := 0;
        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::lscGetTransactionUtils, 'OnAfterGetXmlPortNo', '', false, false)]
    local procedure OnAfterGetXmlPortNo(var XmlPortNo: Integer)
    begin
        XmlPortNo := 50004;
    end;

    procedure ErrorBeep(Txt: Text[150])
    begin
        //ErrorBeep
        OposUtil.Beeper;
        OposUtil.Beeper;

        POSGUI.PosMessage(Txt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Controller", 'OnBeforeSelectDefaultMenu', '', false, false)]
    local procedure OnBeforeSelectDefaultMenu_IT4G(var SelectedMenu: code[20])
    var
        rPT: record "LSC POS Transaction";
        rD: Record "IT4G-LS Document";
    begin
        if not rPT.get(POSview.GetReceiptNo()) then exit;
        if rPT."Document Code" = '' then exit;
        if not rD.get(rPT."Document Code") then exit;

        case POSView.GetPosState of
            'PAYMENT':
                SelectedMenu := (rD."Doc. Payment Menu")
            else
                SelectedMenu := (rD."Doc. Main Menu");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Session", 'OnBeforeGetMenu', '', false, false)]
    local procedure OnBeforeGetMenu_IT4G(var SelectedMenu: Code[20]; MenuType: Enum "LSC Menu Types")
    var
        rPT: record "LSC POS Transaction";
        rD: Record "IT4G-LS Document";
    begin
        SelectedMenu := '';
        if not rPT.get(POSview.GetReceiptNo()) then exit;
        if rPT."Document Code" = '' then exit;
        if not rD.get(rPT."Document Code") then exit;
        Case MenuType of
            "MenuType"::Start:
                SelectedMenu := '';
            "MenuType"::Sales:
                SelectedMenu := rD."Doc. Main Menu";
            "MenuType"::Refund:
                SelectedMenu := rD."Doc. Main Menu";
            "MenuType"::Payment:
                SelectedMenu := rD."Doc. Payment Menu";
            "MenuType"::Tender:
                SelectedMenu := rD."Doc. Main Menu";
            "MenuType"::NegAdj:
                SelectedMenu := rD."Doc. Main Menu";
            "MenuType"::Add1:
                SelectedMenu := rD."Doc. Additional Menu 1";
            "MenuType"::Add2:
                SelectedMenu := rD."Doc. Additional Menu 2";
            "MenuType"::Add3:
                SelectedMenu := rD."Doc. Additional Menu 3";
            "MenuType"::QuickCash:
                SelectedMenu := rD."Doc. Quick Cash Menu";
        End
    end;
}
