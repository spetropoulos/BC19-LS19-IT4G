codeunit 50018 "IT4G-Scan Panel"
{
    SingleInstance = true;
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    begin
        PanelID := cF.GRV_C('ScanDoc_PanelID', 0, 1);
        DataGridControlID := PanelID + '_JOURNAL';
        DataInputID := PanelID + '_INPUT';

        GlobalRec := Rec; //To have access in all functions
                          //        
        if rec."Registration Mode" then begin
            Registrate(Rec);
            exit;
        end;

        case Rec.Command of
            'SCAN_IT4GDOC':
                ScanIT4GDocPressed(rec."Current-INPUT");
            'SCAN_CUSTOM':
                ProcessInternalCommand();
            'SCAN_BARCODE':
                begin
                    CurrInput := POSCtrl.GetInputText(DataInputID);
                    POSCtrl.SetInputText(DataInputID, '');
                    ScanBarcode(GlobalDoc, GlobalBoxNo, CurrInput);
                end;
            'SCAN_POST':
                PostScanPressed();

        end;
        UpdateTags();
        GlobalRec.Processed := true;
        Rec := GlobalRec;
    end;

    var
        CurrInput: text;
        RecRef: RecordRef;
        POSCtrl: Codeunit "LSC POS Control Interface";
        GlobalRec: Record "LSC POS Menu Line";
        PosLookup: Record "LSC POS Lookup";
        PanelRec: Record "LSC POS Panel";
        DataTableRec: Record "LSC POS Data Table";
        IT4GDocHeader: Record "IT4G-Doc. Header";
        IT4GDocLine: Record "IT4G-Doc. Line";
        DataTableRecRef: RecordRef;
        CommandFunc: Codeunit "LSC POS Command Registration";
        POSSESSION: Codeunit "LSC POS Session";
        POSGui: Codeunit "LSC POS GUI";
        POSContext: Codeunit "LSC POS Context";
        PosDataSetUtil: Codeunit "LSC POS DataSet Utility";
        LSDataSet: Codeunit "LSC DataSet";
        EPOSCtrlInterf: Codeunit "LSC POS Control Interface";
        PosEvent: Codeunit "LSC POS Control Event";

        LookupID: Code[20];
        PanelID: Code[20];
        DataGridControlID: code[20];
        DataInputID: code[20];
        LookupActive: Boolean;
        Text001: Label '%1 %2 must exist to run the guest list';
        GlobalDoc: Text;
        GlobalQTY: Decimal;
        GlobalCounter: Integer;
        GlobalBoxNo: Text;
        cF: Codeunit "IT4G-Functions";
        BoxPrefix: Text;
        DocPrefix: Text;
        lbInvalidInput: Label 'Invalid Input!!!';
        lbScanQtyChanged: Label 'Scanning Quantity Changed!!!';
        GlobalText: text;

    procedure InitGlobals(): Boolean
    begin
        GlobalQTY := 1;
        GlobalBoxNo := '';
        GlobalCounter := 0;
        GlobalText := '';
        BoxPrefix := cF.GRV_C('ScanDoc_Box_Prefix', 0, 1);
        DocPrefix := cF.GRV_C('ScanDoc_Doc_Prefix', 0, 1);

        exit(true);
    end;

    procedure Registrate(var MenuLine: Record "LSC POS Menu Line")
    var
        cPC: Codeunit "IT4G-POS Commands";
    begin
        //Registrate - register in POS commands

        CommandFunc.RegisterModule('IT4GDOC_SCAN', 'IT4G Document Scaning', 50018);

        CommandFunc.RegisterExtCommand('SCAN_IT4GDOC', 'Scan IT4G Document', 50018, 0, 'IT4GDOC_SCAN', false);
        CommandFunc.RegisterExtCommand('SCAN_POST', 'Post IT4G Document', 50018, 0, 'IT4GDOC_SCAN', false);
        CommandFunc.RegisterExtCommand('SCAN_BARCODE', 'Scan IT4G Document Barcode', 50018, 0, 'IT4GDOC_SCAN', false);

        CommandFunc.RegisterExtCommand('SCAN_CUSTOM', 'Scan IT4G Document Internal Commands', 50018, 0, 'IT4GDOC_SCAN', false);
        CommandFunc.RegisterParameters('SCAN_CUSTOM', 'INITBOX', 0, '', 0, 0, 0, 0, 0);
        CommandFunc.RegisterParameters('SCAN_CUSTOM', 'INITCOUNTER', 0, '', 0, 0, 0, 0, 0);
        CommandFunc.RegisterParameters('SCAN_CUSTOM', 'CH_SCANQTY', 0, '', 0, 0, 0, 0, 0);

        cF.SetRV_C('ScanDoc_PanelID', 0, 1, 'SCANIT4GDOC');
        cF.SetRV_C('ScanDoc_Box_Prefix', 0, 1, 'PL');
        cF.SetRV_C('ScanDoc_Doc_Prefix', 0, 1, 'G');

        cPC.createTag('<#ScanHeader_Doc>', 'Scan Document Number', 1);
        cPC.createTag('<#ScanHeader_Scanned>', 'Scan Document Quantity Information', 1);
        cPC.createTag('<#ScanHeader_BoxID>', 'Scan Document Box Information', 1);
        cPC.createTag('<#ScanHeader_ScanQty>', 'Scan Document Scanning Quantity', 1);
        cPC.createTag('<#ScanHeader_ScanCounter>', 'Scan Document Scan Counter', 1);
        cPC.createTag('<#ScanHeader_Info>', 'Scan Document Information', 1);

        MenuLine."Registration Mode" := false;  //Confirm registration
    end;


    [Scope('OnPrem')]
    local procedure ProcessInternalCommand()
    begin
        CurrInput := POSCtrl.GetInputText(DataInputID);
        POSCtrl.SetInputText(DataInputID, '');
        case GlobalRec.Parameter of
            'LOOKUPVENDOR':
                begin

                end;
            //VendorLookupPressed();
            'INITBOX':
                GlobalBoxNo := '';
            'INITCOUNTER':
                GlobalCounter := 0;
            'CH_SCANQTY':
                ChangeScanQtyPressed();
        end;

    end;

    local Procedure UpdateTags()
    begin
        POSSESSION.Setvalue('<#ScanHeader_Doc>', '  ' + IT4GDocHeader."Document No.");
        POSContext.SetKeyValue('<#ScanHeader_Doc>', '  ' + IT4GDocHeader."Document No.");
        POSContext.SetKeyValue('<#ScanHeader_Scanned>', getDocScanned);
        POSContext.SetKeyValue('<#ScanHeader_BoxID>', getBoxScanned);
        POSContext.SetKeyValue('<#ScanHeader_ScanQty>', GetGlobalQTY);
        POSContext.SetKeyValue('<#ScanHeader_ScanCountrer>', format(GlobalCounter));
        POSContext.SetKeyValue('<#ScanHeader_Info>', GlobalText);
        EPOSCtrlInterf.AddContext(POSContext);
    end;

    local Procedure ClearTags()
    begin
        POSSESSION.DeleteValue('<#ScanHeader_Doc>');
        POSContext.SetKeyValue('<#ScanHeader_Doc>', '');
        POSContext.SetKeyValue('<#ScanHeader_Scanned>', '');
        POSContext.SetKeyValue('<#ScanHeader_BoxID>', '');
        POSContext.SetKeyValue('<#ScanHeader_ScanQty>', '');
        POSContext.SetKeyValue('<#ScanHeader_ScanCountrer>', '');
        POSContext.SetKeyValue('<#ScanHeader_Info>', '');
        EPOSCtrlInterf.AddContext(POSContext);
    end;

    procedure UpdateItemDataGrid()
    var
    begin
        //UpdateItemDataGrid
        IT4GDocLine.setfilter("Document No.", GlobalDoc);
        //        if not IT4GDocLine.IsEmpty then begin
        DataTableRecRef.GetTable(IT4GDocLine);
        POSSESSION.GetDataTableInDataGrid(PanelRec, DataGridControlID, DataTableRec);
        EPOSCtrlInterf.InitDataGridControlEx(DataGridControlID, DataTableRec."Data Table ID", DataTableRecRef);
        EPOSCtrlInterf.RefreshDataGridControl(POSSESSION.InterfaceProfileID, DataGridControlID);

        PosDataSetUtil.InitDataTable(DataTableRec);
        DataTableRecRef.GETTABLE(IT4GDocLine);
        PosDataSetUtil.SetRecRefData(DataTableRecRef);
        PosDataSetUtil.FillDataSet(false, LSDataSet, true);
        EPOSCtrlInterf.AddGridData(DataGridControlID, LSDataSet);
        //        end;
        //        POSContext.SetKeyValue('<#Header_Doc>', '  ' + IT4GDocHeader."Document No.");

    end;


    procedure ScanIT4GDocPressed(xParam: text): Boolean
    var
    begin
        InitGlobals();
        if not POSSESSION.GetPosPanelRec(PanelID, PanelRec) then begin
            posgui.PosMessage(StrSubstNo(Text001, PanelRec.TABLECAPTION, PanelID));
            exit(false);
        end;
        GetDoc(xParam);

        EPOSCtrlInterf.ShowPanelModal(PanelID);
    end;

    local procedure GetDoc(xParam: text): Boolean
    var
        lblStart: label 'Scan Document First';
        cIT4GTSU: Codeunit "IT4G-Trans. Server Util";
    begin
        GlobalDoc := '';
        clear(IT4GDocHeader);
        clear(cIT4GTSU);
        if not cIT4GTSU.GetIT4GDoc(IT4GDocHeader, xParam, GlobalText) then begin
            UpdateItemDataGrid();
            exit(false);
        end;

        If not IT4GDocHeader.get(xParam) then begin
            GlobalText := lblStart;
            exit(false);
        end else begin
            GlobalDoc := xParam;
            InitGlobals();
            UpdateItemDataGrid();
        end;
        exit(true);
    end;

    local procedure QuantityPressed()
    var
        DataTableRecID: RecordId;
    begin

        EPOSCtrlInterf.GetDataGridRecordID(DataGridControlID, DataTableRecID);
        If DataTableRecRef.get(DataTableRecID) then begin
            DataTableRecRef.SetTable(IT4GDocLine);
            //EPOSCtrlInterf.OpenNumericKeyboard('Quantity', '');
            exit;
        end;
    end;

    local procedure ScanBarcode(xDocNo: code[20]; xBoxNo: Text[50]; var xBarcode: Text)
    var
        DataTableRecID: RecordId;
        rB: Record "LSC Barcodes";
        lberrorBarcode: label 'Barcode %1 not found on Database';
        lbLastScanned: label 'Barcode %1 Scanned';
        lbBoxScanned: label 'Box %1 Scanned';
        rSL: Record "IT4G-Doc. Scan";

    begin
        If (GlobalDoc = '') or ((uppercase(copystr(xBarcode, 1, strlen(DocPrefix))) = DocPrefix) and (DocPrefix <> '')) then begin
            if DocPrefix <> '' then xBarcode := copystr(xBarcode, strlen(DocPrefix) + 1);

            GetDoc(xBarcode);
            exit;
        end;

        if uppercase(copystr(xBarcode, 1, strlen(BoxPrefix))) = BoxPrefix then begin
            GlobalBoxNo := xBarcode;
            GlobalText := StrSubstNo(lbBoxScanned, xBarcode);
        end else
            IF not rB.GET(xBarcode) then begin
                //                POSGui.PosMessage(StrSubstNo(lberrorBarcode, xBarcode));
                GlobalText := StrSubstNo(lberrorBarcode, xBarcode);
                xBarcode := '';
                exit;
            end else begin
                clear(rSL);
                rSL."Document No." := xDocNo;
                rSL."Scan Identifier" := CreateGuid();
                rSL."Box No." := xBoxNo;
                rSL."Barcode No." := xBarcode;
                rSL."Scanned Quantity" := GlobalQTY;

                rSL."Item No." := rB."Item No.";
                rSL."Variant Code" := rB."Variant Code";

                rSL."Created by Store No." := POSSESSION.StoreNo();
                rSL."Created by POS Terminal No." := POSSESSION.TerminalNo();
                rSL."Created by Staff" := POSSESSION.StaffID();
                rSL."Created On" := CurrentDateTime;
                rSL."Created by User" := UserId;
                rSL.insert;
                GlobalCounter += 1;
                GlobalText := StrSubstNo(lbLastScanned, xBarcode);
            end;
        //        POSGui.PosMessage(StrSubstNo(lberrorBarcode + '\TESTTTTTTTT!!!!!!!!!', xBarcode));
        UpdateItemDataGrid();

    end;

    local procedure getGlobalQty(): text
    begin
        If GlobalQTY > 0 then
            exit('+' + format(GlobalQTY))
        else
            exit(format(GlobalQTY));
    end;

    local procedure getDocScanned(): text
    begin
        IT4GDocHeader.CalcFields("Calc. Quantity", "Calc. Scanned Quantity");
        exit(format(IT4GDocHeader."Calc. Scanned Quantity") + '/' + format(IT4GDocHeader."Calc. Quantity"));
    end;

    local procedure getBoxScanned(): text
    var
        rB: Record "IT4G-Doc. Line Box";
        rBS: Record "IT4G-Doc. Scan";

    begin
        clear(rB);
        rB.SetRange("Document No.", IT4GDocHeader."Document No.");
        rB.Setrange("Box No.", GlobalBoxNo);
        rB.CalcSums(Quantity);

        clear(rBS);
        rBS.SetRange("Document No.", IT4GDocHeader."Document No.");
        rBS.Setrange("Box No.", GlobalBoxNo);
        rBS.CalcSums("Scanned Quantity");

        If GlobalBoxNo <> '' then
            exit(GlobalBoxNo + ': ' + format(rBS."Scanned Quantity") + '/' + format(rB.Quantity))
        else
            exit('');
    end;

    local procedure PostScanPressed()
    TSUTIL: Codeunit "LSC POS Trans. Server Utility";
    var
        lbPostScan: Label 'Post %1 ?';
    begin
        If POSGui.PosConfirm(StrSubstNo(lbPostScan, IT4GDocHeader."Document No."), true) then begin

        end;
        TSUTIL.CreateTSRetryEntry(Database::"IT4G-Doc. Header", IT4GDocHeader."Document No.", '0', '', 1, 0, false, '', '', 0, '');
        TSUTIL.SendUnsentTablesDD3(0, true);
        ClearTags();
        EPOSCtrlInterf.HidePanel(PanelID, true);
    end;

    local procedure ChangeScanQtyPressed()
    var

    begin
        If CurrInput <> '' then begin
            If not Evaluate(GlobalQTY, CurrInput) then begin
                GlobalText := lbInvalidInput;
            end else
                GlobalText := lbScanQtyChanged;
        end else begin

        end;
    end;
}
