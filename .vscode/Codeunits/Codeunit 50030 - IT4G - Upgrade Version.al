codeunit 50030 "IT4G-Upgrade Version"
{
    var
        rRetailSetUp: record "LSC Retail Setup";
        CurrVersionDate: date;
        LatestVersionDate: Date;
        LatestWSVersionDate: Date;
        cF: Codeunit "IT4G-Functions";
        cPCR: Codeunit "LSC POS Command Registration";

    trigger OnRun()
    begin
        LatestVersionDate := 20220327D;
        LatestWSVersionDate := 20220320D;


        rRetailSetUp.get();

        if cF.GRV_Date('IT4G_Version', 0, 1) = 0D then
            CurrVersionDate := 0D
        else
            CurrVersionDate := cF.GRV_Date('IT4G_Version', 0, 1);

        If CurrVersionDate <> LatestVersionDate then
            if not confirm('Upgrade IT4G Version?') then exit;
        If (CurrVersionDate <> LatestVersionDate) or (LatestWSVersionDate >= CurrVersionDate) then
            ProcessUpgrade();
    end;

    procedure ProcessUpgrade()
    var
        MenuLine: Record "LSC POS Menu Line";
        Text001: Label 'Codeunit %1 does not support Registration Mode';
        Text002: Label 'Codeunit %1 is now registered as a Retail Module';
        dDLG: Dialog;
        dlgTxt: Text;
    begin
        if GuiAllowed then dDLG.Open('Upgrading From #1######### to #2#########\#3#######################', CurrVersionDate, LatestVersionDate, dlgTxt);
        If CurrVersionDate <> LatestVersionDate then begin
            dlgTxt := 'Registering Codeunit 50011 - IT4G POS Commands';
            dDLG.Update;
            commit;
            if not CODEUNIT.Run(50011, MenuLine) then
                Error(Text001 + ' ' + GetLastErrorText, 50011);
            cPCR.SetupModule('IT4G');
            commit;
            dlgTxt := 'Registering Codeunit 50018 - IT4G Scan Document';
            dDLG.Update;
            if not CODEUNIT.Run(50018, MenuLine) then
                Error(Text001 + ' ' + GetLastErrorText, 50018);
            cPCR.SetupModule('IT4GSCAN');
            commit;
        end;

        If LatestWSVersionDate >= CurrVersionDate then begin
            dlgTxt := 'Registering IT4G WEB Services';
            dDLG.Update;
            RegisterWEBRequests;
            UpdatePOSFuncProfileWebReq;
        end;

        CF.SetRV_Date('IT4G_Version', 0, 1, LatestVersionDate);
        if GuiAllowed then dDLG.Close;
        commit;

    end;

    procedure RegisterWEBRequests()
    var
        cWRF: Codeunit "LSC Web Request Functions";
    begin
        clear(cWRF);
        cWRF.InitAllRequests(0);
        cWRF.InitAllRequests(1);
    end;

    procedure UpdatePOSFuncProfileWebReq()
    var
        rPFP: Record "LSC POS Func. Profile";
    begin
        clear(rPFP);
        If rPFP.findset then
            repeat
                rPFP.validate("Send Transaction", rPFP."Send Transaction");
                rPFP.validate("Send IT4GDoc", rPFP."Send IT4GDoc");
            until rPFP.next = 0;
    end;

}
