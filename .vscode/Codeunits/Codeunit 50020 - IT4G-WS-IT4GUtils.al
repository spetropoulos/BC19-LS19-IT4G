codeunit 50020 "IT4G-WS-IT4GUtils"
{
    trigger OnRun()
    var
        pWSRequest: Record "LSC POS Func. Profile Web Req.";
    begin

        case RequestID_txt of
            'SendIT4GDoc':
                RunSendIT4GDocRequest;
            'GetIT4GDoc':
                RunGetIT4GDocRequest;
            '':
                begin
                    //InsertWebRequest
                    pWSRequest.Init;
                    pWSRequest."Profile ID" := '##DEFAULT';
                    pWSRequest."Request ID" := 'SendIT4GDoc';
                    pWSRequest."Request is Active" := true;
                    if pWSRequest.Insert then;
                    pWSRequest."Request ID" := 'GetIT4GDoc';
                    if pWSRequest.Insert then;
                end;
        end;
    end;

    var
        cHO: Codeunit "LSC HO Store Autom. WS Setup";
        SessionKeyValues_g: Codeunit "LSC Session Key Values";
        BufferUtility: Codeunit "LSC Buffer Utility";
        POSFunctionalityProfileCode_g: Code[10];
        ErrorText_g: Text;
        XmlPortNo_g: Integer;
        AddOnly_g: Boolean;
        UpdateReplicationCounter_g: Boolean;
        //RequestID_txt: Label 'SendIT4GDoc', Locked = true;
        RequestID_txt: Text;
        NotFound: Label '%1 %2 not found.';
        gIT4GDocNo: Code[20];
        rIT4GDocTmp_g: Record "IT4G-Doc. Header" temporary;


    [Scope('OnPrem')]
    procedure SetPosFunctionalityProfile(POSFunctionalityProfileCode: Code[10])
    begin
        POSFunctionalityProfileCode_g := POSFunctionalityProfileCode;
    end;

    procedure LoadIT4GDocTablesFromXML(var SendIT4GDocXML: XmlPort SendIT4GDocXML; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        ClientSessionUtility: Codeunit "LSC Client Session Utility";
    begin
        IF NOT ClientSessionUtility.IsLocalRequest THEN
            SendIT4GDocXML.IMPORT;
        SendIT4GDocXML.GetIT4GDocTables(BufferUtility_p);
    end;

    procedure LoadIT4GDocTablesToXML(var BufferUtility_p: Codeunit "LSC Buffer Utility"; var GetIT4GDocXML: XmlPort GetIT4GDocXML)
    begin
        CLEAR(GetIT4GDocXML);
        GetIT4GDocXML.SetIT4GDocTables(BufferUtility_p);
        GetIT4GDocXML.EXPORT;
    end;


    //---------------------------------------------------------------------------------------------------------------------------------------------------------
    //------- Send IT4G-Doc------------------------------------------------------------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------------------------------------------------------------------------------
    [Scope('OnPrem')]
    procedure SetSendIT4GDocRequest(xRequestID: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; XmlPortNo: Integer; VAR BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        ClientSessionUtility: Codeunit "LSC Client Session Utility";
    begin
        AddOnly_g := AddOnly;
        UpdateReplicationCounter_g := UpdateReplicationCounter;
        XmlPortNo_g := XmlPortNo;
        BufferUtility := BufferUtility_p;
        RequestID_txt := xRequestID;
    end;

    [Scope('OnPrem')]
    procedure GetResponse_SendIT4GDoc(var ErrorText: Text)
    begin
        ErrorText := ErrorText_g;
    end;

    local procedure RunSendIT4GDocRequest()
    var
        WebRequestFieldMappingTemp: Record "LSC Web Request Field Mapping" temporary;
        TableBufferTemp: Record "LSC Web Table Buffer" temporary;
        IT4GDocTemp: Record "IT4G-Doc. Header" temporary;
        RecRef: RecordRef;
        RecRefTemp: RecordRef;
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        SomethingMissingTxt: Label '%1 missing.';
    begin
        RecRef.GETTABLE(IT4GDocTemp);
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        if IT4GDocTemp.IsEmpty then begin
            ErrorText_g := StrSubstNo(SomethingMissingTxt, IT4GDocTemp.TableCaption);
            exit;
        end;
        if not AddOnly_g then //Buffer is only used when add only is false (= update if exist)
            WebRequestFunctions.GetXmlPortFields(RequestID_txt, XmlPortNo_g, WebRequestFieldMappingTemp);

        BufferUtility.GetTableList(TableBufferTemp);
        TableBufferTemp.RESET;
        TableBufferTemp.SETRANGE("Record Index", 2);
        IF TableBufferTemp.FINDSET THEN
            REPEAT
                RecRefTemp.OPEN(TableBufferTemp."Table No.", TRUE);
                WebRequestFunctions.GetTableDataXML(BufferUtility, RecRefTemp);
                WebRequestFunctions.UpdateTableByTempTable(RequestID_txt, AddOnly_g, RecRefTemp, UpdateReplicationCounter_g, WebRequestFieldMappingTemp);
                RecRefTemp.CLOSE;
            UNTIL TableBufferTemp.NEXT = 0;
    end;

    [Scope('OnPrem')]
    procedure SendRequestSendIT4GDoc(var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; var IT4GDocTemp: Record "IT4G-Doc. Header" temporary)
    var
        WebServiceSetup: Record "LSC Web Service Setup";
        WSServerBuffer: Record "LSC WS Server Buffer" temporary;
        SendIT4G: Codeunit SendIT4GDoc;
        RequestHandler: Codeunit "LSC Request Handler";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        WebRequestDataMgt: Codeunit "LSC Web Request Data Mgt";
        SendIT4GDocXML: XmlPort SendIT4GDocXML;
        LogFileID: Text;
        ReqDateTime: DateTime;
        RequestOk: Boolean;
        Handled: Boolean;
        URIMissingTxt: Label 'Web Server URI is Missing for Request %1';
    begin
        RequestID_txt := 'SendIT4GDoc';
        RequestOk := false;
        ReqDateTime := CurrentDateTime;
        LogFileID := WebRequestFunctions.CreateLogFileID(ReqDateTime);
        RequestHandler.GetWebServerList(RequestID_txt, POSFunctionalityProfileCode_g, WSServerBuffer);
        WSServerBuffer.Reset;
        if WSServerBuffer.FindSet then begin
            CLEAR(BufferUtility);
            LoadSendIT4GDocTables(IT4GDocTemp, BufferUtility);
            repeat
                if WSServerBuffer."Local Request" then begin
                    SessionKeyValues_g.SetValue('#LOCALREQUEST', 'TRUE');
                    IF not Handled then begin
                        Clear(SendIT4GDocXML);
                        SendIT4GDocXML.SetIT4GDocTables(BufferUtility);
                        SendIT4GDocXML.Export;
                        Commit;
                        SendIT4G.SendIT4GDoc(ResponseCode, ErrorText, AddOnly, UpdateReplicationCounter, SendIT4GDocXML);
                    end;
                    SessionKeyValues_g.SetValue('#LOCALREQUEST', 'FALSE');
                    RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", 'Local', 'Local', '');
                    //Transaction not saved - local request
                end else begin
                    RequestHandler.FindDestURI(RequestID_txt, WSServerBuffer);
                    WSServerBuffer."Web Service URI" := WebRequestFunctions.ConvertToNewUrl(WSServerBuffer."Web Service URI");
                    WSServerBuffer."Log File ID" := LogFileID;
                    PostSendIT4GDoc(WSServerBuffer, ResponseCode, ErrorText, AddOnly, UpdateReplicationCounter, BufferUtility);
                    if ResponseCode <> '0098' then
                        RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", WSServerBuffer."Dist. Location", WSServerBuffer."Web Service URI", ErrorText);
                end;
            until (WSServerBuffer.Next = 0) or RequestOk
        end else begin
            ErrorText := StrSubstNo(URIMissingTxt, RequestID_txt);
            RequestHandler.AddToConnLog('', '', '', ErrorText);
        end;
        WebServiceSetup.Get;
        if WebServiceSetup."Client Log On" and GuiAllowed then
            RequestHandler.LogConnURI(RequestID_txt, LogFileID);
    end;

    local procedure PostSendIT4GDoc(var WSServerBuffer: Record "LSC WS Server Buffer"; var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        ReqNodeBuffer: Record "LSC WS Node Buffer" temporary;
        ResNodeBuffer: Record "LSC WS Node Buffer" temporary;
        IT4GDocHeaderTemp: Record "IT4G-Doc. Header" temporary;
        IT4GDocLineTemp: Record "IT4G-Doc. Line" temporary;
        IT4GDocLineBoxTemp: Record "IT4G-Doc. Line Box" temporary;
        IT4GDocScanTemp: Record "IT4G-Doc. Scan" temporary;
        IT4GDocSourceTemp: Record "IT4G-Doc. Source" temporary;

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
        RecRef.GETTABLE(IT4GDocHeaderTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('IT4GDocHeader', IT4GDocHeaderTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(IT4GDocLineTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('IT4GDocLine', IT4GDocLineTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(IT4GDocLineBoxTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('IT4GDocLineBox', IT4GDocLineBoxTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(IT4GDocScanTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('IT4GDocScan', IT4GDocScanTemp, ReqNodeBuffer, ReqRecRefArray);
        RecRef.GETTABLE(IT4GDocSourceTemp);
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
        WebRequestHandler.AddReqTableNodeToBuffer('IT4GDocSource', IT4GDocSourceTemp, ReqNodeBuffer, ReqRecRefArray);
        //Process
        if not WebRequestHandler.SendWebRequest(RequestID_txt, WSServerBuffer, ReqNodeBuffer, ReqRecRefArray, ResNodeBuffer, ResRecRefArray, ProcessErrorText) then begin
            ResponseCode := '0098'; //Unidentified Client Error or Connection Error
            ErrorText := ProcessErrorText;
            exit;
        end;
        //Response
        ResponseCode := WebRequestHandler.GetNodeValueFromBuffer('responseCode', ResNodeBuffer);
        ErrorText := WebRequestHandler.GetNodeValueFromBuffer('errorText', ResNodeBuffer);
    end;

    procedure LoadSendIT4GDocTables(var IT4GDocHeaderTemp: Record "IT4G-Doc. Header" temporary; var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
        IT4GDocLine: Record "IT4G-Doc. Line";
        IT4GDocLineBox: Record "IT4G-Doc. Line Box";
        IT4GDocScan: Record "IT4G-Doc. Scan";
        IT4GDocSource: Record "IT4G-Doc. Source";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
    begin
        //IT4G-Doc. Header 
        IT4GDocHeaderTemp.SETRECFILTER;
        RecRef.GETTABLE(IT4GDocHeaderTemp);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
        //IT4G-Doc. Line
        IT4GDocLine.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocLine);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
        //IT4G-Doc. Line Box
        IT4GDocLineBox.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocLineBox);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
        //IT4G-Doc. Scan
        IT4GDocScan.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocScan);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
        //IT4G-Doc. Source
        IT4GDocSource.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocSource);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
    end;

    //---------------------------------------------------------------------------------------------------------------------------------------------------------
    //------- Get IT4G-Doc ------------------------------------------------------------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------------------------------------------------------------------------------
    [Scope('OnPrem')]
    procedure SetGetIT4GDocRequest(xRequestID: Text; xIT4GDocNo: code[20]; XmlPortNo: Integer)
    begin
        gIT4GDocNo := xIT4GDocNo;
        RequestID_txt := xRequestID;
        XmlPortNo_g := XmlPortNo;

    end;

    [Scope('OnPrem')]
    procedure GetResponse_GetIT4GDoc(var ErrorText: Text; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    begin
        ErrorText := ErrorText_g;
        BufferUtility_p := BufferUtility;
    end;

    local procedure RunGetIT4GDocRequest()
    var
        NotFound: Label '%1 not found.';
        rIT4GDoc: Record "IT4G-Doc. Header";
    begin
        rIT4GDoc.SetRange("Document No.", gIT4GDocNo);
        if rIT4GDoc.FindFirst then begin
            rIT4GDocTmp_g.Init;
            rIT4GDocTmp_g := rIT4GDoc;
            rIT4GDocTmp_g.Insert;
        end else begin
            ErrorText_g := StrSubstNo(NotFound, rIT4GDoc.TableCaption, gIT4GDocNo);
            exit;
        end;

        LoadGetIT4GDocTables(rIT4GDocTmp_g, BufferUtility);
    end;

    procedure SendRequestGetIT4GDoc(xIT4GDocNo: Code[20]; var ResponseCode: Code[30]; var ErrorText: Text; var BufferUtility_p: Codeunit "LSC Buffer Utility")
    var
        WebServiceSetup: Record "LSC Web Service Setup";
        WSServerBuffer: Record "LSC WS Server Buffer" temporary;
        GetIT4GDoc: Codeunit GetIT4GDoc;
        RequestHandler: Codeunit "LSC Request Handler";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        GetIT4GDocXML: XmlPort GetIT4GDocXML;
        RequestOk: Boolean;
        ReqDateTime: DateTime;
        LogFileID: Text;
        Handled: Boolean;
        URIMissingTxt: Label 'Web Server URI is Missing for Request %1';
    begin
        RequestID_txt := 'GetIT4GDoc';
        RequestOk := false;
        ReqDateTime := CurrentDateTime;
        LogFileID := WebRequestFunctions.CreateLogFileID(ReqDateTime);
        RequestHandler.GetWebServerList(RequestID_txt, POSFunctionalityProfileCode_g, WSServerBuffer);
        WSServerBuffer.Reset;
        if WSServerBuffer.FindSet then
            repeat
                if WSServerBuffer."Local Request" then begin
                    //CEN-2186 -
                    IF not Handled then begin
                        Clear(GetIT4GDocXML);
                        GetIT4GDoc.GetIT4GDoc(ResponseCode, ErrorText, xIT4GDocNo, GetIT4GDocXML);
                        GetIT4GDocXML.GetIT4GDocTables(BufferUtility_p);
                    end;
                    //CEN-2186 +
                    RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", 'Local', 'Local', '');
                    //Transaction not saved - local request
                end else begin
                    RequestHandler.FindDestURI(RequestID_txt, WSServerBuffer);
                    WSServerBuffer."Web Service URI" := WebRequestFunctions.ConvertToNewUrl(WSServerBuffer."Web Service URI");
                    WSServerBuffer."Log File ID" := LogFileID;
                    PostGetIT4GDoc(WSServerBuffer, xIT4GDocNo, ResponseCode, ErrorText, BufferUtility_p); //CEN-2186
                    if ResponseCode <> '0098' then
                        RequestOk := true;
                    RequestHandler.AddToConnLog(WSServerBuffer."Profile ID", WSServerBuffer."Dist. Location", WSServerBuffer."Web Service URI", ErrorText);
                end;
            until (WSServerBuffer.Next = 0) or RequestOk
        else begin
            ErrorText := StrSubstNo(URIMissingTxt, RequestID_txt);
            RequestHandler.AddToConnLog('', '', '', ErrorText);
        end;
        WebServiceSetup.Get;
        if WebServiceSetup."Client Log On" and GuiAllowed then
            RequestHandler.LogConnURI(RequestID_txt, LogFileID);
    end;

    local procedure PostGetIT4GDoc(var WSServerBuffer: Record "LSC WS Server Buffer"; xIT4GDocNo: code[20]; var ResponseCode: Code[30]; var ErrorText: Text; var BufferUtility_p: Codeunit "LSC Buffer Utility")
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
        IT4GDocHeaderTemp: Record "IT4G-Doc. Header" temporary;
        IT4GDocLineTemp: Record "IT4G-Doc. Line" temporary;
        IT4GDocLineBoxTemp: Record "IT4G-Doc. Line Box" temporary;
        IT4GDocScanTemp: Record "IT4G-Doc. Scan" temporary;
        IT4GDocSourceTemp: Record "IT4G-Doc. Source" temporary;
    begin
        RequestID_txt := 'GetIT4GDoc';
        //Request
        WebRequestHandler.AddNodeToBuffer('responseCode', '', ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('errorText', '', ReqNodeBuffer);
        WebRequestHandler.AddNodeToBuffer('iT4GDocNo', xIT4GDocNo, ReqNodeBuffer);
        //Process
        if not WebRequestHandler.SendWebRequest(RequestID_txt, WSServerBuffer, ReqNodeBuffer, ReqRecRefArray, ResNodeBuffer, ResRecRefArray, ProcessErrorText) then begin
            ResponseCode := '0098'; //Unidentified Client Error or Connection Error
            ErrorText := ProcessErrorText;
            exit;
        end;
        //Response
        ResponseCode := WebRequestHandler.GetNodeValueFromBuffer('responseCode', ResNodeBuffer);
        ErrorText := WebRequestHandler.GetNodeValueFromBuffer('errorText', ResNodeBuffer);
        //Retrieve IT4GDoc and save to local (POS) database
        //CEN-2186 WebRequestFunctions.GetXmlPortFields(RequestID, 10032999, WebRequestFieldMappingTemp);
        //Cen-2186 -

        WebRequestFunctions.GetXmlPortFields(RequestID_txt, 50001, WebRequestFieldMappingTemp);
        //Cen-2186 +
        WebRequestFunctions.ClearTable(IT4GDocHeaderTemp);
        WebRequestHandler.GetTableNodeFromBuffer('IT4GDocHeader', ResNodeBuffer, ResRecRefArray, IT4GDocHeaderTemp);
        WebRequestFunctions.UpdateTableByTempTable(RequestID_txt, false, IT4GDocHeaderTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(IT4GDocHeaderTemp, BufferUtility_p); //CEN-2186

        WebRequestFunctions.ClearTable(IT4GDocLineTemp);
        WebRequestHandler.GetTableNodeFromBuffer('IT4GDocLine', ResNodeBuffer, ResRecRefArray, IT4GDocLineTemp);
        WebRequestFunctions.UpdateTableByTempTable(RequestID_txt, false, IT4GDocLineTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(IT4GDocLineTemp, BufferUtility_p); //CEN-2186

        WebRequestFunctions.ClearTable(IT4GDocLineBoxTemp);
        WebRequestHandler.GetTableNodeFromBuffer('IT4GDocLineBox', ResNodeBuffer, ResRecRefArray, IT4GDocLineBoxTemp);
        WebRequestFunctions.UpdateTableByTempTable(RequestID_txt, false, IT4GDocLineBoxTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(IT4GDocLineBoxTemp, BufferUtility_p); //CEN-2186

        WebRequestFunctions.ClearTable(IT4GDocScanTemp);
        WebRequestHandler.GetTableNodeFromBuffer('IT4GDocScan', ResNodeBuffer, ResRecRefArray, IT4GDocScanTemp);
        WebRequestFunctions.UpdateTableByTempTable(RequestID_txt, false, IT4GDocScanTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(IT4GDocScanTemp, BufferUtility_p); //CEN-2186

        WebRequestFunctions.ClearTable(IT4GDocSourceTemp);
        WebRequestHandler.GetTableNodeFromBuffer('IT4GDocSource', ResNodeBuffer, ResRecRefArray, IT4GDocSourceTemp);
        WebRequestFunctions.UpdateTableByTempTable(RequestID_txt, false, IT4GDocSourceTemp, true, WebRequestFieldMappingTemp);
        WebRequestFunctions.LoadTableData(IT4GDocSourceTemp, BufferUtility_p); //CEN-2186

    end;

    local procedure LoadGetIT4GDocTables(var IT4GDocHeaderTemp: Record "IT4G-Doc. Header" temporary; var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
        IT4GDocLine: Record "IT4G-Doc. Line";
        IT4GDocLineBox: Record "IT4G-Doc. Line Box";
        IT4GDocScan: Record "IT4G-Doc. Scan";
        IT4GDocSource: Record "IT4G-Doc. Source";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
    Begin
        CLEAR(BufferUtility);

        IT4GDocHeaderTemp.SETRECFILTER;
        RecRef.GETTABLE(IT4GDocHeaderTemp);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);
        //IT4G-Doc. Line
        IT4GDocLine.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocLine);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);
        //IT4G-Doc. Line Box
        IT4GDocLineBox.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocLineBox);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);
        //IT4G-Doc. Scan
        IT4GDocScan.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocScan);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);
        //IT4G-Doc. Source
        IT4GDocSource.SETRANGE("Document No.", IT4GDocHeaderTemp."Document No.");
        RecRef.GETTABLE(IT4GDocSource);
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

    End;

}

