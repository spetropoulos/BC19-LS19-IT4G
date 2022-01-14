codeunit 50021 SendIT4GDoc
{
    trigger OnRun()
    begin
    end;

    procedure SendIT4GDoc(var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; SendIT4GDocXML: XmlPort SendIT4GDocXML)
    var
        SendIT4GUtils: Codeunit "IT4G-WS-IT4GUtils";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        BufferUtility: Codeunit "LSC Buffer Utility";
        RequestID: Text;
        StartDateTime: DateTime;
    begin
        RequestID := 'SendIT4GDoc';
        StartDateTime := CurrentDateTime;
        ResponseCode := '0000';
        ErrorText := '';
        ClearLastError;
        SendIT4GUtils.LoadIT4GDocTablesFromXML(SendIT4GDocXML, BufferUtility);
        SendIT4GUtils.SetSendIT4GDocRequest(RequestID, AddOnly, UpdateReplicationCounter, 50000, BufferUtility);
        if not SendIT4GUtils.Run then begin
            ResponseCode := '0099'; //Unidentified Server Error (check Event Viewer on Server)
            ErrorText := GetLastErrorText;
        end else begin
            SendIT4GUtils.GetResponse_SendIT4GDoc(ErrorText);
            if ErrorText <> '' then
                ResponseCode := '1000'; //Data Error
        end;
        WebRequestFunctions.WriteRequestLog(RequestID, StartDateTime, false, ErrorText);
    end;
}

