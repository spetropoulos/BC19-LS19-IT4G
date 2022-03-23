tableextension 60009 "TE99001515-POS Func. Profile" extends "LSC POS Func. Profile"
{

    fields
    {
        field(50000; "TS Send IT4GDoc"; Boolean)
        {
            Caption = 'TS Send IT4GDoc';

            trigger OnValidate()
            var
                rPFP: Record "LSC POS Func. Profile";
            begin
                TestField("DD Send Transaction", false);
                ValidatWebServers(100, "Send IT4GDoc", xRec."Send IT4GDoc", ("Send IT4GDoc" <> '') and "TS Send IT4GDoc");
            end;
        }
        field(50001; "Send IT4GDoc"; Code[10])
        {
            Caption = 'Send IT4GDoc';
            TableRelation = "LSC Distribution Location";

            trigger OnValidate()
            var
                rPFP: Record "LSC POS Func. Profile";
            begin
                ValidatWebServers(100, "Send IT4GDoc", xRec."Send IT4GDoc", ("Send IT4GDoc" <> '') and "TS Send IT4GDoc");
            end;
        }
    }
    local procedure ValidatWebServers(pServiceGrId: Integer; DistLocation: Code[10]; xDistLocation: Code[10]; Enable: Boolean)
    var
        WSRequestTemp: Record "LSC POS Func. Profile Web Req." temporary;
        POSFuncProfWebServ: Record "LSC POS Func. Profile Web Serv";
        POSFuncProfWebServEntryNo: Record "LSC POS Func. Profile Web Serv";
        POSFuncProfileWebRequest: Record "LSC POS Func. Profile Web Req.";
        EntryNo: Integer;
        DeleteEntry: Boolean;
    begin
        POSFuncProfileWebRequest.GetWebRequestList("Profile ID", pServiceGrId, WSRequestTemp);
        if Enable then begin
            POSFuncProfWebServEntryNo.Reset();
            POSFuncProfWebServEntryNo.SetRange("Profile ID", "Profile ID");
            if WSRequestTemp.FindSet() then
                repeat
                    if (xDistLocation <> '') and (xDistLocation <> DistLocation) then begin  //Rename Distribution Location
                        POSFuncProfWebServ.Reset();
                        POSFuncProfWebServ.SetRange("Profile ID", "Profile ID");
                        POSFuncProfWebServ.SetRange("Request ID", WSRequestTemp."Request ID");
                        if POSFuncProfWebServ.FindFirst() then begin
                            POSFuncProfWebServ."Dist. Location" := DistLocation;
                            POSFuncProfWebServ.Modify();
                        end;
                    end else begin
                        POSFuncProfWebServEntryNo.SetRange("Request ID");
                        if POSFuncProfWebServEntryNo.FindLast() then
                            EntryNo := POSFuncProfWebServEntryNo."Entry No.";
                        EntryNo += 10000;

                        POSFuncProfWebServ.Reset();
                        POSFuncProfWebServ.SetRange("Profile ID", WSRequestTemp."Profile ID");
                        POSFuncProfWebServ.SetRange("Request ID", WSRequestTemp."Request ID");
                        if POSFuncProfWebServ.IsEmpty then begin
                            POSFuncProfWebServ.Init();
                            POSFuncProfWebServ."Profile ID" := "Profile ID";
                            POSFuncProfWebServ."Request ID" := WSRequestTemp."Request ID";
                            POSFuncProfWebServ."Entry No." := EntryNo;
                            POSFuncProfWebServ."Dist. Location" := DistLocation;
                            POSFuncProfWebServ.Insert();
                        end;
                    end;
                until WSRequestTemp.Next() = 0;
        end
        else begin
            if WSRequestTemp.FindSet() then
                repeat
                    POSFuncProfWebServ.Reset();
                    POSFuncProfWebServ.SetRange("Profile ID", "Profile ID");
                    POSFuncProfWebServ.SetRange("Request ID", WSRequestTemp."Request ID");
                    if POSFuncProfWebServ.FindFirst() then begin
                        if POSFuncProfWebServ."Request ID" = 'SendTransactionHeader' then begin
                            if ("TS Send Transactions" and ("Send Transaction" <> '')) or ("TS Void Transactions" and ("Void Posted Transaction" <> '')) then
                                DeleteEntry := false
                            else
                                DeleteEntry := true;
                            if DeleteEntry then
                                POSFuncProfWebServ.Delete();
                        end else
                            POSFuncProfWebServ.Delete();
                    end;
                until WSRequestTemp.Next() = 0;
        end;
    end;
}