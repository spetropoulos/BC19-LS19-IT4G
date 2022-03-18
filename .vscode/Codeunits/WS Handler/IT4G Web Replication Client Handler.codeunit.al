codeunit 50070 "IT4G Web Repl. Client Handler"
{
    trigger OnRun()
    begin

    end;

    var
        PosFuncProfile: Record "LSC POS Func. Profile";

    procedure SetPosFunctionalityProfile(PosFuncProfileCode: Code[10])
    begin
        PosFuncProfile.get(PosFuncProfileCode);
    end;

    procedure SendIT4GDocs(var ResponseCode: Code[30]; var ErrorText: Text; AddOnly: Boolean; UpdateReplicationCounter: Boolean; var It4GDocTemp: Record "IT4G-Doc. Header" temporary)
    var
        TableBufferTemp: Record "LSC Web Table Buffer" temporary;
        PosSession: Codeunit "LSC POS Session";
        WebServicesClient: Codeunit "LSC Web Services Client";
        WSFunc: Codeunit "LSC WS Functions";
        WebRequestFunc: Codeunit "LSC Web Request Functions";
        BufferUtility: Codeunit "LSC Buffer Utility";
        WebRequestDataMgt: Codeunit "LSC Web Request Data Mgt";
        PacketID: Guid;
        ProcessError: Boolean;
        ErrorTextInternal: text;
        ErrorTextInternal2: text;
        RecRefTemp: RecordRef;
        ReplCounterFieldName: text;
        MaxProcessTry: Integer;
        ProcessTry: Integer;
    begin
        MaxProcessTry := 3;

        //Load all Transaction tables
        CLEAR(BufferUtility);
        LoadIT4GDocTables(It4GDocTemp, BufferUtility);

        //WebClient Connection Setup
        WebServicesClient.SetPosFuncProfile(PosFuncProfile);

        //Start New Packet
        IF NOT WebServicesClient.ReplStartPacket(PacketID, ProcessError, ErrorTextInternal) THEN begin
            ErrorText := ErrorTextInternal;
            exit;
        end;

        //Add Teables
        BufferUtility.GetTableList(TableBufferTemp);
        TableBufferTemp.RESET;
        TableBufferTemp.SETRANGE("Record Index", 1);
        IF TableBufferTemp.FINDSET THEN
            REPEAT
                RecRefTemp.OPEN(TableBufferTemp."Table No.", TRUE);
                WebRequestFunc.GetTableData(BufferUtility, RecRefTemp);
                IF NOT RecRefTemp.ISEMPTY THEN BEGIN
                    ReplCounterFieldName := '';
                    IF UpdateReplicationCounter then
                        ReplCounterFieldName := WSFunc.FindFieldNameByFieldNo(RecRefTemp.NUMBER, WSFunc.FindReplicationCounterFieldNo(RecRefTemp.NUMBER));
                    ProcessTry := 0;
                    repeat
                        ErrorTextInternal := '';
                        ProcessTry := ProcessTry + 1;
                        IF WebServicesClient.ReplAddTable(PacketID, RecRefTemp.NAME, 2, ReplCounterFieldName, RecRefTemp, ProcessError, ErrorTextInternal) THEN
                            ProcessTry := MaxProcessTry
                        else
                            if not ProcessError then
                                ProcessTry := MaxProcessTry;
                    until (ProcessTry >= MaxProcessTry);
                END;
                RecRefTemp.CLOSE;
            UNTIL (TableBufferTemp.NEXT = 0) or (ErrorTextInternal <> '');

        //Execute Packet
        IF ErrorTextInternal = '' then begin
            ProcessTry := 0;
            repeat
                ErrorTextInternal := '';
                ProcessTry := ProcessTry + 1;
                IF WebServicesClient.ReplExePacket(PacketID, ProcessError, ErrorTextInternal) THEN
                    ProcessTry := MaxProcessTry
                else
                    if not ProcessError then
                        ProcessTry := MaxProcessTry;
            until (ProcessTry >= MaxProcessTry);
        end;

        //End Packet
        IF ErrorTextInternal = '' then begin //Normal Cleanup
            ProcessTry := 0;
            repeat
                ErrorTextInternal := '';
                ProcessTry := ProcessTry + 1;
                IF WebServicesClient.ReplEndPacket(PacketID, ProcessError, ErrorTextInternal) THEN
                    ProcessTry := MaxProcessTry
                else
                    if not ProcessError then
                        ProcessTry := MaxProcessTry;
            until (ProcessTry >= MaxProcessTry);
        end else begin //Error Cleanup attempt, Not Relevant For Primary Error Reported
            ProcessTry := 0;
            repeat
                ErrorTextInternal2 := '';
                ProcessTry := ProcessTry + 1;
                IF WebServicesClient.ReplEndPacket(PacketID, ProcessError, ErrorTextInternal2) THEN
                    ProcessTry := MaxProcessTry
                else
                    if not ProcessError then
                        ProcessTry := MaxProcessTry;
            until (ProcessTry >= MaxProcessTry);
        end;

        IF ErrorTextInternal <> '' then begin
            ErrorText := ErrorTextInternal;
            exit;
        end;
    end;


    procedure LoadIT4GDocTables(var IT4GDocTemp: Record "IT4G-Doc. Header" temporary; var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
        IT4GDocH: Record "IT4G-Doc. Header";
        IT4GDocL: Record "IT4G-Doc. Line";
        IT4GDocLB: Record "IT4G-Doc. Line Box";
        IT4GDocS: Record "IT4G-Doc. Source";
        IT4GDocSC: Record "IT4G-Doc. Scan";
        WebRequestFunctions: Codeunit "LSC Web Request Functions";
    begin
        IT4GDocTemp.SETRECFILTER;
        RecRef.GETTABLE(IT4GDocTemp);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        IT4GDocL.SETRANGE("Document No.", IT4GDocTemp."Document No.");
        RecRef.GETTABLE(IT4GDocL);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        IT4GDocLB.SETRANGE("Document No.", IT4GDocTemp."Document No.");
        RecRef.GETTABLE(IT4GDocLB);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        IT4GDocS.SETRANGE("Document No.", IT4GDocTemp."Document No.");
        RecRef.GETTABLE(IT4GDocS);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        IT4GDocSC.SETRANGE("Document No.", IT4GDocTemp."Document No.");
        RecRef.GETTABLE(IT4GDocSC);
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
    end;

}
