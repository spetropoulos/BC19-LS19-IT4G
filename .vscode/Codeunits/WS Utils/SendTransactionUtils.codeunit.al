codeunit 50061 LSCSendTransactionIT4GUtils
{
    trigger OnRun()
    begin
        RunRequest;
    end;

    var
        WebSetup: Record "LSC Web Service Setup";
        SessionKeyValues_g: Codeunit "LSC Session Key Values";
        BufferUtility: Codeunit "LSC Buffer Utility";
        POSFunctionalityProfileCode_g: Code[10];
        ErrorText_g: Text;
        XmlPortNo_g: Integer;
        AddOnly_g: Boolean;
        UpdateReplicationCounter_g: Boolean;

    local procedure RunRequest()
    var
        WebRequestFieldMappingTemp: Record "LSC Web Request Field Mapping" temporary;
        TableBufferTemp: Record "LSC Web Table Buffer" temporary;
        TransactionHeaderTemp: Record "LSC Transaction Header" temporary;
        RecRef: RecordRef;
        RecRefTemp: RecordRef;
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        SomethingMissingTxt: Label '%1 missing.';
    begin
        //SendTransaction
        if not WebSetup.Get then
            Clear(WebSetup);
        if WebSetup."Select Latest Version" then
            SelectLatestVersion;

        RecRef.GETTABLE(TransactionHeaderTemp);
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);
        if TransactionHeaderTemp.IsEmpty then begin
            ErrorText_g := StrSubstNo(SomethingMissingTxt, TransactionHeaderTemp.TableCaption);
            exit;
        end;
        if not AddOnly_g then //Buffer is only used when add only is false (= update if exist)
            WebRequestFunctions.GetXmlPortFields(Format(Enum::"LSC Web Services"::SendTransactionIT4G), XmlPortNo_g, WebRequestFieldMappingTemp);

        BufferUtility.GetTableList(TableBufferTemp);
        TableBufferTemp.RESET;
        TableBufferTemp.SETRANGE("Record Index", 2);
        IF TableBufferTemp.FINDSET THEN
            REPEAT
                RecRefTemp.OPEN(TableBufferTemp."Table No.", TRUE);
                WebRequestFunctions.GetTableDataXML(BufferUtility, RecRefTemp);
                WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::SendTransactionIT4G), AddOnly_g, RecRefTemp, UpdateReplicationCounter_g, WebRequestFieldMappingTemp);
                RecRefTemp.CLOSE;
            UNTIL TableBufferTemp.NEXT = 0;
    end;

#if __IS_SAAS__
    internal
#endif
    procedure SetRequest(AddOnly: Boolean; UpdateReplicationCounter: Boolean; XmlPortNo: Integer; VAR BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        ClientSessionUtility: Codeunit "LSC Client Session Utility";
    begin
        AddOnly_g := AddOnly;
        UpdateReplicationCounter_g := UpdateReplicationCounter;
        XmlPortNo_g := XmlPortNo;
        BufferUtility := BufferUtility_p;
    end;

#if __IS_SAAS__
    internal
#endif
    procedure SendRequest(var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; var TransactionHeaderTemp: Record "LSC Transaction Header" temporary)
    var
        WebServiceSetup: Record "LSC Web Service Setup";
        WSServerBuffer: Record "LSC WS Server Buffer" temporary;
        SendTransaction: Codeunit LSCSendTransactionIT4G;
        RequestHandler: Codeunit "LSC Request Handler";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        WebRequestDataMgt: Codeunit "LSC Web Request Data Mgt";
        SendTransactionXML: XmlPort SendTransactionIT4GXML;
        LogFileID: Text;
        ReqDateTime: DateTime;
        RequestOk: Boolean;
        Handled: Boolean;
        URIMissingTxt: Label 'Web Server URI is Missing for Request %1';
    begin
        RequestOk := false;
        ReqDateTime := CurrentDateTime;
        LogFileID := WebRequestFunctions.CreateLogFileID(ReqDateTime);
        RequestHandler.GetWebServerList(Format(Enum::"LSC Web Services"::SendTransactionIT4G), POSFunctionalityProfileCode_g, WSServerBuffer);
        WSServerBuffer.Reset;
        if WSServerBuffer.FindSet then begin
            CLEAR(BufferUtility);
            WebRequestDataMgt.LoadTransactionTables(TransactionHeaderTemp, BufferUtility);
            repeat
                if WSServerBuffer."Local Request" then begin
                    SessionKeyValues_g.SetValue('#LOCALREQUEST', 'TRUE');
                    OnBeforeSendLocalRequest(ResponseCode, ErrorText, AddOnly, UpdateReplicationCounter, BufferUtility, Handled);
                    IF not Handled then begin
                        Clear(SendTransactionXML);
                        SendTransactionXML.SetTransactionTables(BufferUtility);
                        SendTransactionXML.Export;
                        Commit;
                        SendTransaction.SendTransaction(ResponseCode, ErrorText, AddOnly, UpdateReplicationCounter, SendTransactionXML);
                    end;
                    SessionKeyValues_g.SetValue('#LOCALREQUEST', 'FALSE');
                    RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", 'Local', 'Local', '');
                    //Transaction not saved - local request
                end else begin
                    RequestHandler.FindDestURI(Format(Enum::"LSC Web Services"::SendTransactionIT4G), WSServerBuffer);
                    WSServerBuffer."Web Service URI" := WebRequestFunctions.ConvertToNewUrl(WSServerBuffer."Web Service URI");
                    WSServerBuffer."Log File ID" := LogFileID;
                    PostSendTransaction(WSServerBuffer, ResponseCode, ErrorText, AddOnly, UpdateReplicationCounter, BufferUtility);
                    if ResponseCode <> '0098' then
                        RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", WSServerBuffer."Dist. Location", WSServerBuffer."Web Service URI", ErrorText);
                end;
            until (WSServerBuffer.Next = 0) or RequestOk
        end else begin
            ErrorText := StrSubstNo(URIMissingTxt, Format(Enum::"LSC Web Services"::SendTransactionIT4G));
            RequestHandler.AddToConnLog('', '', '', ErrorText);
        end;
        WebServiceSetup.Get;
        if WebServiceSetup."Client Log On" and GuiAllowed then
            RequestHandler.LogConnURI(Format(Enum::"LSC Web Services"::SendTransactionIT4G), LogFileID);
    end;

#if __IS_SAAS__
    internal
#endif
    procedure GetResponse(var ErrorText: Text)
    begin
        ErrorText := ErrorText_g;
    end;

    local procedure PostSendTransaction(var WSServerBuffer: Record "LSC WS Server Buffer"; var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        ReqNodeBuffer: Record "LSC WS Node Buffer" temporary;
        ResNodeBuffer: Record "LSC WS Node Buffer" temporary;
        TransactionHeaderTemp: Record "LSC Transaction Header" temporary;
        TransSalesEntryTemp: Record "LSC Trans. Sales Entry" temporary;
        TransPaymentEntryTemp: Record "LSC Trans. Payment Entry" temporary;
        TransIncomeExpenseEntryTemp: Record "LSC Trans. Inc./Exp. Entry" temporary;
        TransCouponEntryTemp: Record "LSC Trans. Coupon Entry" temporary;
        TransInfocodeEntryTemp: Record "LSC Trans. Infocode Entry" temporary;
        TransTenderDeclarEntryTemp: Record "LSC Trans. Tender Declar. Entr" temporary;
        TransInventoryEntryTemp: Record "LSC Trans. Inventory Entry" temporary;
        TransMixMatchEntryTemp: Record "LSC Trans. Mix & Match Entry" temporary;
        TransCashDeclarationTemp: Record "LSC Trans. Cash Declaration" temporary;
        TransSafeEntryTemp: Record "LSC Trans. Safe Entry" temporary;
        POSCardEntryTemp: Record "LSC POS Card Entry" temporary;
        POSVoidedTransLineTemp: Record "LSC POS Voided Trans. Line" temporary;
        TransactionStatusTemp: Record "LSC Transaction Status" temporary;
        TransSalesEntryStatusTemp: Record "LSC Trans. Sales Entry Status" temporary;
        TransactionOrderHeaderTemp: Record "LSC Transaction Order Header" temporary;
        TransactionOrderEntryTemp: Record "LSC Transaction Order Entry" temporary;
        TransDiscountEntryTemp: Record "LSC Trans. Discount Entry" temporary;
        TransDiscBenefitEntryTemp: Record "LSC Trans. Disc. Benefit Entry" temporary;
        TransPointEntryTemp: Record "LSC Trans. Point Entry" temporary;
        TransactionOrderDiscountTemp: Record "LSC Transaction Order Discount" temporary;
        TransDealEntryTemp: Record "LSC Trans. Deal Entry" temporary;
        TransHospitalityEntryTemp: Record "LSC Trans. Hospitality Entry" temporary;
        TransInvAdjmtEntryTemp: Record "LSC Trans. Inv. Adjmt. Entry" temporary;
        TransInvAdjmtEntryStTemp: Record "LSC Trans. Inv Adjmt. Entry St" temporary;
        TransactionSignatureTemp: Record "LSC Transaction Signature" temporary;
        TransSalesTaxEntryTemp: Record "LSC Trans. SalesTax Entry" temporary;
        ReqRecRefArray: array[32] of RecordRef;
        ResRecRefArray: array[32] of RecordRef;
        RecRef: RecordRef;
        WebRequestHandler: Codeunit "LSC Web Request Handler";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        ProcessErrorText: Text;
    begin
        //Request
        WebRequestHandler.AddNodeToBuffer('responseCode', '', ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('errorText', '', ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('addOnly', Format(AddOnly, 0, 9), ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('updateReplicationCounter', Format(UpdateReplicationCounter, 0, 9), ReqNodeBuffer);
        RecRef.GETTABLE(TransactionHeaderTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransactionHeader', TransactionHeaderTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransSalesEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransSalesEntry', TransSalesEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransPaymentEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransPaymentEntry', TransPaymentEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransIncomeExpenseEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransIncomeExpenseEntry', TransIncomeExpenseEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransCouponEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransCouponEntry', TransCouponEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransInfocodeEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransInfocodeEntry', TransInfocodeEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransTenderDeclarEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransTenderDeclarEntry', TransTenderDeclarEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransInventoryEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransInventoryEntry', TransInventoryEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransMixMatchEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransMixMatchEntry', TransMixMatchEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransCashDeclarationTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransCashDeclaration', TransCashDeclarationTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransSafeEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransSafeEntry', TransSafeEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(POSCardEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('POSCardEntry', POSCardEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(POSVoidedTransLineTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('POSVoidedTransLine', POSVoidedTransLineTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransactionStatusTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransactionStatus', TransactionStatusTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransSalesEntryStatusTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransSalesEntryStatus', TransSalesEntryStatusTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransactionOrderHeaderTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransactionOrderHeader', TransactionOrderHeaderTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransactionOrderEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransactionOrderEntry', TransactionOrderEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransDiscountEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransDiscountEntry', TransDiscountEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransDiscBenefitEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransDiscBenefitEntry', TransDiscBenefitEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransPointEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransPointEntry', TransPointEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransactionOrderDiscountTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransactionOrderDiscount', TransactionOrderDiscountTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransDealEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransDealEntry', TransDealEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransHospitalityEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransHospitalityEntry', TransHospitalityEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransInvAdjmtEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransInvAdjmtEntry', TransInvAdjmtEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransInvAdjmtEntryStTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransInvAdjmtEntrySt', TransInvAdjmtEntryStTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransactionSignatureTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransactionSignature', TransactionSignatureTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(TransSalesTaxEntryTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('TransSalesTaxEntry', TransSalesTaxEntryTemp, ReqNodeBuffer, ReqRecRefArray);
        OnAfterAddReqTableNodeToBuffer(BufferUtility, ReqNodeBuffer, ReqRecRefArray);
        //Process
        if not WebRequestHandler.SendWebRequest(Format(Enum::"LSC Web Services"::SendTransactionIT4G), WSServerBuffer, ReqNodeBuffer, ReqRecRefArray, ResNodeBuffer, ResRecRefArray, ProcessErrorText) then begin
            ResponseCode := '0098'; //Unidentified Client Error or Connection Error
            ErrorText := ProcessErrorText;
            exit;
        end;
        //Response
        ResponseCode := WebRequestHandler.GetNodeValueFromBuffer('responseCode', ResNodeBuffer);
        ErrorText := WebRequestHandler.GetNodeValueFromBuffer('errorText', ResNodeBuffer);
    end;

#if __IS_SAAS__
    internal
#endif
    procedure SetPosFunctionalityProfile(POSFunctionalityProfileCode: Code[10])
    begin
        POSFunctionalityProfileCode_g := POSFunctionalityProfileCode;
    end;

#if __IS_SAAS__
    internal
#endif
    procedure SetCommunicationError(ResponseCode: Code[30]; ErrorText: Text)
    var
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
    begin
        WebRequestFunctions.SetCommunicationError(ResponseCode, ErrorText);
    end;

    procedure LoadTransactionTablesFromXML(var SendTransactionXML: XmlPort SendTransactionIT4GXML; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        ClientSessionUtility: Codeunit "LSC Client Session Utility";
    begin
        IF NOT ClientSessionUtility.IsLocalRequest THEN
            SendTransactionXML.IMPORT;
        SendTransactionXML.GetTransactionTables(BufferUtility_p);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSendLocalRequest(var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; var BufferUtility: Codeunit "LSC Buffer Utility"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAddReqTableNodeToBuffer(var BufferUtility: Codeunit "LSC Buffer Utility"; var ReqNodeBuffer: Record "LSC WS Node Buffer" temporary; var ReqRecRefArray: ARRAY[32] OF RecordRef)
    begin
    end;
}

