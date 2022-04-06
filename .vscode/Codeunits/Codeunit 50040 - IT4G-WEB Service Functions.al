codeunit 50040 "IT4G - WEB Service Functions"
{
    var
        cUtil: Codeunit "IT4G - WEB Service Utils";
        rLog: Record "IT4G-Log";
        LogEntryNo: Integer;
        rGWSS: Record "IT4G-WEb Service Setup";
        rGWSSL: Record "IT4G-WEb Service Setup Line";
        lbServiceNotFound: Label 'Active WEB Service Setup %1 not found!!!';
        lbMethodNotFound: Label 'Method %1 not found for Service %2!!!';
        gStarted: DateTime;
        gParams: Array[20] of Text;
        gKey: Text;
        cPS: Codeunit "LSC POS Session";
        GlobalStore: Text;
        GlobalPOS: Text;
        cF: Codeunit "IT4G-Functions";

    procedure GetIT4GMember(xInput: Text; var RetText: Text; var retVal: Array[20] of Text): Boolean
    var
        rRU: Record "LSC Retail User";
        rPOS: Record "LSC POS Terminal";
    begin
        GlobalStore := cPS.StoreNo();
        GlobalPOS := cPS.TerminalNo();
        rPOS.Get(GlobalPOS);
        case rPOS."Loyalty System" of
            rPOS."Loyalty System"::POBUCA:
                begin
                    exit(Pobuca_RetrieveAccount(xInput, RetText, retVal));
                end;
        end;
    end;

    procedure Init(xCode: code[20]; xSubCode: code[20]);
    begin
        getWSSetup(xCode, xSubCode);
        gStarted := CurrentDateTime;
        gKey := CreateGuid() + '-' + xCode + '-' + xSubCode;
        clear(cUtil);
    end;

    procedure ProcessService() bOK: Boolean
    begin
        bOK := cUtil.run;

        CreateWEBLogEntry(bOK);
    end;

    procedure getWSSetup(xCode: code[20]; xSubCode: code[20])
    begin
        clear(rGWSS);
        rGWSS.setrange(Code, xCode);
        rGWSS.SetRange(Active, true);
        If Not rGWSS.FindFirst() then error(lbServiceNotFound, xCode);
        If not rGWSSL.get(xCode, xSubCode) then error(lbMethodNotFound, xSubCode, xCode);
    end;

    procedure CreateWEBLogEntry(bOK: Boolean): Integer
    var
        bCreateLog: Boolean;
    begin
        bCreateLog := false;
        case rGWSS.Logging of
            rGWSS.Logging::All:
                bCreateLog := true;
            rGWSS.Logging::None:
                bCreateLog := false;
            rGWSS.Logging::"Only Errors":
                bCreateLog := not bOK;
        end;

        if not bCreateLog then exit;

        clear(rLOG);
        rLog."Module" := 'WEB Service';
        rLog."Key" := gKey;
        rLog."Table ID" := 0;
        rLog."Type" := rLog."Type"::WS;
        rLog."User" := UserId;
        rLog."Posting Date" := Today;
        rLog."Posting Time" := Time;
        if bOK then
            rLog."Status" := rLog."Status"::Success
        else begin
            rLog."Status" := rLog."Status"::Error;
            rLog."Status Text" := copystr(GetLastErrorText(), 1, 250);
        end;
        rLog."Started" := gStarted;
        rLog."Finished" := CurrentDateTime;
        rLog.Duration := rLog."Finished" - rLog."Started";
        rLog."Processed" := 0;
        rLog."Errors" := 0;
        rLog."Inserted" := 0;
        rLog."Modified" := 0;
        rLog."Skipped" := 0;
        rLog."Job Finished" := false;
        rLog."Batch ID" := '';
        rLog."WEB Service URL" := copystr(cUtil.GetURL(), 1, MaxStrLen(rLog."WEB Service URL"));
        rLog."WEB Service Status" := cUtil.GetStatus();
        rLog."WEB Service Code" := rGWSS.Code;
        rLog.Insert;
    end;

    //------------------------------ Services ------------------------------
    procedure TestService()
    var
    begin
        Init('TEST', 'TEST');
        //        cUtil.SetService('', gParams, rGWSS, 'Test Service');

    end;

    procedure Pobuca_RetrieveAccount(xInput: Text; var RetText: Text): Boolean
    var
        retVal: Array[20] of Text;
    begin
        exit(Pobuca_RetrieveAccount(xInput, RetText, RetVal));
    end;

    procedure Pobuca_RetrieveAccount(xInput: Text; var RetText: Text; var retVal: Array[20] of Text): Boolean
    var
    begin
        Init('POBUCA', 'GET_ACC');

        IF COPYSTR(xInput, 1, strlen(cF.GRV_T('IT4G_Loy_Mobile_Prefix', 0, 1))) = cF.GRV_T('IT4G_Loy_Mobile_Prefix', 0, 1) THEN
            gParams[1] := 'MOB'
        else
            IF STRLEN(xInput) = cF.GRV_I('IT4G_Loy_OTP_Length', 0, 1) THEN
                gParams[1] := 'OTP'
            else
                gParams[1] := 'CRD';

        gParams[2] := xInput;
        cUtil.SetService('Pobuca_RetrieveAccount', 'POBUCA', 'GET_ACC', gKey + '-' + xInput, gParams);
        if ProcessService() then begin
            cUtil.getRetvalues(retVal);
        end else begin
            RetText := GetLastErrorText();
            exit(false);
        end;
        exit(true);
    end;

    procedure Pobuca_SubmitInvoice(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text): Boolean
    var
        retVal: Array[20] of Text;
    begin
        exit(Pobuca_SubmitInvoice(xStore, xPOS, xTransNo, RetText, retVal));
    end;

    procedure Pobuca_SubmitInvoice(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text; var retVal: Array[20] of Text): Boolean
    var
        rTH: Record "LSC Transaction Header";
    begin
        Init('POBUCA', 'INV_SEND');
        gParams[1] := xStore;
        gParams[2] := xPOS;
        gParams[3] := format(xTransNo);
        If not rTh.get(xStore, xPOS, xTransNo) then exit(true);
        If rTh."IT4G-Loyalty ID" = '' then exit(true);

        cUtil.SetService('Pobuca_SubmitInvoice', 'POBUCA', 'INV_SEND', gKey + '-' + gParams[1] + '-' + gParams[2] + '-' + gParams[3], gParams);
        if ProcessService() then begin
            cUtil.getRetvalues(gParams);
        end else begin
            RetText := GetLastErrorText();
            exit(false);
        end;
        exit(true);

    end;


}
