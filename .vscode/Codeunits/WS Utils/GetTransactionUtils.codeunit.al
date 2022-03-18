codeunit 50051 LSCGetTransactionIT4GUtils
{

    trigger OnRun()
    begin
        RunRequest;
    end;

    var
        POSFunctionalityProfileCode_g: Code[10];
        ErrorText_g: Text;
        ReceiptNo_g: Code[20];
        StoreNo_g: Code[10];
        PosTerminalNo_g: Code[10];
        TransactionNo_g: Integer;
        TransactionHeaderTemp_g: Record "LSC Transaction Header" temporary;
        BufferUtility: Codeunit "LSC Buffer Utility";

    local procedure RunRequest()
    var
        NotFound: Label '%1 not found.';
        TransactionHeader: Record "LSC Transaction Header";
    begin
        //Transaction Header
        if ReceiptNo_g <> '' then begin
            TransactionHeader.SetCurrentKey("Receipt No.");
            TransactionHeader.SetRange("Receipt No.", ReceiptNo_g);
        end else begin
            TransactionHeader.SetRange("Store No.", StoreNo_g);
            TransactionHeader.SetRange("POS Terminal No.", PosTerminalNo_g);
            TransactionHeader.SetRange("Transaction No.", TransactionNo_g);
        end;
        if TransactionHeader.FindFirst then begin
            TransactionHeaderTemp_g.Init;
            TransactionHeaderTemp_g := TransactionHeader;
            TransactionHeaderTemp_g.Insert;
        end else begin
            ErrorText_g := StrSubstNo(NotFound, TransactionHeader.TableCaption);
            exit;
        end;

        LoadTransactionTables(TransactionHeaderTemp_g, BufferUtility);
    end;

    procedure SetRequest(ReceiptNo: Code[20]; StoreNo: Code[10]; PosTerminalNo: Code[10]; TransactionNo: Integer)
    begin
        ReceiptNo_g := ReceiptNo;
        StoreNo_g := StoreNo;
        PosTerminalNo_g := PosTerminalNo;
        TransactionNo_g := TransactionNo;
    end;

    procedure SendRequest(ReceiptNo: Code[20]; StoreNo: Code[10]; PosTerminalNo: Code[10]; TransactionNo: Integer; var ResponseCode: Code[30]; var ErrorText: Text; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        WebServiceSetup: Record "LSC Web Service Setup";
        WSServerBuffer: Record "LSC WS Server Buffer" temporary;
        GetTransaction: Codeunit LSCGetTransactionIT4G;
        RequestHandler: Codeunit "LSC Request Handler";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        GetTransactionXML: XmlPort GetTransactionIT4GXML;
        RequestOk: Boolean;
        ReqDateTime: DateTime;
        LogFileID: Text;
        Handled: Boolean;
        URIMissingTxt: Label 'Web Server URI is Missing for Request %1';
    begin
        RequestOk := false;
        ReqDateTime := CurrentDateTime;
        LogFileID := WebRequestFunctions.CreateLogFileID(ReqDateTime);
        RequestHandler.GetWebServerList(Format(Enum::"LSC Web Services"::GetTransactionIT4G), POSFunctionalityProfileCode_g, WSServerBuffer);
        WSServerBuffer.Reset;
        if WSServerBuffer.FindSet then
            repeat
                if WSServerBuffer."Local Request" then begin
                    OnBeforeSendLocalRequest(ResponseCode, ErrorText, ReceiptNo, StoreNo, PosTerminalNo, TransactionNo, BufferUtility_p, Handled);
                    IF not Handled then begin
                        Clear(GetTransactionXML);
                        GetTransaction.GetTransaction(ResponseCode, ErrorText, ReceiptNo, StoreNo, PosTerminalNo, TransactionNo, GetTransactionXML);
                        GetTransactionXML.GetTransactionTables(BufferUtility_p);
                    end;
                    RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", 'Local', 'Local', '');
                    //Transaction not saved - local request
                end else begin
                    RequestHandler.FindDestURI(Format(Enum::"LSC Web Services"::GetTransactionIT4G), WSServerBuffer);
                    WSServerBuffer."Web Service URI" := WebRequestFunctions.ConvertToNewUrl(WSServerBuffer."Web Service URI");
                    WSServerBuffer."Log File ID" := LogFileID;
                    PostGetTransaction(WSServerBuffer, ReceiptNo, StoreNo, PosTerminalNo, TransactionNo, ResponseCode, ErrorText, BufferUtility_p);
                    if ResponseCode <> '0098' then
                        RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", WSServerBuffer."Dist. Location", WSServerBuffer."Web Service URI", ErrorText);
                end;
            until (WSServerBuffer.Next = 0) or RequestOk
        else begin
            ErrorText := StrSubstNo(URIMissingTxt, Format(Enum::"LSC Web Services"::GetTransactionIT4G));
            RequestHandler.AddToConnLog('', '', '', ErrorText);
        end;
        WebServiceSetup.Get;
        if WebServiceSetup."Client Log On" and GuiAllowed then
            RequestHandler.LogConnURI(Format(Enum::"LSC Web Services"::GetTransactionIT4G), LogFileID);
    end;

    procedure GetResponse(var ErrorText: Text; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    begin
        ErrorText := ErrorText_g;
        BufferUtility_p := BufferUtility;
    end;

    local procedure PostGetTransaction(var WSServerBuffer: Record "LSC WS Server Buffer"; ReceiptNo: Code[20]; StoreNo: Code[10]; PosTerminalNo: Code[10]; TransactionNo: Integer; var ResponseCode: Code[30]; var ErrorText: Text; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        WebRequestFieldMappingTemp: Record "LSC Web Request Field Mapping" temporary;
        ReqNodeBuffer: Record "LSC WS Node Buffer" temporary;
        ReqRecRefArray: array[32] of RecordRef;
        ResNodeBuffer: Record "LSC WS Node Buffer" temporary;
        ResRecRefArray: array[32] of RecordRef;
        WebRequestHandler: Codeunit "LSC Web Request Handler";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        ProcessErrorText: Text;
        XmlPortNo: Integer;
        TransactionHeaderTemp: Record "LSC Transaction Header" temporary;
        TransSalesEntryTemp: Record "LSC Trans. Sales Entry" temporary;
        TransPaymentEntryTemp: Record "LSC Trans. Payment Entry" temporary;
        TransIncomeExpenseEntryTemp: Record "LSC Trans. Inc./Exp. Entry" temporary;
        TransInfocodeEntryTemp: Record "LSC Trans. Infocode Entry" temporary;
        TransTenderDeclarEntryTemp: Record "LSC Trans. Tender Declar. Entr" temporary;
        TransInventoryEntryTemp: Record "LSC Trans. Inventory Entry" temporary;
        POSCardEntryTemp: Record "LSC POS Card Entry" temporary;
        TransDiscountEntryTemp: Record "LSC Trans. Discount Entry" temporary;
        TransDealEntryTemp: Record "LSC Trans. Deal Entry" temporary;
        TransPointEntryTemp: Record "LSC Trans. Point Entry" temporary;
        TransHospitalityEntryTemp: Record "LSC Trans. Hospitality Entry" temporary;
        TransSalesTaxEntryTemp: Record "LSC Trans. SalesTax Entry" temporary;
    begin
        //Request
        WebRequestHandler.AddNodeToBuffer('responseCode', '', ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('errorText', '', ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('receiptNo', ReceiptNo, ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('storeNo', StoreNo, ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('posTerminalNo', PosTerminalNo, ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('transactionNo', Format(TransactionNo, 0, 9), ReqNodeBuffer);
        //Process
        if not WebRequestHandler.SendWebRequest(Format(Enum::"LSC Web Services"::GetTransactionIT4G), WSServerBuffer, ReqNodeBuffer, ReqRecRefArray, ResNodeBuffer, ResRecRefArray, ProcessErrorText) then begin
            ResponseCode := '0098'; //Unidentified Client Error or Connection Error
            ErrorText := ProcessErrorText;
            exit;
        end;
        //Response
        ResponseCode := WebRequestHandler.GetNodeValueFromBuffer('responseCode', ResNodeBuffer);
        ErrorText := WebRequestHandler.GetNodeValueFromBuffer('errorText', ResNodeBuffer);
        //Retrieve Transaction and save to local (POS) database
        GetXmlPortNo(XmlPortNo);
        WebRequestFunctions.GetXmlPortFields(Format(Enum::"LSC Web Services"::GetTransactionIT4G), XmlPortNo, WebRequestFieldMappingTemp);
        WebRequestFunctions.ClearTable(TransactionHeaderTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransactionHeader', ResNodeBuffer, ResRecRefArray, TransactionHeaderTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransactionHeaderTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransactionHeaderTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransSalesEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransSalesEntry', ResNodeBuffer, ResRecRefArray, TransSalesEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransSalesEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransSalesEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransPaymentEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransPaymentEntry', ResNodeBuffer, ResRecRefArray, TransPaymentEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransPaymentEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransPaymentEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransIncomeExpenseEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransIncomeExpenseEntry', ResNodeBuffer, ResRecRefArray, TransIncomeExpenseEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransIncomeExpenseEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransIncomeExpenseEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransInfocodeEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransInfocodeEntry', ResNodeBuffer, ResRecRefArray, TransInfocodeEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransInfocodeEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransInfocodeEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransTenderDeclarEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransTenderDeclarEntry', ResNodeBuffer, ResRecRefArray, TransTenderDeclarEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransTenderDeclarEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransTenderDeclarEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransInventoryEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransInventoryEntry', ResNodeBuffer, ResRecRefArray, TransInventoryEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransInventoryEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransInventoryEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(POSCardEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('POSCardEntry', ResNodeBuffer, ResRecRefArray, POSCardEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, POSCardEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(POSCardEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransDiscountEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransDiscountEntry', ResNodeBuffer, ResRecRefArray, TransDiscountEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransDiscountEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransDiscountEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransDealEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransDealEntry', ResNodeBuffer, ResRecRefArray, TransDealEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransDealEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransDealEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransPointEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransPointEntry', ResNodeBuffer, ResRecRefArray, TransPointEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransPointEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransPointEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransHospitalityEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransHospitalityEntry', ResNodeBuffer, ResRecRefArray, TransHospitalityEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransHospitalityEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransHospitalityEntryTemp, BufferUtility_p);

        WebRequestFunctions.ClearTable(TransSalesTaxEntryTemp);
        WebRequestHandler.GetTableNodeFromBuffer('TransSalesTaxEntry', ResNodeBuffer, ResRecRefArray, TransSalesTaxEntryTemp);
        WebRequestFunctions.UpdateTableByTempTable(Format(Enum::"LSC Web Services"::GetTransactionIT4G), false, TransSalesTaxEntryTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(TransSalesTaxEntryTemp, BufferUtility_p);

        OnAfterGetTableNodeFromBuffer(ResNodeBuffer, ResRecRefArray, WebRequestFieldMappingTemp, BufferUtility_p);
    end;

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

    local procedure LoadTransactionTables(var TransactionHeaderTemp: Record "LSC Transaction Header" temporary; var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
        TransSalesEntry: Record "LSC Trans. Sales Entry";
        TransPaymentEntry: Record "LSC Trans. Payment Entry";
        TransIncomeExpenseEntry: Record "LSC Trans. Inc./Exp. Entry";
        TransInfocodeEntry: Record "LSC Trans. Infocode Entry";
        TransTenderDeclarEntry: Record "LSC Trans. Tender Declar. Entr";
        TransInventoryEntry: Record "LSC Trans. Inventory Entry";
        POSCardEntry: Record "LSC POS Card Entry";
        TransDiscountEntry: Record "LSC Trans. Discount Entry";
        TransDealEntry: Record "LSC Trans. Deal Entry";
        TransPointEntry: Record "LSC Trans. Point Entry";
        TransHospitalityEntry: Record "LSC Trans. Hospitality Entry";
        TransSalesTaxEntry: Record "LSC Trans. SalesTax Entry";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        TransSalesTaxEntryTemp: Record "LSC Trans. SalesTax Entry";
    Begin
        CLEAR(BufferUtility);

        TransactionHeaderTemp.SETRECFILTER;
        RecRef.GETTABLE(TransactionHeaderTemp);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Sales Entry
        TransSalesEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransSalesEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransSalesEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransSalesEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Payment Entry
        TransPaymentEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransPaymentEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransPaymentEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransPaymentEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Income/Expense Entry
        TransIncomeExpenseEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransIncomeExpenseEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransIncomeExpenseEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransIncomeExpenseEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Infocode Entry
        TransInfocodeEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransInfocodeEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransInfocodeEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransInfocodeEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Tender Declar. Entry
        TransTenderDeclarEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransTenderDeclarEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransTenderDeclarEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransTenderDeclarEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Inventory Entry
        TransInventoryEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransInventoryEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransInventoryEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransInventoryEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //POS Card Entry
        POSCardEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        POSCardEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        POSCardEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(POSCardEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Discount Entry
        TransDiscountEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransDiscountEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransDiscountEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransDiscountEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Point Entry
        TransPointEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransPointEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransPointEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransPointEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Deal Entry
        TransDealEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransDealEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransDealEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransDealEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. Hospitality Entry
        TransHospitalityEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransHospitalityEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransHospitalityEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransHospitalityEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        //Trans. SalesTax Entry
        TransSalesTaxEntry.SETRANGE("Store No.", TransactionHeaderTemp."Store No.");
        TransSalesTaxEntry.SETRANGE("POS Terminal No.", TransactionHeaderTemp."POS Terminal No.");
        TransSalesTaxEntry.SETRANGE("Transaction No.", TransactionHeaderTemp."Transaction No.");
        RecRef.GETTABLE(TransSalesTaxEntry);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        OnAfterLoadTransactionTables(TransactionHeaderTemp, BufferUtility);
    End;

    procedure LoadTransactionTablesToXML(var BufferUtility_p: Codeunit "LSC Buffer Utility"; var GetTransactionXML: XmlPort GetTransactionIT4GXML)
    begin
        CLEAR(GetTransactionXML);
        GetTransactionXML.SetTransactionTables(BufferUtility_p);
        GetTransactionXML.EXPORT;
    end;

    local procedure GetXmlPortNo(var XmlPortNo: Integer)
    begin
        XmlPortNo := 10032999;
        OnAfterGetXmlPortNo(XmlPortNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetXmlPortNo(var XmlPortNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetTableNodeFromBuffer(var ReqNodeBuffer: Record "LSC WS Node Buffer" temporary; var ReqRecRefArray: ARRAY[32] OF RecordRef; var WebRequestFieldMapping: Record "LSC Web Request Field Mapping" temporary; var BufferUtility: Codeunit "LSC Buffer Utility")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSendLocalRequest(var ResponseCode: Code[30]; var ErrorText: Text; ReceiptNo: Code[20]; StoreNo: Code[10]; PosTerminalNo: Code[10]; TransactionNo: Integer; var BufferUtility: Codeunit "LSC Buffer Utility"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLoadTransactionTables(var TransactionHeaderTemp: Record "LSC Transaction Header" temporary; var BufferUtility: Codeunit "LSC Buffer Utility")
    begin
    end;
}

