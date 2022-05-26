codeunit 50010 "IT4G-Functions"
{
    trigger OnRun()
    begin
    end;

    var
        rLog: Record "IT4G-Log";
        dDLG: Dialog;
        iCount: Integer;
        iTotal: Integer;
        iProgress: Integer;
        StartedOn: DateTime;
        xDlgText: Text;
        xDlgText1: Text;
        iOriginalTotal: Integer;

    local procedure "-----Registry Functions"()
    begin
    end;

    PROCEDURE GRV_GetRec(var rReg: Record "IT4G-Registry"; xKey: Text[100]; xLine: Integer): Boolean
    begin
        IF not rReg.GET(UserId, xKey, xLine) THEN
            if not rReg.GET('', xKey, xLine) THEN BEGIN
                rReg.Key := xKey;
                rReg."Line No." := xLine;
                IF rReg.INSERT(TRUE) THEN commit;
                exit(false);
            end;
        exit(true);
    end;

    procedure GRV_Date(xKey: Text[100]; xLine: Integer; xVal: Integer): Date
    var
        rReg: Record "IT4G-Registry";
    begin
        IF GRV_GetRec(rReg, xKey, xLine) then begin
            IF xVal = 1 THEN EXIT(rReg."Value Date 1");
            IF xVal = 2 THEN EXIT(rReg."Value Date 2");
        END else
            EXIT(0D);
    end;

    procedure GRV_T(xKey: Text[100]; xLine: Integer; xVal: Integer): Text
    var
        rReg: Record "IT4G-Registry";
    begin
        IF GRV_GetRec(rReg, xKey, xLine) then begin
            IF xVal = 1 THEN EXIT(rReg."Value Text 1");
            IF xVal = 2 THEN EXIT(rReg."Value Text 2");
        END else
            EXIT('');
    end;

    procedure GRV_C(xKey: Text[100]; xLine: Integer; xVal: Integer): Code[20]
    var
        rReg: Record "IT4G-Registry";
    begin
        IF GRV_GetRec(rReg, xKey, xLine) then begin
            IF xVal = 1 THEN EXIT(rReg."Value Code 1");
            IF xVal = 2 THEN EXIT(rReg."Value Code 2");
        END ELSE
            EXIT('');
    end;

    procedure GRV_B(xKey: Text[100]; xLine: Integer; xVal: Integer): Boolean
    var
        rReg: Record "IT4G-Registry";
    begin
        IF GRV_GetRec(rReg, xKey, xLine) then begin
            IF xVal = 1 THEN EXIT(rReg."Value Bool 1");
            IF xVal = 2 THEN EXIT(rReg."Value Bool 2");
        END else
            EXIT(FALSE);
    end;

    procedure GRV_D(xKey: Text[100]; xLine: Integer; xVal: Integer): Decimal
    var
        rReg: Record "IT4G-Registry";
    begin
        IF GRV_GetRec(rReg, xKey, xLine) then begin
            IF xVal = 1 THEN EXIT(rReg."Value Dec 1");
            IF xVal = 2 THEN EXIT(rReg."Value Dec 2");
        END ELSE
            EXIT(0);
    end;

    procedure GRV_I(xKey: Text[100]; xLine: Integer; xVal: Integer): Integer
    var
        rReg: Record "IT4G-Registry";
    begin
        IF GRV_GetRec(rReg, xKey, xLine) then begin
            IF xVal = 1 THEN EXIT(rReg."Value Int 1");
            IF xVal = 2 THEN EXIT(rReg."Value Int 2");
        END ELSE
            EXIT(0);
    end;

    procedure SetRV_I(xKey: Text[100]; xLine: Integer; xWhat: Integer; xVal: Integer)
    var
        rReg: Record "IT4G-Registry";
    begin
        GRV_GetRec(rReg, xKey, xLine);
        IF xWhat = 1 THEN rReg."Value Int 1" := xVal;
        IF xWhat = 2 THEN rReg."Value Int 2" := xVal;
        rReg.modify;
    end;

    procedure SetRV_B(xKey: Text[100]; xLine: Integer; xWhat: Integer; xVal: Boolean)
    var
        rReg: Record "IT4G-Registry";
    begin
        GRV_GetRec(rReg, xKey, xLine);
        IF xWhat = 1 THEN rReg."Value Bool 1" := xVal;
        IF xWhat = 2 THEN rReg."Value Bool 2" := xVal;
        rReg.modify;
    end;

    procedure SetRV_D(xKey: Text[100]; xLine: Integer; xWhat: Integer; xVal: Decimal)
    var
        rReg: Record "IT4G-Registry";
    begin
        GRV_GetRec(rReg, xKey, xLine);
        IF xWhat = 1 THEN rReg."Value Dec 1" := xVal;
        IF xWhat = 2 THEN rReg."Value Dec 2" := xVal;
        rReg.modify;
    end;

    procedure SetRV_C(xKey: Text[100]; xLine: Integer; xWhat: Integer; xVal: Code[20])
    var
        rReg: Record "IT4G-Registry";
    begin
        GRV_GetRec(rReg, xKey, xLine);
        IF xWhat = 1 THEN rReg."Value Code 1" := xVal;
        IF xWhat = 2 THEN rReg."Value Code 2" := xVal;
        rReg.modify;
    end;

    procedure SetRV_T(xKey: Text[100]; xLine: Integer; xWhat: Integer; xVal: Text)
    var
        rReg: Record "IT4G-Registry";
    begin
        GRV_GetRec(rReg, xKey, xLine);
        IF xWhat = 1 THEN rReg."Value Text 1" := xVal;
        IF xWhat = 2 THEN rReg."Value text 2" := xVal;
        rReg.modify;
    end;

    procedure SetRV_Date(xKey: Text[100]; xLine: Integer; xWhat: Integer; xVal: Date)
    var
        rReg: Record "IT4G-Registry";
    begin
        GRV_GetRec(rReg, xKey, xLine);
        IF xWhat = 1 THEN rReg."Value Date 1" := xVal;
        IF xWhat = 2 THEN rReg."Value Date 2" := xVal;
        rReg.modify;
    end;

    procedure DialogMng(DoWhat: Option Open,Update,Close; xiCount: Integer; xInputText1: Text; bShowEstimation: Boolean; xTotal: Integer; DialogSlow: Integer; iInserted: Integer; iModified: Integer; iSkipped: Integer; iError: Integer; bAnalysis: Boolean)
    var
        xInputText: Text;
        EstDur: Duration;
    begin
        CASE DoWhat OF
            DoWhat::Open:
                BEGIN
                    StartedOn := CURRENTDATETIME;
                    iTotal := 0;
                    iProgress := 0;
                    xDlgText := '';
                    iCount := 0;

                    iInserted := 0;
                    iModified := 0;
                    iSkipped := 0;
                    iError := 0;

                    DialogSlow := GRV_I('Bridge_Dialog_Slow_Progress', 0, 1);

                    iTotal := xiCount;
                    iOriginalTotal := xTotal;

                    xInputText := xInputText1;
                    IF bShowEstimation THEN xInputText += '\Starten On: ' + FORMAT(StartedOn) + '\Estim. Finish: #5';
                    IF bAnalysis THEN xInputText += '\------------\Inserted: #6\Updated: #7\Skipped: #8\Errors: #9';
                    IF GUIALLOWED THEN dDLG.OPEN(xInputText, iProgress, xDlgText, xDlgText1);
                END;
            DoWhat::Update:
                BEGIN
                    iCount += 1;
                    iProgress := ROUND(iCount / iTotal * 10000, 1);
                    xDlgText1 := xInputText1;
                    xDlgText := FORMAT(iCount, 0, '<Integer Thousand>') + '/' + FORMAT(iTotal, 0, '<Integer Thousand>');

                    IF iOriginalTotal <> iTotal THEN xDlgText += ' of ' + FORMAT(iOriginalTotal, 0, '<Integer Thousand>');
                    IF GUIALLOWED THEN dDLG.UPDATE();

                    IF bShowEstimation THEN BEGIN
                        EstDur := CURRENTDATETIME - StartedOn;
                        EstDur := ROUND(EstDur / iCount * (iTotal - iCount), 1, '>');
                        EstDur := ROUND(EstDur / 1000, 1, '>') * 1000;
                        dDLG.UPDATE(5, EstDur);
                    END;
                    IF bAnalysis THEN BEGIN
                        dDLG.UPDATE(6, FORMAT(iInserted, 0, '<Integer Thousand>'));
                        dDLG.UPDATE(7, FORMAT(iModified, 0, '<Integer Thousand>'));
                        dDLG.UPDATE(8, FORMAT(iSkipped, 0, '<Integer Thousand>'));
                        dDLG.UPDATE(9, FORMAT(iError, 0, '<Integer Thousand>'));
                    END;

                    IF DialogSlow <> 0 THEN SLEEP(DialogSlow);
                END;
            DoWhat::Close:
                BEGIN
                    IF GUIALLOWED THEN dDLG.CLOSE;
                END;
        END;
    end;

    local procedure "----Log"()
    begin
    end;

    procedure InsertLogEntry(iEntryNo: Integer;
                xModule: Text;
                xKey: Text;
                xDate: Date;
                xTime: Time;
                xStatus: Integer;
                xStatusText: Text;
                xStarted: DateTime;
                xFinished: DateTime;
                xProcessed: Integer;
                xErrors: Integer;
                xTable: Integer;
                xType: Integer;
                iInserted: Integer;
                iModified: Integer;
                iSkiped: Integer;
                xJobFinished: Boolean;
                xBatch: Code[20]): Integer
    begin
        IF iEntryNo <> 0 THEN
            rLog.GET(iEntryNo)
        ELSE
            CLEAR(rLog);

        rLog.Module := xModule;
        rLog.Key := xKey;
        rLog."Batch ID" := xBatch;
        rLog.User := USERID;
        rLog."Table ID" := xTable;
        rLog.Type := xType;
        rLog."Posting Date" := xDate;
        rLog."Posting Time" := xTime;
        rLog.Status := xStatus;
        rLog."Status Text" := xStatusText;
        rLog.Started := xStarted;
        rLog.Finished := xFinished;

        rLog.Duration := xFinished - xStarted;

        rLog.Processed := xProcessed;
        rLog.Errors := xErrors;
        rLog.Inserted := iInserted;
        rLog.Modified := iModified;
        rLog.Skipped := iSkiped;
        rLog."Job Finished" := xJobFinished;

        IF iEntryNo = 0 THEN
            rLog.INSERT(TRUE)
        ELSE
            rLog.MODIFY(TRUE);


        EXIT(rLog."Entry No.");
    end;

    procedure GetLoyaltyInfoPOS(xType: integer; xReceiptNo: Text): Text
    var
        rPTIE: record "LSC POS Trans. Infocode Entry";
    begin
        clear(rPTIE);
        rPTIE.setrange("Receipt No.", xReceiptNo);
        rPTIE.SetRange("Line No.", 0);
        case xType of
            1:
                rPTIE.setrange(Infocode, 'LOY_MEMB_MOB');
            2:
                rPTIE.setrange(Infocode, 'LOY_MEMB_NAME');
            3:
                rPTIE.setrange(Infocode, 'LOY_MEMB_POINTS');
            4:
                rPTIE.setrange(Infocode, 'LOY_MEMB_MAIL');
        end;
        if rPTIE.findfirst then exit(rPTIE.Information);
        exit('');
    end;

    procedure GetLoyaltyInfoTrans(xType: integer; xStore: Code[20]; xPOS: code[20]; xTransNo: Integer): Text
    var
        rPTIE: record "LSC Trans. Infocode Entry";
    begin
        clear(rPTIE);
        rPTIE.setrange("Store No.", xStore);
        rPTIE.SetRange("POS Terminal No.", xPOS);
        rPTIE.SetRange("Transaction No.", xTransNo);
        rPTIE.SetRange("Line No.", 0);

        case xType of
            1:
                rPTIE.setrange(Infocode, 'LOY_MEMB_MOB');
            2:
                rPTIE.setrange(Infocode, 'LOY_MEMB_NAME');
            3:
                rPTIE.setrange(Infocode, 'LOY_MEMB_POINTS');
            4:
                rPTIE.setrange(Infocode, 'LOY_MEMB_MAIL');
            5:
                rPTIE.setrange(Infocode, 'LOY_MEMB_TR_POINTS');
        end;
        if rPTIE.findfirst then exit(rPTIE.Information);
        exit('');
    end;


    procedure ExportFile(xFileContent: text; Filename: text; FileExtention: Text)
    var
        FileMgmt: Codeunit "File Management";
        ServerFileName: Text;
        DotFile: File;
        LogOutStream: OutStream;
        LogInStream: InStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        ServerFileName := FileMgmt.ServerTempFileName(FileExtention);
        TempBlob.CreateOutStream(LogOutStream);
        LogOutStream.WriteText(xFileContent);
        TempBlob.CreateInStream(LogInStream);
        Serverfilename := FileMgmt.InstreamExportToServerFile(LogInStream, FileExtention);
        FileMgmt.CopyServerFile(ServerFileName, FileName, true);
        FileMgmt.DeleteServerFile(ServerFileName);

    end;

    procedure PrintTestZPL()
    var
        PrinterSelection: Record "Printer Selection";
        BOPrintUtil: Codeunit "LSC BO Print Utility";
        OStream: OutStream;
        IStream: InStream;
        ErrorText: Text;
        Text001: Label 'TEST Label';
        Text003: Label 'Label printout sent to "%1"';
        CR: Char;
        LF: Char;
        LabelPrinter: Record "LSC Label Printer Selection";
        TempBlob: Codeunit "Temp Blob";
        LineEnd: Text;
        NoLabelPrinter: Label 'No Printer defined for Item Label.';
        rIL: Record "LSC Label Functions";
    begin
        if not LabelPrinter.Get(UserId, rIL.Type::"Item Label", '71X120ZEBRA') then
            if not LabelPrinter.Get('', rIL.Type::"Item Label", '71X120ZEBRA') then
                error(NoLabelPrinter);
        CR := 13;
        LF := 10;
        LineEnd := Format(CR) + Format(LF);

        TempBlob.CreateOutStream(OStream);

        OStream.WriteText(LineEnd);
        OStream.WriteText('^XA' + LineEnd);
        OStream.WriteText('^FX Top section with logo, name and address.' + LineEnd);
        OStream.WriteText('^CF0,60' + LineEnd);
        OStream.WriteText('^FO50,50^GB100,100,100^FS' + LineEnd);
        OStream.WriteText('^FO75,75^FR^GB100,100,100^FS' + LineEnd);
        OStream.WriteText('^FO93,93^GB40,40,40^FS' + LineEnd);
        OStream.WriteText('^FO220,50^FDIntershipping, Inc.^FS' + LineEnd);
        OStream.WriteText('^CF0,30' + LineEnd);
        OStream.WriteText('^FO220,115^FD1000 Shipping Lane^FS' + LineEnd);
        OStream.WriteText('^FO220,155^FDShelbyville TN 38102^FS' + LineEnd);
        OStream.WriteText('^FO220,195^FDUnited States (USA)^FS' + LineEnd);
        OStream.WriteText('^FO50,250^GB700,3,3^FS' + LineEnd);
        OStream.WriteText('^FX Second section with recipient address and permit information.' + LineEnd);
        OStream.WriteText('^CFA,30' + LineEnd);
        OStream.WriteText('^FO50,300^FDJohn Doe^FS' + LineEnd);
        OStream.WriteText('^FO50,340^FD100 Main Street^FS' + LineEnd);
        OStream.WriteText('^FO50,380^FDSpringfield TN 39021^FS' + LineEnd);
        OStream.WriteText('^FO50,420^FDUnited States (USA)^FS' + LineEnd);
        OStream.WriteText('^CFA,15' + LineEnd);
        OStream.WriteText('^FO600,300^GB150,150,3^FS' + LineEnd);
        OStream.WriteText('^FO638,340^FDPermit^FS' + LineEnd);
        OStream.WriteText('^FO638,390^FD123456^FS' + LineEnd);
        OStream.WriteText('^FO50,500^GB700,3,3^FS' + LineEnd);
        OStream.WriteText('^FX Third section with bar code.' + LineEnd);
        OStream.WriteText('^BY5,2,270' + LineEnd);
        OStream.WriteText('^FO100,550^BC^FD12345678^FS' + LineEnd);
        OStream.WriteText('^FX Fourth section (the two boxes on the bottom).' + LineEnd);
        OStream.WriteText('^FO50,900^GB700,250,3^FS' + LineEnd);
        OStream.WriteText('^FO400,900^GB3,250,3^FS' + LineEnd);
        OStream.WriteText('^CF0,40' + LineEnd);
        OStream.WriteText('^FO100,960^FDCtr. X34B-1^FS' + LineEnd);
        OStream.WriteText('^FO100,1010^FDREF1 F00B47^FS' + LineEnd);
        OStream.WriteText('^FO100,1060^FDREF2 BL4H8^FS' + LineEnd);
        OStream.WriteText('^CF0,190' + LineEnd);
        OStream.WriteText('^FO470,955^FDCA^FS' + LineEnd);
        OStream.WriteText('^XZ' + LineEnd);
        OStream.WriteText(LineEnd);


        TempBlob.CreateInStream(IStream);
        PrinterSelection."Printer Name" := LabelPrinter."Hardware Station Printer";
        PrinterSelection."LSC Print to File" := LabelPrinter."Print to File";
        BOPrintUtil.DoPrint(IStream, BOPrintUtil.GetLabelPrinterUrl(LabelPrinter."Hardware Station Printer"), PrinterSelection, ErrorText);
        if ErrorText <> '' then
            error(ErrorText);

        Message(StrSubstNo(Text003, LabelPrinter."Hardware Station Printer"));
    end;


}

