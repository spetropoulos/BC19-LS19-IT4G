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
                IF rReg.INSERT(TRUE) THEN;
                exit(false);
            end;
        exit(true);
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

    procedure InsertLogEntry(iEntryNo: Integer; xModule: Text; xKey: Text; xDate: Date; xTime: Time; xStatus: Integer; xStatusText: Text; xStarted: DateTime; xFinished: DateTime; xProcessed: Integer; xErrors: Integer; xTable: Integer; xType: Integer; iInserted: Integer; iModified: Integer; iSkiped: Integer; xJobFinished: Boolean): Integer
    begin
        IF iEntryNo <> 0 THEN
            rLog.GET(iEntryNo)
        ELSE
            CLEAR(rLog);

        rLog.Module := xModule;
        rLog.Key := xKey;
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

    local procedure "----"()
    begin
    end;



}

