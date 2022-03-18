codeunit 50025 "IT4G-Trans. Server Util"
{
    var
        PosFuncProfile: Record "LSC POS Func. Profile";
        //        POSFuncProfileWebRequest: Record "LSC POS Func. Profile Web Req.";
        POSTerminal_g: Record "LSC POS Terminal";
        Store_g: Record "LSC Store";
        TransactionHeaderTemp_g: Record "LSC Transaction Header" temporary;
        BOUtil: Codeunit "LSC BO Utils";
        BufferUtility: Codeunit "LSC Buffer Utility";
        DCUTIL3: Codeunit "LSC Data Dir. POS Client Util";
        Globals: Codeunit "LSC POS Session";
        ItemTrack: Codeunit "LSC Retail Item Tracking";
        POSFunc: Codeunit "LSC POS Functions";
        POSGUI: Codeunit "LSC POS GUI";
        WebServicesClient: Codeunit "LSC Web Services Client";
        Text001: Label 'Request %1 is only available as web request';
        LocalizationExt: Codeunit "LSC Retail Localization Ext.";
        TSAction_g: Option ,Update,Delete;
        InUse: Boolean;
        WorkTableUpdateTemp_g: Boolean;
        StatusandEntriesTxt: Label 'Status and Entries';
        TSErrTxt: Label 'TS Error: %1';
        FisPOSCommand: Codeunit "LSC Fiscal POS Commands";
        cPTU: Codeunit "LSC POS Trans. Server Utility";


    [Scope('OnPrem')]
    procedure Initialize(): Boolean
    var
        rRU: Record "LSC Retail User";
    begin
        if PosFuncProfile."Profile ID" = '' then begin
            if Globals.StoreNo = '' then begin
                rRU.get(UserId);
                Globals.SetStore(rRU."Store No.");
                Globals.SetTerminal(rRU."POS Terminal");
                PosFunc.InitPosFunctions;

            end;

            Store_g.Get(Globals.StoreNo);
            PosFuncProfile.Get(Globals.FunctionalityProfileID);
            POSTerminal_g.Get(Globals.TerminalNo);
        end;

        InUse := cPTU.TSInUse(PosFuncProfile);
        exit(true);
        exit(InUse);
    end;

    [Scope('OnPrem')]
    procedure GetIT4GDoc(var rIT4GDoc: Record "IT4G-Doc. Header"; xIT4GDocNo: Code[20]; var ErrorText: Text): Boolean
    var
        GetIT4GDocUtils: Codeunit "IT4G-WS-IT4GUtils";
        ResponseCode: Code[30];
        BufferUtility: Codeunit "LSC Buffer Utility";
    begin
        if not Initialize then
            exit(false);
        if PosFuncProfile."TS Void Transactions" then begin
            GetIT4GDocUtils.SetPosFunctionalityProfile(PosFuncProfile."Profile ID");
            GetIT4GDocUtils.SendRequestGetIT4GDoc(xIT4GDocNo, ResponseCode, ErrorText, BufferUtility);
            if ErrorText <> '' then begin
                if (ResponseCode = '0098') or (ResponseCode = '0099') then
                    if PosFuncProfile."Show Web Process Messages" then
                        Message(ErrorText);
                exit(false);
            end;
            exit(true);
        end;
    end;

    [Scope('OnPrem')]
    procedure SendIt4GDoc(var rIT4GDoc: Record "IT4G-Doc. Header"; var ErrorText: Text): Boolean
    var
        rIT4GDoctemp: Record "IT4G-Doc. Header" temporary;
        SendIT4GDocUtils: Codeunit "IT4G-WS-IT4GUtils";
        ResponseCode: Code[30];
        Ret: Boolean;
        ErrorCode: Text;
        cRepl: codeunit "IT4G Web Repl. Client Handler";
    begin
        Ret := true;

        if not Initialize then
            exit(false);

        if PosFuncProfile."TS Send Transactions" then begin
            rIT4GDoctemp.Init;
            rIT4GDoctemp := rIT4GDoc;
            rIT4GDoctemp.Insert;
            If PosFuncProfile."Use Web Replication" and PosFuncProfile."Use Background Session" then begin
                crepl.SendIT4GDocs(ResponseCode, ErrorText, false, PosFuncProfile.TransUpdateReplCounter, rIT4GDoctemp);
                ret := true;
            end else begin
                SendIT4GDocUtils.SetPosFunctionalityProfile(PosFuncProfile."Profile ID");
                SendIT4GDocUtils.SendRequestSendIT4GDoc(ResponseCode, ErrorText, false, false, rIT4GDoctemp);
                if ErrorText <> '' then begin
                    if PosFuncProfile."Show Web Process Messages" then
                        Message(ErrorText);
                    Ret := false;
                end else
                    Ret := true;
            end;


            if not Ret then
                CPTU.CreateTSRetryEntry(Database::"IT4G-Doc. Header",
                  rIT4GDoc."Document No.", '',
                  '', TSAction_g::Update, 0, false,
                  '', '', 0, '');

            exit(Ret);
        end;
    end;
}