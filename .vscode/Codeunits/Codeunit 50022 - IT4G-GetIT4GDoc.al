codeunit 50022 GetIT4GDoc
{
    trigger OnRun()
    begin
    end;

    procedure GetIT4GDoc(var ResponseCode: Code[30]; var ErrorText: Text; IT4GDocNo: code[20]; var GetIT4GDocXML: XmlPort GetIT4GDocXML)
    var
        GetIT4GDocUtils: Codeunit "IT4G-WS-IT4GUtils";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
        RequestID: Text;
        StartDateTime: DateTime;
        BufferUtility: Codeunit "LSC Buffer Utility";
    begin
        RequestID := 'GetIT4GDoc';
        StartDateTime := CurrentDateTime;
        ResponseCode := '0000';
        ErrorText := '';
        ClearLastError;
        GetIT4GDocUtils.SetGetIT4gDocRequest(RequestID, IT4GDocNo, 50001);
        if not GetIT4GDocUtils.Run then begin
            ResponseCode := '0099'; //Unidentified Server Error (check Event Viewer on Server)
            ErrorText := GetLastErrorText;
        end else begin
            //CEN-2186 -
            GetIT4GDocUtils.GetResponse_GetIT4GDoc(ErrorText, BufferUtility);
            IF ErrorText = '' then
                GetIT4GDocUtils.LoadIT4GDocTablesToXML(BufferUtility, GetIT4GDocXML);
            //CEN-2186 +
            if ErrorText <> '' then
                ResponseCode := '1000'; //Data Error
        end;
        WebRequestFunctions.WriteRequestLog(RequestID, StartDateTime, false, ErrorText);
    end;
}

