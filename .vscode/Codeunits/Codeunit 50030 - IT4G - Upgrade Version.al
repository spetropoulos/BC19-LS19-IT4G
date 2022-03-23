codeunit 50030 "IT4G-Upgrade Version"
{
    var
        rRetailSetUp: record "LSC Retail Setup";
        CurrVersionDate: date;
        LatestVersionDate: Date;
        cF: Codeunit "IT4G-Functions";

    trigger OnRun()
    begin
        LatestVersionDate := 20220323D;


        rRetailSetUp.get();

        if cF.GRV_Date('IT4G_Version', 0, 1) = 0D then
            CurrVersionDate := 0D
        else
            CurrVersionDate := cF.GRV_Date('IT4G_Version', 0, 1);

        If CurrVersionDate <> LatestVersionDate then
            if not confirm('Upgrade IT4G Version?') then exit;

        ProcessUpgrade();
    end;

    procedure ProcessUpgrade()
    begin
        If CurrVersionDate <> LatestVersionDate then begin
            RegisterWEBRequests;
            UpdatePOSFuncProfileWebReq;
        end;
        CF.SetRV_Date('IT4G_Version', 0, 1, LatestVersionDate);

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
