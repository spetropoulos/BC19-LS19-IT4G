codeunit 50026 "IT4G-Loyalty"
{
    SingleInstance = true;
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    begin
        PanelID := cF.GRV_C('LOY_PanelID', 0, 1);
        DataGridControlID := cF.GRV_C('LOY_PanelID_DataGrid', 0, 1);
        DataInputID := cF.GRV_C('LOY_PanelID_Input', 0, 1);

        GlobalRec := Rec; //To have access in all functions
                          //        
        if rec."Registration Mode" then begin
            Registrate(Rec);
            exit;
        end;

        i += 1;
        case Rec.Command of
            'LOY_IT4G_MEMBER':
                IT4G_MemberPressed(rec."Current-INPUT");
            'LOY_MEMBER_CUSTOM':
                ProcessInternalCommand();
            'LOY_MEMBER':
                begin
                    CurrInput := POSCtrl.GetInputText(DataInputID);
                    POSCtrl.SetInputText(DataInputID, '');
                    ScanMember(CurrInput);
                end;

        end;
        UpdateTags();
        GlobalRec.Processed := true;
        Rec := GlobalRec;
    end;

    var
        GlobalReceiptNo: code[20];
        rInfo: Record "LSC Infocode";
        i: Integer;
        gVal: Array[20] of Text;
        POSTransFound: Boolean;
        PosTrans: Record "LSC POS Transaction";
        sl: Record "LSC POS Trans. Line";

        CurrInput: text;
        RecRef: RecordRef;
        POSCtrl: Codeunit "LSC POS Control Interface";
        GlobalRec: Record "LSC POS Menu Line";
        PosLookup: Record "LSC POS Lookup";
        PanelRec: Record "LSC POS Panel";
        PanelRecL: Record "LSC POS Panel Control Line";
        DataTableRec: Record "LSC POS Data Table";
        DataTableRecRef: RecordRef;
        CommandFunc: Codeunit "LSC POS Command Registration";
        POSSESSION: Codeunit "LSC POS Session";
        cPOSTrans: Codeunit "LSC POS Transaction";
        POSGui: Codeunit "LSC POS GUI";
        POSContext: Codeunit "LSC POS Context";
        PosDataSetUtil: Codeunit "LSC POS DataSet Utility";
        LSDataSet: Codeunit "LSC DataSet";
        EPOSCtrlInterf: Codeunit "LSC POS Control Interface";
        PosEvent: Codeunit "LSC POS Control Event";

        LookupID: Code[20];
        PanelID: Code[20];
        DataGridControlID: code[50];
        DataInputID: code[50];
        LookupActive: Boolean;
        GlobalCounter: Integer;
        cF: Codeunit "IT4G-Functions";
        globalText: text;

    procedure InitGlobals(): Boolean
    begin
        clear(gVal);
        exit(true);
    end;

    procedure Registrate(var MenuLine: Record "LSC POS Menu Line")
    var
        cPC: Codeunit "IT4G-POS Commands";
        ParameterType: Enum "LSC POS Command Parameter Type";
        rInfo: Record "LSC Infocode";
    begin
        CommandFunc.RegisterModule('IT4G_LOYALTY', 'IT4G Loyalty', 50026);

        CommandFunc.RegisterExtCommand('LOY_IT4G_MEMBER', 'IT4G Loyalty Member', 50026, ParameterType::" ", 'IT4G_LOYALTY', false);
        CommandFunc.RegisterExtCommand('LOY_MEMBER', 'Scan IT4G Loyalty Barcode', 50026, ParameterType::" ", 'IT4G_LOYALTY', false);
        CommandFunc.RegisterExtCommand('LOY_MEMBER_CUSTOM', 'Post IT4G Document', 50026, ParameterType::" ", 'IT4G_LOYALTY', false);
        CommandFunc.RegisterParameters('LOY_MEMBER_CUSTOM', 'SAVE', 0, '', 0, 0, 0, 0, 0);
        CommandFunc.RegisterParameters('LOY_MEMBER_CUSTOM', 'CLEAR', 0, '', 0, 0, 0, 0, 0);


        cF.SetRV_C('LOY_PanelID', 0, 1, 'IT4G_MEMBER_INFO');
        cF.SetRV_T('IT4G_Loy_Mobile_Prefix', 0, 1, '69');
        cF.SetRV_I('IT4G_Loy_OTP_Length', 0, 1, 4);

        cPC.createTag('<#IT4G_Loy_MemberID>', 'IT4G Member ID', 1);
        cPC.createTag('<#IT4G_Loy_MemberCard>', 'IT4G Member Card', 1);
        cPC.createTag('<#IT4G_Loy_MemberMOB>', 'IT4G Member Mobile', 1);
        cPC.createTag('<#IT4G_Loy_MemberName>', 'IT4G Member Name', 1);
        cPC.createTag('<#IT4G_Loy_MemberEmail>', 'IT4G Member Email', 1);
        cPC.createTag('<#IT4G_Loy_MemberPrevPoints>', 'IT4G Member Points', 1);
        cPC.createTag('<#IT4G_Loy_MemberTransPoints>', 'IT4G Member Points', 1);

        cPC.createTag('<#IT4G_LoyP_MemberID>', 'IT4G Member Page ID', 1);
        cPC.createTag('<#IT4G_LoyP_MemberCard>', 'IT4G Member Page Card', 1);
        cPC.createTag('<#IT4G_LoyP_MemberMOB>', 'IT4G Member Page Mobile', 1);
        cPC.createTag('<#IT4G_LoyP_MemberName>', 'IT4G Member Page Name', 1);
        cPC.createTag('<#IT4G_LoyP_MemberEmail>', 'IT4G Member Page Email', 1);
        cPC.createTag('<#IT4G_LoyP_MemberTransPoints>', 'IT4G Member Page Points', 1);
        cPC.createTag('<#IT4G_LoyP_Info>', 'IT4G Member Page Panel Info', 1);

        Clear(rInfo);
        rInfo."Once per Transaction" := true;
        rInfo.Triggering := rInfo.Triggering::"On Request";

        rInfo.Code := 'LOY_MEMB_TR_SEND';
        rInfo.Type := rInfo.Type::"Text Input";
        rInfo.Description := 'Loyalty Member Transaction Send';
        if rInfo.Insert(true) then;

        rInfo.Code := 'LOY_MEMB_MOB';
        rInfo.Type := rInfo.Type::"Text Input";
        rInfo.Description := 'Loyalty Member Mobile';
        if not rInfo.Insert(true) then rInfo.Modify(true);

        rInfo.Code := 'LOY_MEMB_NAME';
        rInfo.Type := rInfo.Type::"Text Input";
        rInfo.Description := 'Loyalty Member Name';
        if not rInfo.Insert(true) then rInfo.Modify(true);

        rInfo.Code := 'LOY_MEMB_MAIL';
        rInfo.Type := rInfo.Type::"Text Input";
        rInfo.Description := 'Loyalty Member Mail';
        if not rInfo.Insert(true) then rInfo.Modify(true);

        rInfo.Code := 'LOY_MEMB_POINTS';
        rInfo.Type := rInfo.Type::"Numeric Input";
        rInfo.Description := 'Loyalty Member Points';
        rInfo."Value is Amt./Qty." := true;
        if not rInfo.Insert(true) then rInfo.Modify(true);

        rInfo.Code := 'LOY_MEMB_TR_POINTS';
        rInfo.Type := rInfo.Type::"Numeric Input";
        rInfo.Description := 'Loyalty Member Transaction Points';
        rInfo."Value is Amt./Qty." := true;
        if not rInfo.Insert(true) then rInfo.Modify(true);

        rInfo.Code := 'LOY_MEMB_COUPON';
        rInfo.Type := rInfo.Type::"Text Input";
        rInfo.Description := 'Loyalty Member Transaction Points';
        rInfo."Value is Amt./Qty." := true;
        if not rInfo.Insert(true) then rInfo.Modify(true);

        MenuLine."Registration Mode" := false;  //Confirm registration
    end;

    local procedure ProcessInternalCommand()
    begin
        CurrInput := POSCtrl.GetInputText(DataInputID);
        POSCtrl.SetInputText(DataInputID, '');
        case GlobalRec.Parameter of
            'SAVE':
                SaveMemberInfoPressed();
            'CLEAR':
                ClearMemberInfoPressed();
            'CANCEL':
                begin
                    ClearTags();
                    EPOSCtrlInterf.HidePanel(PanelID, true);
                end;
        end;

    end;

    local Procedure UpdateTags()
    begin
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberID>', gVal[1]);
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberCard>', gVal[5]);
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberMOB>', gVal[4]);
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberName>', gVal[2] + ' ' + gVal[3]);
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberEmail>', gVal[7]);
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberPrevPoints>', gVal[6]);
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberTransPoints>', gVal[6]);
        POSContext.SetKeyValue('<#IT4G_LoyP_Info>', GlobalText);

        EPOSCtrlInterf.AddContext(POSContext);
    end;

    local Procedure ClearTags()
    begin
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberID>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberCard>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberMOB>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberName>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberEmail>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberPrevPoints>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_MemberTransPoints>', '');
        POSContext.SetKeyValue('<#IT4G_LoyP_Info>', '');

        EPOSCtrlInterf.AddContext(POSContext);
    end;


    procedure IT4G_MemberPressed(xParam: text): Boolean
    var
        Text001: Label '';
    begin
        InitGlobals();
        POSTransFound := true;

        if PosTrans.Get(GlobalRec."Current-RECEIPT") then begin
            if sl.Get(PosTrans."Receipt No.", GlobalRec."Current-LINE") then;
        end else
            POSTransFound := false;

        if not POSSESSION.GetPosPanelRec(PanelID, PanelRec) then begin
            posgui.PosMessage(StrSubstNo(Text001, PanelRec.TABLECAPTION, PanelID));
            exit(false);
        end;

        if xParam = '' then xParam := PosTrans."IT4G-Loyalty ID";
        ScanMember(xParam);

        GlobalReceiptNo := GlobalRec."Current-RECEIPT";
        EPOSCtrlInterf.ShowPanelModal(PanelID);
    end;

    local procedure ScanMember(xParam: text): Boolean
    var
        lblStart: label 'Scan Member First';
        cWS: Codeunit "IT4G-WEB Service Functions";
    begin
        If xParam = '' then begin
            globalText := lblStart;
            exit(false);
        end;
        clear(gVal);
        clear(cWS);
        if not cWS.IT4G_GetMember(xParam, GlobalText, gVal) then begin
            exit(false);
        end;

        exit(true);
    end;

    local procedure SaveMemberInfoPressed()
    var
        cInfo: Codeunit "LSC POS Infocode Utility";
        lblSelectTrans: Label 'Create Transaction First!!!!';
        b1: Boolean;
        b2: Boolean;
        i1: Integer;
    begin
        sl."Receipt No." := GlobalReceiptNo;
        sl."Line No." := 0;
        If not POSTransFound then begin
            globalText := lblSelectTrans;
            exit;
        end;
        if gVal[1] <> '' then begin
            If not CheckInfo('LOY_MEMB_TR_SEND') then exit;
            if not cInfo.IsInputOk(rInfo, 'false', globalText, sl, b1, false, false, b2, 0, '', '', false, 0, false, i1) then exit;
            If not CheckInfo('LOY_MEMB_MOB') then exit;
            if not cInfo.IsInputOk(rInfo, gVal[4], globalText, sl, b1, false, false, b2, 0, '', '', false, 0, false, i1) then exit;
            If not CheckInfo('LOY_MEMB_NAME') then exit;
            if not cInfo.IsInputOk(rInfo, gVal[2] + ' ' + gVal[3], globalText, sl, b1, false, false, b2, 0, '', '', false, 0, false, i1) then exit;
            If not CheckInfo('LOY_MEMB_POINTS') then exit;
            if not cInfo.IsInputOk(rInfo, gVal[6], globalText, sl, b1, false, false, b2, 0, '', '', false, 0, false, i1) then exit;
            If not CheckInfo('LOY_MEMB_MAIL') then exit;
            if not cInfo.IsInputOk(rInfo, gVal[7], globalText, sl, b1, false, false, b2, 0, '', '', false, 0, false, i1) then exit;
        end;
        ClearTags();

        POSSESSION.Setvalue('<#IT4G_Loy_MemberID>', gVal[1]);
        POSSESSION.Setvalue('<#IT4G_Loy_MemberCard>', gVal[5]);
        POSSESSION.Setvalue('<#IT4G_Loy_MemberMOB>', gVal[4]);
        POSSESSION.Setvalue('<#IT4G_Loy_MemberName>', gVal[2] + ' ' + gVal[3]);
        POSSESSION.Setvalue('<#IT4G_Loy_MemberEmail>', gVal[7]);
        POSSESSION.Setvalue('<#IT4G_Loy_MemberPrevPoints>', gVal[6]);

        cPOSTrans.GetPOSTransaction(PosTrans);
        PosTrans."IT4G-Loyalty Card" := gVal[5];
        PosTrans."IT4G-Loyalty ID" := gVal[1];
        PosTrans.Modify();
        cPOSTrans.SetPOSTransaction(PosTrans);

        EPOSCtrlInterf.HidePanel(PanelID, true);
    end;


    local procedure ClearMemberInfoPressed()
    var
        cInfo: Codeunit "LSC POS Infocode Utility";
        InfoEntry: Record "LSC POS Trans. Infocode Entry";
        lblMsg1: Label 'Member Deleted from transaction';
    begin

        cPOSTrans.GetPOSTransaction(PosTrans);
        PosTrans."IT4G-Loyalty Card" := '';
        PosTrans."IT4G-Loyalty ID" := '';
        PosTrans.Modify();
        cPOSTrans.SetPOSTransaction(PosTrans);

        clear(InfoEntry);
        InfoEntry.SetRange("Receipt No.", PosTrans."Receipt No.");
        InfoEntry.SetRange("Transaction Type", InfoEntry."Transaction Type"::Header);
        InfoEntry.SetFilter(Infocode, 'LOY_MEMB*');
        InfoEntry.deleteall(true);

        Clear(gVal);
        ClearTags();
        GlobalText := lblMsg1;

    end;

    Local Procedure CheckInfo(xInfo: code[20]): Boolean
    var
        lblErr: Label 'Infocode %1 not found on Database';
    begin
        if rInfo.get(xInfo) then exit(true);
        globalText := StrSubstNo(lblErr, xInfo);
        exit(false)
    end;

}
