codeunit 50060 LSCSendTransactionIT4G
{
    procedure SendTransaction(var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean;
        SendTransactionXML: XmlPort SendTransactionIT4GXML)
    var
        SendTransactionUtils: Codeunit LSCSendTransactionIT4GUtils;
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        BufferUtility: Codeunit "LSC Buffer Utility";
        StartDateTime: DateTime;
    begin
        StartDateTime := CurrentDateTime;
        ResponseCode := '0000';
        ErrorText := '';
        ClearLastError;
        SendTransactionUtils.LoadTransactionTablesFromXML(SendTransactionXML, BufferUtility);
        SendTransactionUtils.SetRequest(AddOnly, UpdateReplicationCounter, 50003, BufferUtility);
        if not SendTransactionUtils.Run then begin
            ResponseCode := '0099'; //Unidentified Server Error (check Event Viewer on Server)
            ErrorText := GetLastErrorText;
        end else begin
            SendTransactionUtils.GetResponse(ErrorText);
            if ErrorText <> '' then
                ResponseCode := '1000'; //Data Error
        end;
        WebRequestFunctions.WriteRequestLog(Format(Enum::"LSC Web Services"::SendTransactionIT4G), StartDateTime, false, ErrorText);
    end;
}

