codeunit 50011 "IT4G-POS Commands"
{

    SingleInstance = true;
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    begin
        rRetailSetup.get;
        if not rRetailSetup."IT4G Module Enabled" then error(lblSetUpErr);

        GlobalRec := Rec;

        if "Registration Mode" then
            Register(Rec)
        else begin
            POSTerminal.Get(POSSESSION.TerminalNo);

            StoreSetup.Get(POSTerminal."Store No.");
            PosFuncProfile.Get(POSSESSION.FunctionalityProfileID);

            POSTransFound := true;

            if PosTrans.Get("Current-RECEIPT") then begin
                if sl.Get(PosTrans."Receipt No.", "Current-LINE") then;
            end else
                POSTransFound := false;
            if POSTransFound then begin
                gDoc := PosTrans."Document Code";
                if gDoc <> '' then
                    rDOC.get(gDoc)
                else
                    Clear(rDOC);
            end else begin
                gDoc := '';
                clear(rDoc);
            end;

            case Command of
                'FORCE_DOC':
                    ForceDocPressed(Parameter);
                'CH_EXT_DOC':
                    ChangeExternalDocPressed(Parameter);
                'CH_REL_DOC':
                    ChangeRelatedDocPressed(Parameter);
                'CH_WEB_DOC':
                    ChangeWEBDocPressed(Parameter);
                'CH_SHIPREA':
                    ChangeShipmentReasonPressed();
                'CH_SHIPADD':
                    ChangeShipToCodePressed();
                'CH_SHIPMET':
                    ChangeShipmentMethodPressed();
                'CH_REASONC':
                    ChangeShipmentReasonPressed();
                'CH_LOC_TO':
                    ChangeLocPressed(Parameter, "Current-INPUT", gLocType::"To");
                'CH_LOC_FR':
                    ChangeLocPressed(Parameter, "Current-INPUT", gLocType::"From");
                'DYNPAYMENU':
                    DynemicPaymenuPressed();
            end;
            Rec := GlobalRec;
        end;
    end;

    var
        POSVIEW: Codeunit "LSC POS View";
        cC: Codeunit "IT4G-LS Functions";
        rRetailSetup: Record "LSC Retail Setup";
        EPOSCtrlInterface: Codeunit "LSC Simple EPOS Controller";
        POSSESSION: Codeunit "LSC POS Session";
        POSGUI: Codeunit "LSC POS GUI";
        CommandFunc: Codeunit "LSC POS Command Registration";
        GlobalRec: Record "LSC POS Menu Line";
        PosTrans: Record "LSC POS Transaction";
        cPOSTrans: Codeunit "LSC POS Transaction";
        sl: Record "LSC POS Trans. Line";
        OposUtil: Codeunit "LSC POS OPOS Utility";
        POSTerminal: Record "LSC POS Terminal";
        PosFuncProfile: Record "LSC POS Func. Profile";
        StoreSetup: Record "LSC Store";
        PosFunc: Codeunit "LSC POS Functions";
        ErrorTxt2: Label 'User or Password not valid';
        OkTXT1: Label 'Time of Entry:';
        okTXT2: Label 'Time of Exit:';
        POSTransFound: Boolean;
        Text079: Label '%1 having ID %2 can not be found.';
        LookupNotFoundText: Label 'Lookup not implemented.';
        DocNotFound: Label 'Document code %1 not found on Database.';
        LookupID: Code[20];
        PanelID: Code[20];
        bLookupActive: Boolean;
        PosLookup: Record "LSC POS Lookup";
        RecRef: RecordRef;
        lblSetUpErr: Label 'You must enable IT4G Module in Retail Setup card to enable such Functionality!!!';
        lblNewTransErr: Label 'You can not do that in a new Transaction!!!\Select Transaction First!!!!';
        gLocType: Option From,To;
        rDOC: Record "IT4G-LS Document";
        gDoc: Code[20];

    [Scope('OnPrem')]
    procedure Register(var MenuLine: Record "LSC POS Menu Line")
    var
        Module: Code[20];
        xtagType: Option System,Transaction,Session,"Multiple Use","Data Table Source Expression";
        POSCommand: Record "LSC POS Command";
        ParameterType: Enum "LSC POS Command Parameter Type";
    begin
        //Registrate.
        rRetailSetup.get;
        rRetailSetup."IT4G Module Enabled" := true;
        rRetailSetup.modify;

        Module := 'IT4G';
        CommandFunc.RegisterModule(Module, 'IT4G-POS Commands', 50011);
        CommandFunc.RegisterExtCommand('FORCE_DOC', 'Force Doc', 50011, ParameterType::"IT4G-Document", Module, false);
        If POSCommand.get('FORCE_DOC') then begin
            POSCommand."Table Link" := 60003;
            POSCommand."Field Link" := 1;
            POSCommand.modify(TRUE);
        end;
        CommandFunc.RegisterExtCommand('CH_EXT_DOC', 'Change External Document No.', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_REL_DOC', 'Change Related Document No.', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_WEB_DOC', 'Change WEB Order No.', 50011, ParameterType::" ", Module, false);

        CommandFunc.RegisterExtCommand('CH_SHIPADD', 'Change Customer Shipping Address', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_SHIPREA', 'Change Shipment Reason', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_SHIPMET', 'Change Shipment Method', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_REASONC', 'Change Reason Code', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_LOC_TO', 'Change Destination Location', 50011, ParameterType::" ", Module, false);
        CommandFunc.RegisterExtCommand('CH_LOC_FR', 'Change Source Location', 50011, ParameterType::" ", Module, false);


        createTag('<#IT4G_DocInfo>', 'Document Code Information', xtagType::Transaction);
        createTag('<#IT4G_FromStore>', 'From Store Code', xtagType::Transaction);
        createTag('<#IT4G_FromLoc>', 'From Location Code', xtagType::Transaction);
        createTag('<#IT4G_ToStore>', 'To Store Code', xtagType::Transaction);
        createTag('<#IT4G_ToLoc>', 'To Location Code', xtagType::Transaction);
        createTag('<#IT4G_OfflineDoc>', 'Offline Document No.', xtagType::Transaction);
        createTag('<#IT4G_OfflineDate>', 'Offline Document Date', xtagType::Transaction);
        createTag('<#IT4G_ShipReason>', 'Shipment Reason', xtagType::Transaction);
        createTag('<#IT4G_ShipMethod>', 'Shipment Method', xtagType::Transaction);
        createTag('<#IT4G_ReasonCode>', 'Reason Code', xtagType::Transaction);
        createTag('<#IT4G_ExtDocNo>', 'External Doc. No.', xtagType::Transaction);
        createTag('<#IT4G_RelDocNo>', 'Related Doc. No.', xtagType::Transaction);
        createTag('<#IT4G_WEBOrderNo>', 'WEB Order No.', xtagType::Transaction);

        MenuLine."Registration Mode" := false;
    end;

    [Scope('OnPrem')]
    procedure ConfirmBeep(Txt: Text[150]): Boolean
    begin
        //ConfirmBeep
        OposUtil.Beeper;
        OposUtil.Beeper;

        if POSGUI.PosConfirm(Txt, true) then
            exit(true);
        exit(false);
    end;

    [Scope('OnPrem')]
    procedure ErrorBeep(Txt: Text[150])
    begin
        //ErrorBeep
        OposUtil.Beeper;
        OposUtil.Beeper;

        POSGUI.PosMessage(Txt);
    end;

    procedure CreateTag(xTag: text; xDescr: text; xType: Option System,Transaction,Session,"Multiple Use","Data Table Source Expression");
    var
        rTag: record "LSC POS Tag";
    begin
        clear(rTag);
        if rTag.get(xTag) then begin
            rTag.Description := xDescr;
            rtag.Type := xType;
            if rTag.modify(true) then;

        end else begin
            rTag.Tag := xTag;
            rtag.Type := xType;
            rTag.Description := xDescr;
            if not rTag.insert(TRUE) then;
        end;

    end;

    [Scope('OnPrem')]

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction", 'OnBeforeProcessKeyBoardResult', '', false, false)]
    local procedure OnBeforeProcessKeyBoardResult_IT4G(Payload: Text; InputValue: Text; ResultOK: Boolean; var IsHandled: Boolean);
    var
    begin
        ProcessKeyboardResult(Payload, InputValue, ResultOK, IsHandled);
    end;

    [Scope('OnPrem')]
    procedure ProcessKeyboardResult(Payload: Text; InputValue: Text; ResultOK: Boolean; var IsHandled: Boolean);
    var
    begin
        case Payload of
            '#ExternalDocNo', '#RelatedDocNo', '#WEBOrderNo':
                begin
                    if ResultOK then begin
                        //                        ChangeExternalDocPressed(InputValue);
                        globalrec.parameter := InputValue;
                        cPOSTrans.RUN(GLOBALREC);
                    end;
                    IsHandled := true;
                    exit;
                end;
        /*
            '#RelatedDocNo':
                begin
                    if ResultOK then
                        ChangeRelatedDocPressed(InputValue);
                    IsHandled := true;
                    exit;
                end;
        end;
        */
        end;
    end;

    procedure DocCodeLookupPressed()
    var
        POSTransLine: Record "LSC POS Trans. Line";
        VendorRec: Record "Vendor";
    begin
        //DocLookupPressed
        if not InitLookup('IT4G_DOC') then
            exit;

        bLookupActive := true;
        rDoc.setrange("LS Transaction Type", PosTrans."Transaction Type");
        recref.GetTable(rDoc);
        POSGui.Lookup(POSLookup, '', POSTransLine, true, '', RecRef);
    end;


    local procedure InitLookup(xLookUpID: code[20]): Boolean
    var
        Text001: Label '%1 %2 must exist to run the Lookup';
    begin
        LookupID := xLookupID;
        if not POSSession.GetPosLookupRec(LookupID, POSLookup) then begin
            ErrorBeep(StrSubstNo(Text001, POSLookup.TableCaption, LookupID));
            exit(false);
        end;

        exit(true);
    end;

    [Scope('OnPrem')]
    procedure ProcessLookupResult(): Boolean
    var
        KeyVal: Code[20];
        cC: Codeunit "IT4G-POS Commands";
    begin
        bLookupActive := false;
        KeyVal := POSGUI.GetLookupKeyValue(LookupID);

        if (KeyVal <> '') then begin
            case LookupID of
                /*
                    'IT4G_DOC':
                        begin
                            if rDoc.get(KeyVal) then begin
                                ForceDocPressed(KeyVal);
                                exit;
                            end;
                        end;
                end;
                    */
                'IT4G_DOC', 'IT4G_SHIP_REASON', 'IT4G_SHIP_METHOD', 'IT4G_REASON_CODE', 'IT4G_LOCATION':
                    begin
                        if rDoc.get(KeyVal) then begin
                            globalrec.parameter := keyval;
                            cPOSTrans.RUN(GLOBALREC);
                            exit;
                        end;
                    end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Controller", 'OnLookupResult', '', false, false)]
    local procedure OnLookupResult_IT4G(LookupID: Text; FilterText: Text; resultOK: Boolean; var processed: Boolean)
    begin
        if processed then
            exit;

        case LookupID of
            'IT4G_DOC', 'IT4G_SHIP_REASON', 'IT4G_SHIP_METHOD', 'IT4G_REASON_CODE', 'IT4G_LOCATION':
                begin
                    if IsMyLookup(LookupID) then begin
                        if resultOK then begin
                            processed := true;
                            ProcessLookupResult();
                        end;
                        exit;
                    end;
                    exit;
                end;
        end;
    end;

    procedure IsMyLookup(pLookupID: Text): Boolean
    begin
        exit((pLookupID in ['IT4G_DOC', 'IT4G_SHIP_REASON', 'IT4G_SHIP_METHOD', 'IT4G_REASON_CODE', 'IT4G_LOCATION']) and bLookupActive);
    end;


    procedure ForceDocPressed(xParam: code[20])
    var
        bRecalc: Boolean;
        rPL: Record "LSC POS Trans. Line";
        lblRecalc: Label 'Recalculate Receipt?';
    begin

        if xParam = '' then begin
            DocCodeLookupPressed;
        end else begin
            rDoc.get(xParam);
            clear(cC);

            /*

                        Case rDoc."LS Transaction Type" of
                            rDoc."LS Transaction Type"::NegAdj:
                                begin
                                    cPOSTrans.NegAdjPressed();
                                end;
                            rDoc."LS Transaction Type"::
                                begin
                                    cPOSTrans.NegAdjPressed();
                                end;
                        end;
            */
            if PosTrans."New Transaction" then begin
                ErrorBeep(lblNewTransErr);
                exit;
            end;



            if PosTrans."Document Code" = '' then
                bRecalc := false
            else
                bRecalc := postrans."Document Code" <> xParam;

            case rDoc."Change Doc. POS Behavior" of
                rDoc."Change Doc. POS Behavior"::"No Recalculate":
                    bRecalc := false;
                rDoc."Change Doc. POS Behavior"::Recalculate:
                    bRecalc := true;
                rDoc."Change Doc. POS Behavior"::ask:
                    if POSGUI.POSConfirm(lblRecalc, false) then
                        bRecalc := true
                    else
                        brecalc := false;
            end;

            cC.WriteDocumentCode(PosTrans, xParam);


            if bRecalc then begin
                rPL.setrange("Receipt No.", PosTrans."Receipt No.");
                rPL.SetRange("Entry Type", rPL."Entry Type"::Item);
                if rPL.findset then
                    repeat
                        rPL.Validate(Number);
                        rPL.Validate(Quantity);
                        rPL.CalcPrices();
                        rPL.modify;
                    until rPL.next = 0;
            end;
            POSVIEW.MessageBeep(' ');
            cPOSTrans.SelectDefaultMenu();
            POSGUI.SetRefreshMenuFlag(0);
            POSGUI.SetRefreshMenuFlag(1);
            POSGUI.SetRefreshMenuFlag(2);
            POSGUI.SetRefreshMenuFlag(3);
        end;
    end;

    procedure ChangeLocPressed(MenuParam: code[20]; xInput: text[100]; xLocType: Option From,To);
    var
        rSL: Record "LSC Store Location";
        rList: Record "LSC Store Location";
        lblErrLoc: Label 'Location %1 can not change in Document %2';
    begin
        if xLocType = xLocType::From then
            if rDoc."Location From Locked" then begin
                ErrorBeep(StrSubstNo(lblErrLoc, xLocType, rDoc.Code + '-' + rDoc.Description));
            end;
        if xLocType = xLocType::"To" then
            if rDoc."Location To Locked" then begin
                ErrorBeep(StrSubstNo(lblErrLoc, xLocType, rDoc.Code + '-' + rDoc.Description));
            end;

        If xInput <> '' then begin
            rSL.setrange("Location Code", xInput);
            if rSL.FindFirst() then begin
                if xLocType = xLocType::"From" then begin
                    PosTrans."From Store" := rSL."Store No.";
                    PosTrans."From Location" := rSL."Location Code";
                end;
                if xLocType = xLocType::"To" then begin
                    PosTrans."To Store" := rSL."Store No.";
                    PosTrans."To Location" := rSL."Location Code";
                end;
                PosTrans.Modify();
                Exit;
            end;
        end;

        if not InitLookup('IT4G_LOCATION') then
            exit;

        bLookupActive := true;
        rList.SetRange("Visible on POS", true);

        case rDoc."Document Type" of
            rDoc."Document Type"::"Transfer Ship":
                begin
                    if xLocType = xLocType::From then rList.SetFilter("Store No.", '%1', PosTrans."Store No.");
                    if xLocType = xLocType::"To" then rList.SetFilter("Store No.", '<>%1', PosTrans."Store No.");
                end;
        end;

        rList.setrange(rList."Visible on POS", true);
        recref.GetTable(rList);
        POSGui.Lookup(POSLookup, '', sl, true, '', RecRef);

    end;

    procedure ChangeExternalDocPressed(xParam: Text)
    var
        lblKeyboardCaption: label 'External Document No.';
    begin
        if xParam <> '' then begin
            PosTrans."External Doc. No." := xParam;
            PosTrans.modify;
            exit;
        end else begin
            PosTrans.Get(GlobalRec."Current-RECEIPT");
            posgui.OpenAlphabeticKeyboard(lblKeyboardCaption, PosTrans."External Doc. No.", false, '#ExternalDocNo', MaxStrLen(PosTrans."External Doc. No."));

        end;
    end;

    procedure ChangeRelatedDocPressed(xParam: Text)
    var
        lblKeyboardCaption: label 'Related Document No.';
    begin
        if xParam <> '' then begin
            PosTrans."Related Doc. No." := xParam;
            PosTrans.modify;
            exit;
        end else begin
            PosTrans.Get(GlobalRec."Current-RECEIPT");
            POSGUI.OpenAlphabeticKeyboard(lblKeyboardCaption, PosTrans."Related Doc. No.", false, '#RelatedDocNo', MaxStrLen(PosTrans."Related Doc. No."));
        end;
    end;

    procedure ChangeWEBDocPressed(xParam: Text)
    var
        lblKeyboardCaption: label 'WEB Order No.';
    begin
        if xParam <> '' then begin
            PosTrans."WEB Order No." := xParam;
            PosTrans.modify;
            exit;
        end else begin
            PosTrans.Get(GlobalRec."Current-RECEIPT");
            POSGUI.OpenAlphabeticKeyboard(lblKeyboardCaption, PosTrans."WEB Order No.", false, '#WEBOrderNo', MaxStrLen(PosTrans."WEB Order No."));
        end;
    end;

    procedure ChangeShipmentReasonPressed()
    var
        rList: Record "IT4G-Help Table";
    begin
        if not InitLookup('IT4G_SHIP_REASON') then
            exit;

        bLookupActive := true;
        rList.setrange("Type", rList.type::"Shipment Reason");
        recref.GetTable(rList);
        POSGui.Lookup(POSLookup, '', sl, true, '', RecRef);
    end;

    procedure ChangeShipmentMethodPressed()
    var
        rList: Record "Shipment Method";
    begin
        if not InitLookup('IT4G_SHIP_METHOD') then
            exit;

        bLookupActive := true;
        recref.GetTable(rList);
        POSGui.Lookup(POSLookup, '', sl, true, '', RecRef);
    end;

    procedure ChangeReasonCodePressed()
    var
        VendorRec: Record "Vendor";
        rList: Record "Reason Code";
    begin
        if not InitLookup('IT4G_REASON_CODE') then
            exit;

        bLookupActive := true;
        recref.GetTable(rList);
        POSGui.Lookup(POSLookup, '', sl, true, '', RecRef);
    end;

    procedure DynemicPaymenuPressed()
    var
        cC: Codeunit "IT4G-POS Dynamic Menus";
        xRelType: Enum "IT4G-Document Relation Type";
    begin
        cC.SetRelType(xRelType::"Tender Type");
        cC.run(globalrec);
    end;

    procedure ChangeShipToCodePressed()
    var
        rList: Record "Ship-to Address";
    begin
        if not InitLookup('IT4G_SHIP_ADDR') then
            exit;

        bLookupActive := true;
        rList.setrange("Customer No.", PosTrans."Customer No.");
        recref.GetTable(rList);
        POSGui.Lookup(POSLookup, '', sl, true, '', RecRef);
    end;

}

