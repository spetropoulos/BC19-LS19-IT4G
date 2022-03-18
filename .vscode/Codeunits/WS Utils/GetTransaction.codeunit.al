codeunit 50050 LSCGetTransactionIT4G
{
    procedure GetTransaction(var ResponseCode: Code[30]; var ErrorText: Text; ReceiptNo: Code[20];
        StoreNo: Code[10]; PosTerminalNo: Code[10]; TransactionNo: Integer; var GetTransactionXML: XmlPort GetTransactionIT4GXML)
    var
        GetTransactionUtils: Codeunit LSCGetTransactionIT4GUtils;
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        StartDateTime: DateTime;
        BufferUtility: Codeunit "LSC Buffer Utility";
    begin
        StartDateTime := CurrentDateTime;
        ResponseCode := '0000';
        ErrorText := '';
        ClearLastError;
        GetTransactionUtils.SetRequest(ReceiptNo, StoreNo, PosTerminalNo, TransactionNo);
        if not GetTransactionUtils.Run then begin
            ResponseCode := '0099'; //Unidentified Server Error (check Event Viewer on Server)
            ErrorText := GetLastErrorText;
        end else begin
            //CEN-2186 -
            GetTransactionUtils.GetResponse(ErrorText, BufferUtility);
            IF ErrorText = '' then
                GetTransactionUtils.LoadTransactionTablesToXML(BufferUtility, GetTransactionXML);
            //CEN-2186 +
            if ErrorText <> '' then
                ResponseCode := '1000'; //Data Error
        end;
        WebRequestFunctions.WriteRequestLog(Format(Enum::"LSC Web Services"::GetTransactionIT4G), StartDateTime, false, ErrorText);
    end;
}

