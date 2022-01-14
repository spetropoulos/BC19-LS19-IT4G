codeunit 50014 "IT4G-POS Input Popup"
{
    SingleInstance = true;
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    begin
        if Command = 'CUSTOM' then begin
            Processed := true;
            Commit;
            case Parameter of
                //Panel #MEMBERCONTACT - #MCONTACTMENU
                'PANELOK':
                    ClosePanel(Parameter);
                'LINKTOACCOUNT':
                    LinkToAccount;
                'SELECTCLUB':
                    SelectClub;
                'SAVE':
                    SaveMemberContact;
                'BLOCK':
                    BlockContact;
                'UNBLOCK':
                    UnBlockContact;
                //Panel #MEMBERCONTACT - #MCONTACTMENU2
                'MEMBERCONTACTLOOKUP':
                    SelectMemberContact;
                'CARDS':
                    LookupMemberContactCards;
                'NEWCARD':
                    NewMemberCard;
                'SCANNEWCARD':
                    ScanNewMemberCard(false);
                'CREATENEWCARD':
                    ScanNewMemberCard(true);
                //Menu ID = #MCARDLOOKUP
                'BLOCKCARD':
                    BlockCard;
                'UNBLOCKCARD':
                    UnBlockCard;
                'CLEAR':
                    ClearPanelData;
                'CUSTOMER_ORDER_LIST':
                    OrdersToCollect;
                'CANCEL':
                    ;
                else
                    Processed := false
            end;
            SetInfo(false);
        end;
    end;

    var
        FuncProfile_g: Record "LSC POS Func. Profile";
        MemberContactTEMP_g: Record "LSC Member Contact" temporary;
        MemberCardTEMP_g: Record "LSC Membership Card" temporary;
        MemberClubTEMP_g: Record "LSC Member Club" temporary;
        BasicInfoMemberContactTEMP_g: Record "LSC Member Contact" temporary;
        RecRef_g: RecordRef;
        PosGui_g: Codeunit "LSC POS GUI";
        PosContext_g: Codeunit "LSC POS Context";
        PosCtrl_g: Codeunit "LSC POS Control Interface";
        PosSession_g: Codeunit "LSC POS Session";
        PosMemberMgt_g: Codeunit "LSC POS Member Mgt.";
        WebServicesClient_g: Codeunit "LSC Web Services Client";
        NewRecord_g: Boolean;
        Text001: Label 'POS Lookup ''%1'' not found.';
        Text008: Label 'No Member Contact selected';
        Text013: Label 'Contact is not blocked';
        Text016: Label 'Do you want to assign card %1 to contact?';
        Text017: Label 'Member Card No.';
        Text018: Label 'The Membership Card Number is too long (>%1).';
        ContactPanelID: code[20];
        ContactRecZoomCtrlID_g: Code[20];
        ContactDataTableID_g: Code[20];
        xRecAccountNo_g: Code[20];
        xRecContactNo_g: Code[20];
        Text025: Label '%1 cannot be changed. The number will be reverted.';
        BlockUnblock_g: Boolean;
        CloseCommand_g: Code[20];
        MemberAccountTEMP_WS: Record "LSC Member Account" temporary;
        MemberClubTEMP_WS: Record "LSC Member Club" temporary;
        MemberContactTEMP_WS: Record "LSC Member Contact" temporary;
        MemberCardTEMP_WS: Record "LSC Membership Card" temporary;
        FlowFieldBufferTEMP_WS: Record "LSC FlowField Buffer" temporary;
        ReasonCodeTEMP_WS: Record "Reason Code" temporary;
        ReasonCodeLookupType_g: Code[10];
        BlockCardNo_g: Text;
        Payload_g: Text[1024];

    local procedure LinkToAccount()
    var
        Lookup_l: Record "LSC POS Lookup";
        RecRef_l: RecordRef;
        TmpPOSTrLine_l: Record "LSC POS Trans. Line" temporary;
        lPosGUI: Codeunit "LSC POS GUI";
        FormId_l: Code[20];
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        FlowFieldBufferTEMP_l: Record "LSC FlowField Buffer" temporary;
        Process_Error_l: Boolean;
        Error_Text_l: Text;
    begin
        FormId_l := '#MACCOUNT';
        if not PosSession_g.GetPosLookupRec(FormId_l, Lookup_l) then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text001, FormId_l));
            exit;
        end;

        MemberAccountTEMP_WS.Reset;
        MemberAccountTEMP_WS.DeleteAll;
        RecRef_l.GetTable(MemberAccountTEMP_WS);
        GetFieldsFromDataTable(FormId_l, Database::"LSC Member Account", FieldBufferTEMP_l);
        if not WebServicesClient_g.GetTableData(MemberAccountTEMP_WS.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_l, FlowFieldBufferTEMP_l, Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;

        lPosGUI.LookupEx(Lookup_l, '', TmpPOSTrLine_l, PosSession_g.MgrKey, '', RecRef_l, FlowFieldBufferTEMP_l);
    end;

    local procedure SelectClub()
    var
        Lookup_l: Record "LSC POS Lookup";
        TmpPOSTrLine_l: Record "LSC POS Trans. Line" temporary;
        RecRef_l: RecordRef;
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        FlowFieldBufferTEMP_l: Record "LSC FlowField Buffer" temporary;
        FormId_l: Code[20];
        Process_Error_l: Boolean;
        Error_Text_l: Text;
    begin
        FormId_l := '#MCLUB';
        if not PosSession_g.GetPosLookupRec(FormId_l, Lookup_l) then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text001, FormId_l));
            exit;
        end;
        MemberClubTEMP_WS.Reset;
        MemberClubTEMP_WS.DeleteAll;
        RecRef_l.GetTable(MemberClubTEMP_WS);
        FilterBufferTEMP_l.InsertFilterBuffer(5, 'Card Registration', 'Link to Contact');
        GetFieldsFromDataTable(FormId_l, Database::"LSC Member Club", FieldBufferTEMP_l);
        if not WebServicesClient_g.GetTableData(MemberClubTEMP_WS.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_l, FlowFieldBufferTEMP_l, Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;

        PosGui_g.LookupEx(Lookup_l, '', TmpPOSTrLine_l, PosSession_g.MgrKey, '', RecRef_l, FlowFieldBufferTEMP_l);
    end;

    local procedure SelectMemberContact()
    var
        Lookup_l: Record "LSC POS Lookup";
        TmpPOSTrLine_l: Record "LSC POS Trans. Line" temporary;
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        FormID_l: Code[20];
        RecRef_l: RecordRef;
        Process_Error_l: Boolean;
        Error_Text_l: Text;
        Text002: Label 'Enter search criteria.';
    begin
        FormID_l := '#MCONTACT';
        if not PosSession_g.GetPosLookupRec(FormID_l, Lookup_l) then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text001, FormID_l));
            exit;
        end;

        PosCtrl_g.GetRecordZoomData(RecRef_g, ContactRecZoomCtrlID_g);
        RecRef_g.SetTable(MemberContactTEMP_g);

        MemberContactTEMP_WS.Reset;
        MemberContactTEMP_WS.DeleteAll;
        RecRef_l.GetTable(MemberContactTEMP_WS);

        FlowFieldBufferTEMP_WS.Reset;
        FlowFieldBufferTEMP_WS.DeleteAll;

        FilterBufferTEMP_l.Reset;
        FilterBufferTEMP_l.DeleteAll;

        if MemberContactTEMP_g."Account No." <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(1, 'Account No.', MemberContactTEMP_g."Account No.");
        if MemberContactTEMP_g."Contact No." <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(5, 'Contact No.', MemberContactTEMP_g."Contact No.");
        if MemberContactTEMP_g."E-Mail" <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(18, 'E-Mail', '@*' + ConvertStr(MemberContactTEMP_g."E-Mail", '@', '?') + '*');
        if MemberContactTEMP_g.Name <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(10, 'Name', '@*' + MemberContactTEMP_g.Name + '*');
        if MemberContactTEMP_g.Gender = MemberContactTEMP_g.Gender::Male then
            FilterBufferTEMP_l.InsertFilterBuffer(30, 'Gender', 'Male');
        if MemberContactTEMP_g.Gender = MemberContactTEMP_g.Gender::Female then
            FilterBufferTEMP_l.InsertFilterBuffer(30, 'Gender', 'Female');
        if MemberContactTEMP_g."Phone No." <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(20, 'Phone No.', '@*' + MemberContactTEMP_g."Phone No." + '*');
        if MemberContactTEMP_g."Mobile Phone No." <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(21, 'Mobile Phone No.', '@*' + MemberContactTEMP_g."Mobile Phone No." + '*');
        if MemberContactTEMP_g.Address <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(13, 'Address', '@*' + MemberContactTEMP_g.Address + '*');
        if MemberContactTEMP_g."Address 2" <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(14, 'Address 2', '@*' + MemberContactTEMP_g."Address 2" + '*');
        if MemberContactTEMP_g.City <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(15, 'City', '@*' + MemberContactTEMP_g.City + '*');
        if MemberContactTEMP_g."Post Code" <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(17, 'Post Code', '@*' + MemberContactTEMP_g."Post Code" + '*');

        if FilterBufferTEMP_l.Count = 0 then begin
            PosCtrl_g.PosMessage(Text002);
            exit;
        end;

        GetFieldsFromDataTable(FormID_l, Database::"LSC Member Contact", FieldBufferTEMP_l);

        if not WebServicesClient_g.GetTableData(MemberContactTEMP_WS.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_l, FlowFieldBufferTEMP_WS, Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;
        if RecRef_l.Count = 1 then begin
            FlowFieldBufferTEMP_WS.GetFlowFields(FlowFieldBufferTEMP_WS, RecRef_l);
            RecRef_l.SetTable(MemberContactTEMP_g);
            SetNewRecord(false);
            LoadPanelData;
        end else begin
            PosGui_g.LookupEx(Lookup_l, '', TmpPOSTrLine_l, PosSession_g.MgrKey, '', RecRef_l, FlowFieldBufferTEMP_WS);
        end;
    end;

    local procedure SaveMemberContact()
    var
        ContactCreateParametersTemp: Record "LSC Contact Create Parameters" temporary;
        MemberAttributeValueTemp: Record "LSC Member Attribute Value" temporary;
        ErrorText: Text;
        ErrorRaised: Boolean;
        Text003: Label 'Club Code is missing - Press New button to create a Contact';
    begin
        Commit;
        PosCtrl_g.GetRecordZoomData(RecRef_g, ContactRecZoomCtrlID_g);
        RecRef_g.SetTable(MemberContactTEMP_g);

        Clear(ContactCreateParametersTemp);
        ContactToParameters(MemberContactTEMP_g, ContactCreateParametersTemp);

        if NewRecord_g then begin
            if MemberContactTEMP_g."Club Code" = '' then begin
                PosCtrl_g.PosMessage(Text003);
                exit;
            end;
            if not PosMemberMgt_g.ContactCreate(ContactCreateParametersTemp, MemberAttributeValueTemp, ErrorText) then begin
                PosCtrl_g.PosMessage(ErrorText);
                exit;
            end;
            MemberContactTEMP_g."Account No." := ContactCreateParametersTemp.AccountID;
            MemberContactTEMP_g."Contact No." := ContactCreateParametersTemp.ContactID;
            if not LoadMemberContact(MemberContactTEMP_g, '') then
                exit;
        end else begin
            if xRecAccountNo_g <> ContactCreateParametersTemp.AccountID then begin
                PosCtrl_g.PosMessage(StrSubstNo(Text025, MemberContactTEMP_g.FieldCaption("Account No.")));
                MemberContactTEMP_g."Account No." := xRecAccountNo_g;
                ErrorRaised := true;
            end;
            if xRecContactNo_g <> ContactCreateParametersTemp.ContactID then begin
                PosCtrl_g.PosMessage(StrSubstNo(Text025, MemberContactTEMP_g.FieldCaption("Contact No.")));
                MemberContactTEMP_g."Contact No." := xRecContactNo_g;
                ErrorRaised := true;
            end;
            if not ErrorRaised then
                if not PosMemberMgt_g.ContactUpdate(ContactCreateParametersTemp, MemberAttributeValueTemp, ErrorText) then begin
                    PosCtrl_g.PosMessage(ErrorText);
                    exit;
                end;
        end;
        SetNewRecord(false);
        ShowContactRec;
        Commit;
    end;

    local procedure ReasonCodeLookup(Type_p: Code[10]): Code[30]
    var
        Lookup_l: Record "LSC POS Lookup";
        TmpPOSTrLine_l: Record "LSC POS Trans. Line" temporary;
        PosGUI_l: Codeunit "LSC POS GUI";
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        FlowFieldBufferTEMP_l: Record "LSC FlowField Buffer" temporary;
        RecRef_l: RecordRef;
        FormID_l: Code[20];
        Process_Error_l: Boolean;
        Error_Text_l: Text;
    begin
        FormID_l := '#REASONCODE';
        if not PosSession_g.GetPosLookupRec(FormID_l, Lookup_l) then
            Error(Text001, FormID_l);

        ReasonCodeTEMP_WS.Reset;
        ReasonCodeTEMP_WS.DeleteAll;
        RecRef_l.GetTable(ReasonCodeTEMP_WS);

        if Type_p <> '' then
            FilterBufferTEMP_l.InsertFilterBuffer(10000700, 'Group', Type_p);

        GetFieldsFromDataTable(FormID_l, Database::"Reason Code", FieldBufferTEMP_l);

        if not WebServicesClient_g.GetTableData(ReasonCodeTEMP_WS.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_l, FlowFieldBufferTEMP_l, Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;

        ReasonCodeLookupType_g := Type_p;

        PosGUI_l.LookupEx(Lookup_l, '', TmpPOSTrLine_l, PosSession_g.MgrKey, '', RecRef_l, FlowFieldBufferTEMP_l);
        exit('');
    end;

    local procedure LookupMemberContactCards()
    var
        Lookup_l: Record "LSC POS Lookup";
        TmpPOSTrLine_l: Record "LSC POS Trans. Line" temporary;
        PosGUI_l: Codeunit "LSC POS GUI";
        FormID_l: Code[20];
        RecRef_l: RecordRef;
        FlowFieldBufferTEMP_l: Record "LSC FlowField Buffer" temporary;
        Error_Text_l: Text;
    begin
        FormID_l := '#MCARD';
        if not PosSession_g.GetPosLookupRec(FormID_l, Lookup_l) then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text001, FormID_l));
            exit;
        end;
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;
        SaveMemberContact;
        PosCtrl_g.GetRecordZoomData(RecRef_g, ContactRecZoomCtrlID_g);
        RecRef_g.SetTable(MemberContactTEMP_g);
        if not GetMemberCardData(FormID_l, RecRef_l, FlowFieldBufferTEMP_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;

        BlockUnblock_g := false;
        PosGUI_l.LookupEx(Lookup_l, '', TmpPOSTrLine_l, PosSession_g.MgrKey, '', RecRef_l, FlowFieldBufferTEMP_l);
    end;

    [Scope('OnPrem')]
    procedure ShowPanel(var MemberCardNo_p: Text; Payload: Text[1024]): Code[20]
    var
        result: Boolean;
    begin
        ShowSpecificMemberPanel(MemberCardNo_p, PosSession_g.MemberContactPanelID, '#MCONTACTZOOM', '#MCONTACTEDIT', Payload);
    end;

    [Scope('OnPrem')]
    procedure ShowSpecificMemberPanel(var MemberCardNo: Text;
        MemberPanelID: code[20]; MemberZoomControlID: code[20]; MemberDataTableID: code[20]; Payload: Text)
    begin
        //Panel must have this codeunit as panel codeunit
        Payload_g := Payload;
        ContactRecZoomCtrlID_g := MemberZoomControlID;
        ContactDataTableID_g := MemberDataTableID;
        ContactPanelID := MemberPanelID;

        PosContext_g.Create('MEMBER');
        FuncProfile_g.Get(PosSession_g.FunctionalityProfileID);
        WebServicesClient_g.SetPosFuncProfile(FuncProfile_g);
        ClearPanelData;
        if MemberCardNo <> '' then begin
            if LoadMemberContact(MemberContactTEMP_g, MemberCardNo) then begin
                ShowContactRec;
                SetNewRecord(false);
            end;
        end else
            if GetBasicMemberInfoForNewMember() then
                ShowContactRec();
        SetInfo(true);
        CloseCommand_g := '';
        PosCtrl_g.ShowPanelModal(ContactPanelID);
    end;

    [Scope('OnPrem')]
    procedure PanelClosed(var MemberCardNo_p: Text; pResult: Boolean): Code[20]
    begin
        if pResult then begin
            MemberCardNo_p := MemberCardTEMP_g."Card No.";
            PosCtrl_g.DeleteDataByTag('MEMBER');
            exit(CloseCommand_g);
        end;
        PosCtrl_g.DeleteDataByTag('MEMBER');
        exit(CloseCommand_g);
    end;

    local procedure SetInfo(SendContext_p: Boolean)
    var
        Info1_l: Text;
        Info2_l: Text;
        Text020: Label ' - BLOCKED';
        NoValidCard: Label 'No Valid Card was found for Contact';
    begin
        Info1_l := MemberContactTEMP_g.Name;
        if Info1_l <> '' then
            if MemberContactTEMP_g.Blocked then
                Info1_l := Info1_l + Text020;
        if MemberCardTEMP_g."Card No." <> '' then begin
            Info2_l := MemberCardTEMP_g."Card No." + ' - ' + Format(MemberCardTEMP_g.Status);
        end;

        if (Info1_l <> '') and
          (MemberCardTEMP_g."Card No." = '')
        then
            Info2_l := NoValidCard;
        PosContext_g.SetKeyValue('<#INFO1>', Info1_l);
        PosContext_g.SetKeyValue('<#INFO2>', Info2_l);

        if SendContext_p then
            PosCtrl_g.SendContext(PosContext_g)
        else
            PosCtrl_g.AddContext(PosContext_g);
    end;

    local procedure NewMemberCard(): Text
    var
        Lookup_l: Record "LSC POS Lookup";
        TmpPOSTrLine_l: Record "LSC POS Trans. Line" temporary;
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        PosGUI_l: Codeunit "LSC POS GUI";
        FormID_l: Code[20];
        RecRef_l: RecordRef;
        Error_Text_l: Text;
        Process_Error_l: Boolean;
    begin
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;
        FormID_l := '#MFREECARD';
        if not PosSession_g.GetPosLookupRec(FormID_l, Lookup_l) then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text001, FormID_l));
            exit;
        end;

        SaveMemberContact;
        PosCtrl_g.GetRecordZoomData(RecRef_g, ContactRecZoomCtrlID_g);
        RecRef_g.SetTable(MemberContactTEMP_g);
        MemberCardTEMP_WS.Reset;
        MemberCardTEMP_WS.DeleteAll;
        RecRef_l.GetTable(MemberCardTEMP_WS);

        FlowFieldBufferTEMP_WS.Reset;
        FlowFieldBufferTEMP_WS.DeleteAll;

        FilterBufferTEMP_l.InsertFilterBuffer(3, 'Linked to Account', 'FALSE');
        FilterBufferTEMP_l.InsertFilterBuffer(5, 'Club Code', MemberContactTEMP_g."Club Code");

        GetFieldsFromDataTable(FormID_l, Database::"LSC Membership Card", FieldBufferTEMP_l);

        if not WebServicesClient_g.GetTableData(MemberCardTEMP_WS.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_l, FlowFieldBufferTEMP_WS, Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;
        PosGUI_l.LookupEx(Lookup_l, '', TmpPOSTrLine_l, PosSession_g.MgrKey, '', RecRef_l, FlowFieldBufferTEMP_WS);
    end;

    local procedure ScanNewMemberCard(pCreateNewCard: Boolean)
    begin
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;
        SaveMemberContact;
        PosCtrl_g.GetRecordZoomData(RecRef_g, ContactRecZoomCtrlID_g);
        RecRef_g.SetTable(MemberContactTEMP_g);

        if pCreateNewCard then
            PosGui_g.OpenAlphabeticKeyboard(Text017, '', false, '#MEMBERCARD-CREATE', MaxStrLen(MemberCardTEMP_g."Card No."))
        else
            PosGui_g.OpenAlphabeticKeyboard(Text017, '', false, '#MEMBERCARD-ADD', MaxStrLen(MemberCardTEMP_g."Card No."));
    end;

    local procedure AssignMemberCard(pCardNo: Text)
    var
        MSRDevice: Record "LSC POS MSR";
        Process_Error_l: Boolean;
        Error_Text_l: Text;
        deviceID: Code[20];
    begin
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;

        deviceID := POSSession_g.GetHardwareProfileDevice("LSC Hardware Profile Devices"::MSR);
        if MSRDevice.Get(deviceID) then begin
            if MSRDevice."Use Non-Payment Track Handling" then
                pCardNo := MSRDevice.EditNonPaymentTrack(CopyStr(pCardNo, 1, 250));
        end;

        if pCardNo = '' then
            exit;

        if StrLen(pCardNo) > MaxStrLen(MemberCardTEMP_g."Card No.") then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text018, MaxStrLen(MemberCardTEMP_g."Card No.")));
            exit;
        end;

        if PosCtrl_g.PosConfirm(StrSubstNo(Text016, pCardNo), true) then begin
            if not PosMemberMgt_g.CardToContact(MemberContactTEMP_g."Account No.", MemberContactTEMP_g."Contact No.", pCardNo, Process_Error_l, Error_Text_l) then begin
                PosCtrl_g.PosMessage(Error_Text_l);
                exit;
            end;
            MemberCardTEMP_g."Card No." := pCardNo;
            if not LoadMemberCard(MemberCardTEMP_g) then
                exit;
        end;
    end;

    local procedure CreateAndAssignMemberCard(pCardNo: Text)
    var
        Error_Text_l: Text;
        DoYouWantToCreateANewCardAndAssignItToContact: Label 'Do you want to create a new card %1 and assign it to contact?';
        MSRDevice: Record "LSC POS MSR";
        deviceID: Code[20];
    begin
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;

        deviceID := POSSession_g.GetHardwareProfileDevice("LSC Hardware Profile Devices"::MSR);
        if MSRDevice.Get(deviceID) then begin
            if MSRDevice."Use Non-Payment Track Handling" then
                pCardNo := MSRDevice.EditNonPaymentTrack(CopyStr(pCardNo, 1, 250));
        end;

        if pCardNo = '' then
            exit;

        if StrLen(pCardNo) > MaxStrLen(MemberCardTEMP_g."Card No.") then begin
            PosCtrl_g.PosMessage(StrSubstNo(Text018, MaxStrLen(MemberCardTEMP_g."Card No.")));
            exit;
        end;
        if PosCtrl_g.PosConfirm(StrSubstNo(DoYouWantToCreateANewCardAndAssignItToContact, pCardNo), true) then begin
            if not PosMemberMgt_g.CreateNewCardForContact(MemberContactTEMP_g, pCardNo, Error_Text_l) then begin
                PosCtrl_g.PosMessage(Error_Text_l);
                exit;
            end;
            MemberCardTEMP_g."Card No." := pCardNo;
            if not LoadMemberCard(MemberCardTEMP_g) then
                exit;
        end;
    end;

    local procedure BlockContact()
    var
        Text011: Label 'Contact is blocked';
    begin
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;
        SaveMemberContact;
        if MemberContactTEMP_g.Blocked then begin
            PosCtrl_g.PosMessage(Text011);
            exit;
        end;
        MemberClubTEMP_g.TestField("Reason Codes Contacts");
        ReasonCodeLookup(MemberClubTEMP_g."Reason Codes Contacts");
    end;

    local procedure UnBlockContact()
    var
        Error_Text_l: Text;
        Process_Error_l: Boolean;
    begin
        Commit;
        if NewRecord_g then begin
            PosCtrl_g.PosMessage(Text008);
            exit;
        end;
        SaveMemberContact;
        if not MemberContactTEMP_g.Blocked then begin
            PosCtrl_g.PosMessage(Text013);
            exit;
        end;
        if not PosMemberMgt_g.ContactBlock(MemberContactTEMP_g."Account No.", MemberContactTEMP_g."Contact No.", '', 'No', Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;
        LoadPanelData;
    end;

    local procedure BlockCard()
    var
        MemberCardTEMP_l: Record "LSC Membership Card" temporary;
        Text014: Label 'Card is blocked';
    begin
        MemberCardTEMP_l."Card No." := GetActiveCardNo;
        if MemberCardTEMP_l."Card No." = '' then
            exit;
        if not LoadMemberCard(MemberCardTEMP_l) then
            exit;
        if MemberCardTEMP_l.Status = MemberCardTEMP_l.Status::Blocked then begin
            PosCtrl_g.PosMessage(Text014);
            exit;
        end;

        MemberClubTEMP_g.TestField("Reason Codes Cards");
        BlockCardNo_g := MemberCardTEMP_l."Card No.";
        ReasonCodeLookup(MemberClubTEMP_g."Reason Codes Cards");
    end;

    local procedure UnBlockCard()
    var
        MemberCardTEMP_l: Record "LSC Membership Card" temporary;
        Error_Text_l: Text;
        Process_Error_l: Boolean;
    begin
        MemberCardTEMP_l."Card No." := GetActiveCardNo;
        if MemberCardTEMP_l."Card No." = '' then
            exit;
        if not LoadMemberCard(MemberCardTEMP_l) then
            exit;
        if MemberCardTEMP_l.Status <> MemberCardTEMP_l.Status::Blocked then begin
            PosCtrl_g.PosMessage(Text013);
            exit;
        end;
        if not PosMemberMgt_g.CardBlock(MemberCardTEMP_l."Card No.", '', 'No', Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit;
        end;

        MemberCardTEMP_g."Card No." := MemberCardTEMP_l."Card No.";
        LoadMemberCard(MemberCardTEMP_g);
        BlockUnblock_g := true;

        RefreshActiveLookup();
    end;

    local procedure GetActiveCardNo(): Text
    var
        RecID_l: RecordID;
    begin
        if PosCtrl_g.GetActiveLookupRecordID(RecID_l) then
            exit(CopyStr(Format(RecID_l), 18)); //'Membership Card: <key>'
        exit('');
    end;

    local procedure ClosePanel(pCloseCommand: Code[20])
    var
        ConfirmCloseWithNoCard: Label '%1 %2 does not have a valid card. Are you sure you want to close the panel?';
    begin
        if (MemberCardTEMP_g."Card No." = '') and (MemberContactTEMP_g.Name <> '') then
            if not PosCtrl_g.PosConfirm(StrSubstNo(ConfirmCloseWithNoCard, MemberContactTEMP_g.TableCaption, MemberContactTEMP_g.name), false) then
                exit;
        CloseCommand_g := pCloseCommand;
        if MemberContactTEMP_g."Club Code" <> '' then
            SaveMemberContact;
        PanelClose(MemberContactTEMP_g, MemberCardTEMP_g, Payload_g);
        PosCtrl_g.HidePanel(ContactPanelID, true);
    end;

    local procedure ContactToParameters(var MemberContact_p: Record "LSC Member Contact"; var ContactCreateParametersTemp: Record "LSC Contact Create Parameters" temporary)
    begin
        ContactCreateParametersTemp.Init;
        ContactCreateParametersTemp.Email := MemberContact_p."E-Mail";
        MemberContact_p.Validate(Name);
        ContactCreateParametersTemp.FirstName := MemberContact_p."First Name";
        ContactCreateParametersTemp.LastName := MemberContact_p.Surname;
        ContactCreateParametersTemp.MiddleName := MemberContact_p."Middle Name";
        ContactCreateParametersTemp.Gender := MemberContact_p.Gender;
        ContactCreateParametersTemp.Phone := MemberContact_p."Phone No.";
        ContactCreateParametersTemp.MobilePhoneNo := MemberContact_p."Mobile Phone No.";
        ContactCreateParametersTemp.Address1 := MemberContact_p.Address;
        ContactCreateParametersTemp.Address2 := MemberContact_p."Address 2";
        ContactCreateParametersTemp.City := MemberContact_p.City;
        ContactCreateParametersTemp.PostCode := MemberContact_p."Post Code";
        ContactCreateParametersTemp.Country := MemberContact_p."Country/Region Code";
        ContactCreateParametersTemp.ClubID := MemberContact_p."Club Code";
        ContactCreateParametersTemp.SchemeID := MemberContact_p."Scheme Code";
        ContactCreateParametersTemp.AccountID := MemberContact_p."Account No.";
        ContactCreateParametersTemp.ContactID := MemberContact_p."Contact No.";
        ContactCreateParametersTemp.DateOfBirth := MemberContact_p."Date of Birth";
        ContactCreateParametersTemp.HouseApartmentNo := MemberContact_p."House/Apartment No.";
        ContactCreateParametersTemp."Territory Code" := MemberContact_p."Territory Code";
        ContactCreateParametersTemp.StateProvinceRegion := MemberContact_p.County;
        OnBeforeContactCreateParametersInsert(MemberContact_p, ContactCreateParametersTemp);
        ContactCreateParametersTemp.Insert;
    end;

    local procedure LoadMemberContact(var MemberContactTEMP_p: Record "LSC Member Contact" temporary; CardNo_p: Text): Boolean
    var
        Error_Text_l: Text;
        GetMemberContactUtils: Codeunit LSCGetMemberContactUtils;
        ResponseCode: Code[30];
    begin
        GetMemberContactUtils.SetPosFunctionalityProfile(PosSession_g.FunctionalityProfileID);
        GetMemberContactUtils.SendRequest(CardNo_p, MemberContactTEMP_p."Account No.", MemberContactTEMP_g."Contact No.", '', '', MemberCardTEMP_g,
          MemberContactTEMP_g, MemberClubTEMP_g, ResponseCode, Error_Text_l);
        if ResponseCode <> '0000'
        then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit(false);
        end;
        exit(true);
    end;

    local procedure LoadMemberCard(var MemberCardTEMP_p: Record "LSC Membership Card" temporary): Boolean
    var
        MemberCardTEMP_l: Record "LSC Membership Card" temporary;
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        FlowFieldBufferTEMP_l: Record "LSC FlowField Buffer" temporary;
        RecRef_l: RecordRef;
        Process_Error_l: Boolean;
        Error_Text_l: Text;
        Text024: Label '%1 not found.';
    begin
        MemberCardTEMP_l.Reset;
        MemberCardTEMP_l.DeleteAll;
        RecRef_l.GetTable(MemberCardTEMP_l);

        FilterBufferTEMP_l.InsertFilterBuffer(1, 'Card No.', MemberCardTEMP_p."Card No.");

        if not WebServicesClient_g.GetTableData(MemberCardTEMP_l.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_l, FlowFieldBufferTEMP_l, Process_Error_l, Error_Text_l) then begin
            PosCtrl_g.PosMessage(Error_Text_l);
            exit(false);
        end;

        if MemberCardTEMP_l.Get(MemberCardTEMP_p."Card No.") then begin
            FlowFieldBufferTEMP_l.GetFlowFields(FlowFieldBufferTEMP_l, RecRef_l);
            RecRef_l.SetTable(MemberCardTEMP_l);
            MemberCardTEMP_p := MemberCardTEMP_l;
            exit(true);
        end else begin
            PosCtrl_g.PosMessage(StrSubstNo(Text024, MemberCardTEMP_l.TableCaption));
            exit(false);
        end;
    end;

    local procedure SetNewRecord(NewRecord_p: Boolean)
    begin
        NewRecord_g := NewRecord_p;
        if NewRecord_p then begin
            xRecAccountNo_g := '';
            xRecContactNo_g := '';
        end else begin
            xRecAccountNo_g := MemberContactTEMP_g."Account No.";
            xRecContactNo_g := MemberContactTEMP_g."Contact No.";
        end;
    end;

    local procedure GetFieldsFromDataTable(DataTableID_p: Code[20]; TableNo_p: Integer; var FieldBufferTEMP_p: Record "LSC WS Table Field Buffer" temporary)
    var
        POSDataTableColumns_l: Record "LSC POS Data Table Columns";
        Field_l: Record "Field";
    begin
        POSDataTableColumns_l.SetRange("Data Table ID", DataTableID_p);
        POSDataTableColumns_l.SetRange("Table No.", TableNo_p);
        if POSDataTableColumns_l.FindSet then
            repeat
                Field_l.Get(POSDataTableColumns_l."Table No.", POSDataTableColumns_l."Field No.");
                FieldBufferTEMP_p.InsertFieldBuffer(Field_l."No.", Field_l.FieldName);
            until POSDataTableColumns_l.Next = 0;
    end;

    local procedure ClearPanelData()
    begin
        Clear(MemberContactTEMP_g);
        Clear(MemberCardTEMP_g);
        Clear(MemberClubTEMP_g);
        SetNewRecord(true);
        ShowContactRec;
    end;

    local procedure LoadPanelData()
    begin
        if not LoadMemberContact(MemberContactTEMP_g, MemberCardTEMP_g."Card No.") then
            exit;
        ShowContactRec;
    end;

    local procedure ShowContactRec()
    begin
        RecRef_g.GetTable(MemberContactTEMP_g);
        PosCtrl_g.ShowRecordZoom(RecRef_g, ContactRecZoomCtrlID_g, ContactDataTableID_g, true);
        SetInfo(false);
    end;

    local procedure OrdersToCollect()
    var
        Text027: Label 'Member card  is missing';
    begin
        //OrdersToCollect

        if MemberCardTEMP_g."Card No." = '' then begin
            PosCtrl_g.PosMessage(Text027);
            exit;
        end;

        ClosePanel('CUSTOMER_ORDER_LIST');
    end;

    [Scope('OnPrem')]
    procedure ProcessLookupResult(pFormID: Text): Boolean
    var
        RecRef_l: RecordRef;
        RecID_l: RecordID;
        FldRef_l: FieldRef;
        ReasonCode_l: Code[30];
        Error_Text_l: Text;
        Process_Error_l: Boolean;
        Text012: Label 'Reason Code must be selected';
    begin
        if not PosCtrl_g.GetLookupActiveRecordID(pFormID, RecID_l) then //GetActiveLookupRecordID(RecID_l) THEN
            exit;

        if pFormID = '#MACCOUNT' then begin
            if not NewRecord_g then
                ClearPanelData;

            RecRef_l.GetTable(MemberAccountTEMP_WS);
            if not RecRef_l.Get(RecID_l) then
                exit;

            FldRef_l := RecRef_l.Field(20);
            MemberContactTEMP_g."Club Code" := FldRef_l.Value;
            FldRef_l := RecRef_l.Field(21);
            MemberContactTEMP_g."Scheme Code" := FldRef_l.Value;
            FldRef_l := RecRef_l.Field(1);
            MemberContactTEMP_g."Account No." := FldRef_l.Value;
            ShowContactRec;
            exit;
        end
        else
            if pFormID = '#MCLUB' then begin
                if not NewRecord_g then
                    ClearPanelData;

                RecRef_l.GetTable(MemberClubTEMP_WS);
                if not RecRef_l.Get(RecID_l) then
                    exit;

                FldRef_l := RecRef_l.Field(1);
                MemberContactTEMP_g."Club Code" := FldRef_l.Value;
                FldRef_l := RecRef_l.Field(10);
                MemberContactTEMP_g."Scheme Code" := FldRef_l.Value;
                ShowContactRec;
                exit;
            end
            else
                if pFormID = '#MCONTACT' then begin
                    RecRef_l.GetTable(MemberContactTEMP_WS);
                    if not RecRef_l.Get(RecID_l) then
                        exit;
                    FlowFieldBufferTEMP_WS.GetFlowFields(FlowFieldBufferTEMP_WS, RecRef_l);
                    RecRef_l.SetTable(MemberContactTEMP_g);
                    SetNewRecord(false);
                    LoadPanelData;
                    exit;
                end
                else
                    if pFormID = '#MCARD' then begin
                        RecRef_l.GetTable(MemberCardTEMP_WS);
                        if not RecRef_l.Get(RecID_l) then
                            exit;
                        FlowFieldBufferTEMP_WS.GetFlowFields(FlowFieldBufferTEMP_WS, RecRef_l);
                        if BlockUnblock_g then
                            exit;

                        RecRef_l.SetTable(MemberCardTEMP_g);
                        SetInfo(false);
                        exit;
                    end
                    else
                        if pFormID = '#MFREECARD' then begin
                            RecRef_l.GetTable(MemberCardTEMP_WS);
                            if not RecRef_l.Get(RecID_l) then
                                exit;
                            FlowFieldBufferTEMP_WS.GetFlowFields(FlowFieldBufferTEMP_WS, RecRef_l);
                            RecRef_l.SetTable(MemberCardTEMP_WS);
                            if PosCtrl_g.PosConfirm(StrSubstNo(Text016, MemberCardTEMP_WS."Card No."), true) then begin
                                if not PosMemberMgt_g.CardToContact(MemberContactTEMP_g."Account No.", MemberContactTEMP_g."Contact No.", MemberCardTEMP_WS."Card No.", Process_Error_l, Error_Text_l) then begin
                                    PosCtrl_g.PosMessage(Error_Text_l);
                                    exit;
                                end;

                                MemberCardTEMP_g."Card No." := MemberCardTEMP_WS."Card No.";
                                LoadMemberCard(MemberCardTEMP_g);
                                SetInfo(false);
                            end;
                            exit;
                        end
                        else
                            if pFormID = '#REASONCODE' then begin
                                RecRef_l.GetTable(ReasonCodeTEMP_WS);
                                if not RecRef_l.Get(RecID_l) then
                                    exit;

                                RecRef_l.SetTable(ReasonCodeTEMP_WS);
                                ReasonCode_l := ReasonCodeTEMP_WS.Code;

                                if ReasonCode_l = '' then begin
                                    PosCtrl_g.PosMessage(Text012);
                                    exit;
                                end;

                                if ReasonCodeLookupType_g = MemberClubTEMP_g."Reason Codes Contacts" then begin
                                    if not PosMemberMgt_g.ContactBlock(MemberContactTEMP_g."Account No.", MemberContactTEMP_g."Contact No.", ReasonCode_l, 'Yes', Process_Error_l, Error_Text_l) then begin
                                        PosCtrl_g.PosMessage(Error_Text_l);
                                        exit;
                                    end;
                                end
                                else
                                    if ReasonCodeLookupType_g = MemberClubTEMP_g."Reason Codes Cards" then begin
                                        if not PosMemberMgt_g.CardBlock(BlockCardNo_g, ReasonCode_l, 'Yes', Process_Error_l, Error_Text_l) then begin
                                            PosCtrl_g.PosMessage(Error_Text_l);
                                            exit;
                                        end;

                                        MemberCardTEMP_g."Card No." := BlockCardNo_g;
                                        LoadMemberCard(MemberCardTEMP_g);
                                        BlockUnblock_g := true;

                                        RefreshActiveLookup();
                                    end;
                                LoadPanelData;
                            end;
    end;

    [Scope('OnPrem')]
    procedure IsMyLookup(pLookupID: Text): Boolean
    begin
        exit(pLookupID in ['#MACCOUNT', '#MCLUB', '#MCONTACT', '#MCARD', '#MFREECARD', '#REASONCODE']);
    end;

    [Scope('OnPrem')]
    procedure ProcessKeyboardResult(Payload: Text; InputValue: Text; ResultOK: Boolean)
    var
        ResultNotImplemented: Label '['' %1] Keyboard Result NOT IMPLEMENTED in Member Contact Popup!';
    begin
        if not ResultOK then
            exit;

        if Payload = '#MEMBERCARD-CREATE' then begin
            CreateAndAssignMemberCard(InputValue);
        end
        else
            if Payload = '#MEMBERCARD-ADD' then begin
                AssignMemberCard(InputValue);
            end
            else
                Message(StrSubstNo(ResultNotImplemented, Payload));
        SetInfo(false);

    end;

    [Scope('OnPrem')]
    procedure IsMyKeyboard(payload: Text): Boolean
    begin
        exit(payload in ['#MEMBERCARD-CREATE', '#MEMBERCARD-ADD']);
    end;

    local procedure GetMemberCardData(FormID: Text; var RecRef_p: RecordRef; var FlowFieldBuffer_p: Record "LSC FlowField Buffer"; var ErrorText_p: Text): Boolean
    var
        FilterBufferTEMP_l: Record "LSC WS Table Filter Buffer" temporary;
        FieldBufferTEMP_l: Record "LSC WS Table Field Buffer" temporary;
        Process_Error_l: Boolean;
    begin
        MemberCardTEMP_WS.Reset;
        MemberCardTEMP_WS.DeleteAll;
        RecRef_p.GetTable(MemberCardTEMP_WS);

        FilterBufferTEMP_l.InsertFilterBuffer(1, 'Account No.', MemberContactTEMP_g."Account No.");
        FilterBufferTEMP_l.InsertFilterBuffer(5, 'Contact No.', MemberContactTEMP_g."Contact No.");

        GetFieldsFromDataTable(FormID, Database::"LSC Membership Card", FieldBufferTEMP_l);

        exit(WebServicesClient_g.GetTableData(MemberCardTEMP_WS.TableName, FilterBufferTEMP_l, FieldBufferTEMP_l, RecRef_p, FlowFieldBuffer_p, Process_Error_l, ErrorText_p));
    end;

    local procedure RefreshActiveLookup()
    var
        RecRef_l: RecordRef;
        FlowFieldBufferTEMP_l: Record "LSC FlowField Buffer";
        Error_Text_l: Text;
    begin
        if PosCtrl_g.GetActiveLookupID = '#MCARD' then begin
            if not GetMemberCardData('#MCARD', RecRef_l, FlowFieldBufferTEMP_l, Error_Text_l) then
                PosCtrl_g.PosMessage(Error_Text_l)
            else
                PosCtrl_g.RefreshActiveLookup();
        end;
    end;

    [Scope('OnPrem')]
    procedure SetBasicMemberInfoForNewMember(var MemberContactTmpIn: Record "LSC Member Contact" temporary)
    begin
        clear(BasicInfoMemberContactTEMP_g);
        BasicInfoMemberContactTEMP_g.DeleteAll();
        BasicInfoMemberContactTEMP_g := MemberContactTmpIn;
        BasicInfoMemberContactTEMP_g.insert;
    end;

    local procedure GetBasicMemberInfoForNewMember(): Boolean;
    begin
        if BasicInfoMemberContactTEMP_g.Name <> '' then begin
            MemberContactTEMP_g.TransferFields(BasicInfoMemberContactTEMP_g);
            exit(true);
        end;
        exit(False);
    end;

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure PanelClose(var MemberContactTEMP: Record "LSC Member Contact" temporary; var MembershipCardTemp: Record "LSC Membership Card"; Payload: Text[1024])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeContactCreateParametersInsert(var MemberContact_p: Record "LSC Member Contact"; var ContactCreateParametersTemp: Record "LSC Contact Create Parameters")
    begin
    end;
}

