codeunit 50040 "IT4G-WEB Service Functions"
{
    var
        dDLG: Dialog;
        cUtil: Codeunit "IT4G-WEB Service Utils";
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

    procedure IT4G_LOY_SendProduct(xInput: Text; var RetText: Text): Boolean
    var
        retVal: Array[20] of Text;
    begin
        exit(IT4G_LOY_SendProduct(xInput, RetText, retVal));
    end;

    procedure IT4G_LOY_SendProduct(xInput: Text; var RetText: Text; var retVal: Array[20] of Text): Boolean
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
                    exit(Pobuca_SendProduct(xInput, RetText, retVal));
                end;
        end;
    end;

    procedure IT4G_GetMember(xInput: Text; var RetText: Text): Boolean
    var
        retVal: Array[20] of Text;
    begin
        exit(IT4G_GetMember(xInput, RetText, retVal));
    end;

    procedure IT4G_GetMember(xInput: Text; var RetText: Text; var retVal: Array[20] of Text): Boolean
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
                    exit(Pobuca_GetAccount(xInput, RetText, retVal));
                end;
        end;
    end;

    procedure IT4G_SendLoyTransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer): Boolean
    var
        retVal: Array[20] of Text;
        RetText: Text;
    begin
        exit(IT4G_SendLoyTransaction(xStore, xPOS, xTransNo, RetText, retVal));
    end;

    procedure IT4G_SendLoyTransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text): Boolean
    var
        retVal: Array[20] of Text;
    begin
        exit(IT4G_SendLoyTransaction(xStore, xPOS, xTransNo, RetText, retVal));
    end;

    procedure IT4G_SendLoyTransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text; var retVal: Array[20] of Text): Boolean
    var
        rPOS: Record "LSC POS Terminal";
        rTH: Record "LSC Transaction Header";
        lblError1: label 'Transaction Not Found!!!';
        lblError2: label 'Transaction has not a Loyalty member Assigned!!!';
    begin
        If not rTh.get(xStore, xPOS, xTransNo) then begin
            RetText := lblError1;
            exit(true);
        end;
        If rTh."IT4G-Loyalty ID" = '' then begin
            RetText := lblError2;
            exit(true);
        end;

        GlobalPOS := xPOS;
        rPOS.Get(GlobalPOS);
        case rPOS."Loyalty System" of
            rPOS."Loyalty System"::POBUCA:
                begin
                    exit(Pobuca_SendLoyTransaction(xStore, xPOS, xTransNo, RetText, retVal));
                end;
        end;
    end;

    procedure IT4G_SendAADETransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer): Boolean
    var
        retVal: Array[20] of Text;
        RetText: Text;
    begin
        exit(IT4G_SendAADETransaction(xStore, xPOS, xTransNo, RetText, retVal));
    end;

    procedure IT4G_SendAADETransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text): Boolean
    var
        retVal: Array[20] of Text;
    begin
        exit(IT4G_SendAADETransaction(xStore, xPOS, xTransNo, RetText, retVal));
    end;

    procedure IT4G_SendAADETransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text; var retVal: Array[20] of Text): Boolean
    var
        rPOS: Record "LSC POS Terminal";
        rTH: Record "LSC Transaction Header";
        lblError1: label 'Transaction Not Found!!!';
        lblError2: label 'Transaction has not a Loyalty member Assigned!!!';
    begin
        If not rTh.get(xStore, xPOS, xTransNo) then begin
            RetText := lblError1;
            exit(true);
        end;

        GlobalPOS := xPOS;
        rPOS.Get(GlobalPOS);
        case rPOS."Fiscal Printer Software" of
            rPOS."Fiscal Printer Software"::SoftOne_WS:
                begin
                    exit(AADE_SoftOneSendLSDoc(xStore, xPOS, xTransNo, RetText, retVal));
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
        commit;
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

    local procedure Pobuca_GetAccount(xInput: Text; var RetText: Text; var retVal: Array[20] of Text) bOK: Boolean
    var
        lblSend: Label 'Getting Member Data from POBUCA\Please Wait...';
        lblMobNotFound: Label 'Mobile %1 not found on Database.\Create new Loyalty User with mobile %1?';
    begin
        IF GuiAllowed THEN dDLG.Open(lblSend);
        Init('POBUCA', 'GET_ACC');

        IF COPYSTR(xInput, 1, strlen(cF.GRV_T('IT4G_Loy_Mobile_Prefix', 0, 1))) = cF.GRV_T('IT4G_Loy_Mobile_Prefix', 0, 1) THEN
            gParams[1] := 'MOB'
        else
            IF STRLEN(xInput) = cF.GRV_I('IT4G_Loy_OTP_Length', 0, 1) THEN
                gParams[1] := 'OTP'
            else
                IF STRLEN(xInput) <= 20 THEN
                    gParams[1] := 'CRD'
                else
                    gParams[1] := '';
        gParams[2] := xInput;
        cUtil.SetService('Pobuca_RetrieveAccount', rGWSSL.Code, rGWSSL.SubCode, gKey + '-' + xInput, gParams);
        bOK := ProcessService();
        if bOK then begin
            cUtil.getRetvalues(retVal);
        end else begin
            RetText := GetLastErrorText();
            cUtil.getRetvalues(retVal);
            if gParams[1] = 'MOB' then
                if retVal[1] = 'UserNotFound' Then
                    if Confirm(StrSubstNo(lblMobNotFound, xInput)) then begin
                        IF GuiAllowed THEN dDLG.Close();
                        exit(Pobuca_CreateAccount(xInput, RetText, retVal));
                    end;
        end;

        exit(bOK);
    end;

    local procedure Pobuca_CreateAccount(xInput: Text; var RetText: Text; var retVal: Array[20] of Text) bOK: Boolean
    var
        lblSend: Label 'Create Member From mobile POBUCA\Please Wait...';
    begin
        IF GuiAllowed THEN dDLG.Open(lblSend);
        Init('POBUCA', 'ACC_CREATE');

        gParams[1] := 'MOB';
        gParams[2] := xInput;

        cUtil.SetService('Pobuca_CreateAccount', rGWSSL.Code, rGWSSL.SubCode, gKey + '-' + xInput, gParams);
        bOK := ProcessService();
        if bOK then begin
            cUtil.getRetvalues(retVal);
        end else begin
            RetText := GetLastErrorText();
        end;
        IF GuiAllowed THEN dDLG.Close();
        exit(bOK);
    end;

    local procedure Pobuca_SendLoyTransaction(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text; var retVal: Array[20] of Text) bOK: Boolean
    var
        lblSend: Label 'Sending Transaction to POBUCA!!!\Please Wait...';
    begin
        IF GuiAllowed THEN dDLG.Open(lblSend);
        Init('POBUCA', 'INV_SEND');
        gParams[1] := xStore;
        gParams[2] := xPOS;
        gParams[3] := format(xTransNo);

        cUtil.SetService('Pobuca_SubmitInvoice', rGWSSL.Code, rGWSSL.SubCode, gKey + '-' + gParams[1] + '-' + gParams[2] + '-' + gParams[3], gParams);
        bOK := ProcessService();
        if bOK then begin
            cUtil.getRetvalues(retVal);
            RetText := retVal[1];
        end else begin
            RetText := GetLastErrorText();
        end;
        IF GuiAllowed THEN dDLG.Close();
        exit(bOK);
    end;

    local procedure Pobuca_SendProduct(xItem: Code[20]; var RetText: Text; var retVal: Array[20] of Text) bOK: Boolean
    var
        lblSend: Label 'Sending Items to POBUCA!!!\Please Wait...';
    begin
        IF GuiAllowed THEN dDLG.Open(lblSend);
        Init('POBUCA', 'ITEM_SEND');
        gParams[1] := xItem;

        cUtil.SetService('Pobuca_SendProduct', rGWSSL.Code, rGWSSL.SubCode, gKey + '-' + gParams[1], gParams);
        bOK := ProcessService();
        if bOK then begin
            cUtil.getRetvalues(retVal);
            RetText := retVal[1];
        end else begin
            RetText := GetLastErrorText();
        end;
        IF GuiAllowed THEN dDLG.Close();
        exit(bOK);
    end;

    local procedure AADE_SoftOneSendLSDoc(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; var RetText: Text; var retVal: Array[20] of Text) bOK: Boolean
    var
        lblSend: Label 'Sending Document to AADE\Please Wait...';
    begin
        IF GuiAllowed THEN dDLG.Open(lblSend);
        Init('AADE-SOFTONE', 'INVOICE');
        gParams[1] := xStore;
        gParams[2] := xPOS;
        gParams[3] := format(xTransNo);

        cUtil.SetService('AADE_SoftOne_SendInvoice', rGWSSL.Code, rGWSSL.SubCode, gKey + '-' + gParams[1] + '-' + gParams[2] + '-' + gParams[3], gParams);
        bOK := ProcessService();
        if bOK then begin
            cUtil.getRetvalues(retVal);
        end else begin
        end;
        IF GuiAllowed THEN dDLG.Close();
        exit(bOK);
    end;


}
