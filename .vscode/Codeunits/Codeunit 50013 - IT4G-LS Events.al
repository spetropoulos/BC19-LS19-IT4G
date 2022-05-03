codeunit 50013 "IT4G-LS Events"
{
    EventSubscriberInstance = StaticAutomatic;

    var
        OposUtil: Codeunit "LSC POS OPOS Utility";
        POSGUI: Codeunit "LSC POS GUI";
        cC: Codeunit "IT4G-LS Functions";
        POSView: Codeunit "LSC POS View";
        POSSESSION: Codeunit "LSC POS Session";
        cPTF: Codeunit "LSC POS Transaction Functions";
        TSAction_g: Option ,Update,Delete;

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
        rDoc: Record "IT4G-LS Document";
    begin
        if not rRetailSetup.get then exit;
        if not cC.IsIT4GRetailActive() then exit;
        if POSTrans."Entry Status" = POSTrans."Entry Status"::Voided then exit;

        Transaction."Document Code" := POSTrans."Document Code";
        rDoc.get(Transaction."Document Code");
        Transaction."Post Series" := cC.GetDocumentSeries(POSTrans."Document Code", POSTrans."Store No.", POSTrans."POS Terminal No.", Transaction.Date, enSerType::"No. Series");

        if Transaction."Post Series" = '' then error(lblSeriesNotFound + Transaction."Document Code");
        Transaction."Document No." := cNSM.GetNextNo(Transaction."Post Series", Today, true);
        Transaction."Trans. Document No." := POSTrans."Trans. Document No.";
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
        Transaction."Location Code" := POSTrans."Location Code";

        Transaction."IT4G-Loyalty Card" := POSTrans."IT4G-Loyalty Card";
        Transaction."IT4G-Loyalty ID" := POSTrans."IT4G-Loyalty ID";
        If rDoc."Cancel Document Code" <> '' then
            Transaction."Allow Cancel" := true
        else
            Transaction."Allow Cancel" := false;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'SalesEntryOnBeforeInsertV2', '', false, false)]
    local procedure SalesEntryOnBeforeInsert_IT4G(var pPOSTransLineTemp: Record "LSC POS Trans. Line" temporary; var pTransSalesEntry: Record "LSC Trans. Sales Entry")
    var
        rPT: Record "LSC POS Transaction";
    begin

        if not cC.IsIT4GRetailActive() then exit;
        rPT.GET(pPOSTransLineTemp."Receipt No.");
        pTransSalesEntry."IT4G-Doc. No." := pPOSTransLineTemp."IT4G-Doc. No.";
        pTransSalesEntry."IT4G-Doc. Line No." := pPOSTransLineTemp."IT4G-Doc. Line No.";
        pTransSalesEntry."Location Code" := pPOSTransLineTemp."Location Code";
        if pTransSalesEntry."Location Code" = '' then
            pTransSalesEntry."Location Code" := rPT."Location Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnBeforeInsertTransInventoryEntry', '', false, false)]
    local procedure OnBeforeInsertTransInventoryEntry_IT4G(var InventoryEntry: Record "LSC Trans. Inventory Entry"; var PosTransLineTmp: Record "LSC POS Trans. Line" temporary)
    var
        rPT: Record "LSC POS Transaction";
    begin
        if not cC.IsIT4GRetailActive() then exit;
        rPT.GET(PosTransLineTmp."Receipt No.");
        InventoryEntry."IT4G-Doc. No." := PosTransLineTmp."IT4G-Doc. No.";
        InventoryEntry."IT4G-Doc. Line No." := PosTransLineTmp."IT4G-Doc. Line No.";
        InventoryEntry."Location Code" := PosTransLineTmp."Location Code";
        if InventoryEntry."Location Code" = '' then
            InventoryEntry."Location Code" := rPT."Location Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnBeforeInsertPaymentEntryV2', '', false, false)]
    local procedure OnBeforeInsertPaymentEntry_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLineTemp: Record "LSC POS Trans. Line"; var TransPaymentEntry: Record "LSC Trans. Payment Entry")
    var
        rPT: Record "LSC POS Transaction";
    begin
        if not cC.IsIT4GRetailActive() then exit;
        TransPaymentEntry."IT4G-Doc. No." := POSTransLineTemp."IT4G-Doc. No.";
        TransPaymentEntry."IT4G-Doc. Line No." := POSTransLineTemp."IT4G-Doc. Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Post Utility", 'OnAfterPostTransaction', '', false, false)]
    local procedure OnAfterPostTransaction_IT4G(var TransactionHeader_p: Record "LSC Transaction Header")
    var
        cC: Codeunit "IT4G-Doc. Management";
        cWS: Codeunit "IT4G-WEB Service Functions";
    begin
        cWS.IT4G_SendLoyTransaction(TransactionHeader_p."Store No.", TransactionHeader_p."POS Terminal No.", TransactionHeader_p."Transaction No.");
        cWS.IT4G_SendAADETransaction(TransactionHeader_p."Store No.", TransactionHeader_p."POS Terminal No.", TransactionHeader_p."Transaction No.");
        cC.LSCreateIT4GDoc(TransactionHeader_p."Store No.", TransactionHeader_p."POS Terminal No.", TransactionHeader_p."Transaction No.");
        cC.LSApplyIT4GDoc(TransactionHeader_p."Store No.", TransactionHeader_p."POS Terminal No.", TransactionHeader_p."Transaction No.");
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

        POSTransaction."IT4G-Loyalty Card" := '';
        POSTransaction."IT4G-Loyalty ID" := '';

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
        rRetailSetup: Record "LSC Retail Setup";
        cF: Codeunit "IT4G-Functions";
        cInfo: Codeunit "LSC POS Infocode Utility";
    begin
        rRetailSetup.get;
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

        cPosSession.SetValue('<#IT4G_Loy_MemberID>', POSTransaction."IT4G-Loyalty ID");
        cPosSession.SetValue('<#IT4G_Loy_MemberCard>', POSTransaction."IT4G-Loyalty Card");

        cPosSession.SetValue('<#IT4G_Loy_MemberMOB>', cF.GetLoyaltyInfoPOS(1, POSTransaction."Receipt No."));
        cPosSession.SetValue('<#IT4G_Loy_MemberName>', cF.GetLoyaltyInfoPOS(2, POSTransaction."Receipt No."));
        cPosSession.SetValue('<#IT4G_Loy_MemberEmail>', cF.GetLoyaltyInfoPOS(4, POSTransaction."Receipt No."));
        cPosSession.SetValue('<#IT4G_Loy_MemberPrevPoints>', cF.GetLoyaltyInfoPOS(3, POSTransaction."Receipt No."));

        cPosSession.SetValue('IT4G_Version', 'IT4G VS:' + format(cF.GRV_Date('IT4G_Version', 0, 1)));
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

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Trans. Server Utility", 'OnBeforeSendWholeTmpTransaction', '', false, false)]
    local procedure OnBeforeSendWholeTmpTransaction_IT4G(var TransactionHeaderTemp_g: Record "LSC Transaction Header" temporary; var DCUTIL3: Codeunit "LSC Data Dir. POS Client Util"; var IsHandled: Boolean; var RetVal: Boolean)
    var
        rPT: Record "LSC POS Transaction";
        PosFuncProfile: Record "LSC POS Func. Profile";
        SendTransactionUtils: Codeunit LSCSendTransactionIT4GUtils;
        _SendingTxt1: Label 'Sending';
        SendTransactionTxt: Label 'Send Transaction';
        TransactionHeaderTemp: Record "LSC Transaction Header" temporary;
        Trans: Record "LSC Transaction Header";
        ResponseCode: Code[30];
        ErrorText: Text;
        TSUTIL: Codeunit "LSC POS Trans. Server Utility";
        RetryEntry: Record "LSC Trans. Server Work Table";
        bAddOnly: Boolean;
    begin
        IsHandled := false;
        if not cC.IsIT4GRetailActive() then exit;
        if not cC.USEIT4GtransWS() then exit;
        PosFuncProfile.get(POSSESSION.FunctionalityProfileID);

        if PosFuncProfile."TS Send Transactions" then begin
            //            IF PosFuncProfile."Use Web Replication" and PosFuncProfile."Use Background Session" then
            //              WebReplClientHandler.SetPosFunctionalityProfile(PosFuncProfile."Profile ID")
            //            else
            SendTransactionUtils.SetPosFunctionalityProfile(PosFuncProfile."Profile ID");
            if GuiAllowed then
                POSGUI.ScreenDisplay(_SendingTxt1 + ' ' + Trans.TableCaption);
            if TransactionHeaderTemp_g.FindSet then
                repeat
                    Trans.Get(TransactionHeaderTemp_g."Store No.", TransactionHeaderTemp_g."POS Terminal No.", TransactionHeaderTemp_g."Transaction No.");
                    TransactionHeaderTemp.Reset();
                    TransactionHeaderTemp.DeleteAll();
                    TransactionHeaderTemp.Init;
                    TransactionHeaderTemp := Trans;
                    TransactionHeaderTemp.Insert;
                    //                    IF PosFuncProfile."Use Web Replication" and PosFuncProfile."Use Background Session" then
                    //                        WebReplClientHandler.SendTransaction(ResponseCode, ErrorText, TransactionHeaderTemp."Refund Receipt No." = '', PosFuncProfile.TransUpdateReplCounter, TransactionHeaderTemp)
                    //                    else
                    bAddOnly := true;
                    if (TransactionHeaderTemp."Refund Receipt No." <> '') or
                        (TransactionHeaderTemp."Cancellation Type" = TransactionHeaderTemp."Cancellation Type"::Cancelled) then
                        bAddOnly := false;

                    SendTransactionUtils.SendRequest(ResponseCode, ErrorText, bAddOnly, PosFuncProfile.TransUpdateReplCounter, TransactionHeaderTemp);
                    if ErrorText <> '' then begin
                        RetryEntry.Reset;
                        RetryEntry.SetRange(Table, Database::"LSC Transaction Header");
                        RetryEntry.SetRange(Key1, Format(TransactionHeaderTemp."Transaction No."));
                        RetryEntry.SetRange(Key2, '');
                        RetryEntry.SetRange("Store No.", TransactionHeaderTemp."Store No.");
                        RetryEntry.SetRange("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
                        RetryEntry.SetRange("Transaction No.", TransactionHeaderTemp."Transaction No.");
                        if RetryEntry.FindFirst then
                            TSUTIL.UpdateTSRetryEntryErrorMessage(RetryEntry, ErrorText);
                        RetVal := (false);
                    end;
                until TransactionHeaderTemp_g.Next = 0;
            RetVal := (true);
            IsHandled := true;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Trans. Server Utility", 'OnBeforeGetPostedTransaction', '', false, false)]
    local procedure OnBeforeGetPostedTransaction_IT4G(ReceiptNo: Code[20]; pStoreNo: Code[10]; pTerminalNo: Code[10]; pTransNo: Integer; var ResponseCode: Code[30]; var ErrorText: Text; var IsHandled: Boolean; var RetVal: Boolean)
    var
        PosFuncProfile: Record "LSC POS Func. Profile";
        GetTransactionUtils: Codeunit LSCGetTransactionIT4GUtils;
        BufferUtility: Codeunit "LSC Buffer Utility";
    begin
        IsHandled := false;
        if not cC.IsIT4GRetailActive() then exit;
        if not cC.USEIT4GtransWS() then exit;
        PosFuncProfile.get(POSSESSION.FunctionalityProfileID);

        if PosFuncProfile."TS Void Transactions" then begin
            GetTransactionUtils.SetPosFunctionalityProfile(PosFuncProfile."Profile ID");
            GetTransactionUtils.SendRequest(ReceiptNo, pStoreNo, pTerminalNo, pTransNo, ResponseCode, ErrorText, BufferUtility);
            GetTransactionUtils.SetCommunicationError(ResponseCode, ErrorText);
            if ErrorText <> '' then begin
                if (ResponseCode = '0098') or (ResponseCode = '0099') then
                    if PosFuncProfile."Show Web Process Messages" then
                        Message(ErrorText);
                retVal := (false);
            end;
            retVal := (true);
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Trans. Server Utility", 'OnBeforeSendAtEndOfTransaction', '', false, false)]
    local procedure OnBeforeSendAtEndOfTransaction_IT4G(var Trans: Record "LSC Transaction Header")
    var
        rIT4Gdoc: Record "IT4G-Doc. Header";
        TSUTIL: Codeunit "LSC POS Trans. Server Utility";
    begin
        Clear(rIT4Gdoc);
        rIT4Gdoc.setrange("Created by Store No.", Trans."Store No.");
        rIT4Gdoc.setrange("Created by POS Terminal No.", Trans."POS Terminal No.");
        rIT4Gdoc.setrange("Created by Transaction No.", Trans."Transaction No.");
        if rIT4Gdoc.FINDFIRST then TSUTIL.CreateTSRetryEntry(Database::"IT4G-Doc. Header", rIT4Gdoc."Document No.", '0', '', TSAction_g::Update, 0, false, '', '', 0, '');

        Clear(rIT4Gdoc);
        rIT4Gdoc.setrange("Updated by Store No.", Trans."Store No.");
        rIT4Gdoc.setrange("Updated by POS Terminal No.", Trans."POS Terminal No.");
        rIT4Gdoc.setrange("Updated by Transaction No.", Trans."Transaction No.");
        if rIT4Gdoc.FINDFIRST then TSUTIL.CreateTSRetryEntry(Database::"IT4G-Doc. Header", rIT4Gdoc."Document No.", '0', '', TSAction_g::Update, 0, false, '', '', 0, '');
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Trans. Server Utility", 'OnAfterProcessRetryAction', '', false, false)]
    local procedure OnAfterProcessRetryAction_IT4G(var RetryAction_p: Record "LSC Trans. Server Work Table"; var Ok_p: Boolean)
    var
        cIT4GTSU: Codeunit "IT4G-Trans. Server Util";
        rIT4GDoc: Record "IT4G-Doc. Header";
        errTxt: text;
    begin
        case RetryAction_p.Table of
            Database::"IT4G-Doc. Header":
                begin
                    if not rIT4GDoc.get(RetryAction_p.Key1) then
                        Ok_p := false
                    else
                        Ok_p := cIT4GTSU.SendIt4GDoc(rIT4GDoc, errTxt)
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Transaction Events", 'OnBeforeInit', '', false, false)]
    procedure OnBeforeInit(var POSTransaction: Record "LSC POS Transaction")

    begin
        Codeunit.run(50030);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Transaction Events", 'OnBeforeProcessBarcode', '', false, false)]
    local procedure OnBeforeProcessBarcode_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text; var IsHandled: Boolean)
    var
        cC: Codeunit "IT4G-POS Commands";
    begin
        IsHandled := false;
        //        if (StrLen(CurrInput) in [14, 20]) and (CopyStr(CurrInput, 1, 1) in ['G']) then begin
        if (CopyStr(CurrInput, 1, 1) in ['G']) then begin
            cC.GetIT4GDocPressed(CurrInput);
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"LSC POS Transaction Events", 'OnBeforeItemLine', '', false, false)]
    local procedure OnBeforeItemLine_IT4G(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text)
    var
        cC: Codeunit "IT4G-POS Commands";
    begin
        //        if (StrLen(CurrInput) in [14, 20]) and (CopyStr(CurrInput, 1, 1) in ['G']) then begin
        if (CopyStr(CurrInput, 1, 1) in ['G']) then begin
            cC.GetIT4GDocPressed(CurrInput);
            CurrInput := '';
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"LSC POS Func. Profile Web Req.", 'OnAfterGetWebRequestList', '', false, false)]
    local procedure OnAfterGetWebRequestList(pProfileID: Code[20]; pServiceGrId: Integer; var pWSRequestTemp: Record "LSC POS Func. Profile Web Req." temporary)
    var
    begin
        case pServiceGrId of
            1:
                begin
                    pWSRequestTemp.InsertWebRequest(pProfileID, 'SendTransactionIT4G', pWSRequestTemp);
                end;
            2:
                begin
                    pWSRequestTemp.InsertWebRequest(pProfileID, 'GetTransactionIT4G', pWSRequestTemp);
                end;
            100:
                begin
                    pWSRequestTemp.InsertWebRequest(pProfileID, 'GetIT4GDoc', pWSRequestTemp);
                    pWSRequestTemp.InsertWebRequest(pProfileID, 'SendIT4GDoc', pWSRequestTemp);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction", 'OnProcessRefundSelection', '', false, false)]
    local procedure OnProcessRefundSelection_IT4G(OriginalTransaction: Record "LSC Transaction Header"; var POSTransaction: Record "LSC POS Transaction"; isPostVoid: Boolean)
    var
        rDoc: Record "IT4G-LS Document";
    begin
        If rDoc.Get(OriginalTransaction."Document Code") Then begin
            POSTransaction."Document Code" := rDoc."Refund Document Code";
            POSTransaction."IT4G-Loyalty Card" := OriginalTransaction."IT4G-Loyalty Card";
            POSTransaction."IT4G-Loyalty ID" := OriginalTransaction."IT4G-Loyalty ID";
            POSTransaction.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Print Utility", 'OnBeforePrintSlips', '', false, false)]
    local procedure OnBeforePrintSlips(var Transaction: Record "LSC Transaction Header"; var PrintBuffer: Record "LSC POS Print Buffer"; var PrintBufferIndex: Integer; var LinesPrinted: Integer; var MsgTxt: Text[50]; var IsHandled: Boolean; var ReturnValue: Boolean)
    var

        reportID: Integer;
    begin
        IsHandled := true;
        reportID := cC.GetDocumentPrinter(Transaction."Document Code", Transaction."Store No.", Transaction."POS Terminal No.");
        if reportID = 0 then begin
            IsHandled := false;
            exit;
        end;

        Transaction.SetRange("Store No.", Transaction."Store No.");
        Transaction.SetRange("POS Terminal No.", Transaction."POS Terminal No.");
        Transaction.SetRange("Transaction No.", Transaction."Transaction No.");
        REPORT.Run(reportID, false, true, Transaction);

    end;

}
