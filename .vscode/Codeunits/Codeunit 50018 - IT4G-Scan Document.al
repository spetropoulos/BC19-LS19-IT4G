codeunit 50018 "IT4G-Scan Document"
{
    SingleInstance = true;
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    begin
        PanelID := cF.GRV_C('ScanDoc_PanelID', 0, 1);
        DataGridControlID := cF.GRV_C('ScanDoc_PanelID_DataGrid', 0, 1);
        DataInputID := cF.GRV_C('ScanDoc_PanelID_Input', 0, 1);

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
        IT4GDocLinetmp: Record "IT4G-Doc. Line" temporary;
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
        GlobalBarcode: text;
        GlobalItem: text;
        GlobalVariant: text;
        GlobalItemInfo: text;
        GlobalVariantInfo: text;
        GlobalItemQtyInfo: text;
        GlobalVariantQtyInfo: text;
        GlobalItemBoxQtyInfo: text;
        GlobalVariantBoxQtyInfo: text;
        GlobalItemQTY: Decimal;
        GlobalVariantQTY: Decimal;
        GlobalBoxItemQTY: Decimal;
        GlobalBoxVariantQTY: Decimal;

    procedure InitGlobals(): Boolean
    begin
        GlobalQTY := 1;
        GlobalBoxNo := '';
        GlobalCounter := 0;
        GlobalText := '';
        BoxPrefix := cF.GRV_C('ScanDoc_Box_Prefix', 0, 1);
        DocPrefix := cF.GRV_C('ScanDoc_Doc_Prefix', 0, 1);
        InitBarcode();
        exit(true);
    end;

    procedure InitBarcode(): Boolean
    begin
        GlobalBarcode := '';
        GlobalItem := '';
        GlobalVariant := '';
        GlobalItemInfo := '';
        GlobalVariantInfo := '';
        GlobalItemQtyInfo := '';
        GlobalVariantQtyInfo := '';
        GlobalItemBoxQtyInfo := '';
        GlobalVariantBoxQtyInfo := '';

        GlobalItemQTY := 0;
        GlobalVariantQTY := 0;
        GlobalBoxItemQTY := 0;
        GlobalBoxVariantQTY := 0;

        exit(true);
    end;

    procedure Registrate(var MenuLine: Record "LSC POS Menu Line")
    var
        cPC: Codeunit "IT4G-POS Commands";
        ParameterType: Enum "LSC POS Command Parameter Type";
    begin
        CommandFunc.RegisterModule('IT4GDOC_SCAN', 'IT4G Document Scaning', 50018);

        CommandFunc.RegisterExtCommand('SCAN_IT4GDOC', 'Scan IT4G Document', 50018, ParameterType::" ", 'IT4GDOC_SCAN', false);
        CommandFunc.RegisterExtCommand('SCAN_POST', 'Post IT4G Document', 50018, ParameterType::" ", 'IT4GDOC_SCAN', false);
        CommandFunc.RegisterExtCommand('SCAN_BARCODE', 'Scan IT4G Document Barcode', 50018, ParameterType::" ", 'IT4GDOC_SCAN', false);

        CommandFunc.RegisterExtCommand('SCAN_CUSTOM', 'Scan IT4G Document Internal Commands', 50018, ParameterType::" ", 'IT4GDOC_SCAN', false);
        CommandFunc.RegisterParameters('SCAN_CUSTOM', 'INITBOX', 0, '', 0, 0, 0, 0, 0);
        CommandFunc.RegisterParameters('SCAN_CUSTOM', 'INITCOUNTER', 0, '', 0, 0, 0, 0, 0);
        CommandFunc.RegisterParameters('SCAN_CUSTOM', 'CH_SCANQTY', 0, '', 0, 0, 0, 0, 0);

        cF.SetRV_C('ScanDoc_PanelID', 0, 1, 'SCANIT4GDOC');
        cF.SetRV_C('ScanDoc_Box_Prefix', 0, 1, 'PL');
        cF.SetRV_C('ScanDoc_Doc_Prefix', 0, 1, 'G');

        cPC.createTag('<#ScanDoc_Doc>', 'Scan Document Number', 1);
        cPC.createTag('<#ScanDoc_Scanned>', 'Scan Document Quantity Information', 1);
        cPC.createTag('<#ScanDoc_BoxID>', 'Scan Document Box Information', 1);
        cPC.createTag('<#ScanDoc_ScanQty>', 'Scan Document Scanning Quantity', 1);
        cPC.createTag('<#ScanDoc_ScanCounter>', 'Scan Document Scan Counter', 1);

        cPC.createTag('<#ScanDoc_Item>', 'Scan Document Item', 1);
        cPC.createTag('<#ScanDoc_Variant>', 'Scan Document Variant', 1);
        cPC.createTag('<#ScanDoc_ItemInfo>', 'Scan Document Item Information', 1);
        cPC.createTag('<#ScanDoc_VariantInfo>', 'Scan Document Variant Information', 1);
        cPC.createTag('<#ScanDoc_ItemQtyInfo>', 'Scan Document Item Quantity Information', 1);
        cPC.createTag('<#ScanDoc_VariantQtyInfo>', 'Scan Document Variant Quantity Information', 1);
        cPC.createTag('<#ScanDoc_ItemBoxQtyInfo>', 'Scan Document Box Item Quantity Information', 1);
        cPC.createTag('<#ScanDoc_VariantBoxQtyInfo>', 'Scan Document Box Variant Quantity Information', 1);

        cPC.createTag('<#ScanDoc_Info>', 'Scan Document Information', 1);
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
        POSSESSION.Setvalue('<#ScanDoc_Doc>', '  ' + IT4GDocHeader."Document No.");
        POSContext.SetKeyValue('<#ScanDoc_Doc>', '  ' + IT4GDocHeader."Document No.");
        POSContext.SetKeyValue('<#ScanDoc_Scanned>', getDocScanned);
        POSContext.SetKeyValue('<#ScanDoc_BoxID>', getBoxScanned);
        POSContext.SetKeyValue('<#ScanDoc_ScanQty>', GetGlobalQTY);
        POSContext.SetKeyValue('<#ScanDoc_ScanCountrer>', format(GlobalCounter));
        POSContext.SetKeyValue('<#ScanDoc_Info>', GlobalText);

        POSContext.SetKeyValue('<#ScanDoc_Item>', GlobalItem);
        POSContext.SetKeyValue('<#ScanDoc_Variant>', GlobalVariant);
        POSContext.SetKeyValue('<#ScanDoc_ItemInfo>', GlobalItemInfo);
        POSContext.SetKeyValue('<#ScanDoc_VariantInfo>', GlobalVariantInfo);
        POSContext.SetKeyValue('<#ScanDoc_ItemQtyInfo>', GlobalItemQtyInfo);
        POSContext.SetKeyValue('<#ScanDoc_VariantQtyInfo>', GlobalVariantQtyInfo);
        POSContext.SetKeyValue('<#ScanDoc_ItemBoxQtyInfo>', GlobalItemBoxQtyInfo);
        POSContext.SetKeyValue('<#ScanDoc_VariantBoxQtyInfo>', GlobalVariantBoxQtyInfo);

        EPOSCtrlInterf.AddContext(POSContext);
    end;

    local Procedure ClearTags()
    begin
        POSSESSION.DeleteValue('<#ScanDoc_Doc>');
        POSContext.SetKeyValue('<#ScanDoc_Doc>', '');
        POSContext.SetKeyValue('<#ScanDoc_Scanned>', '');
        POSContext.SetKeyValue('<#ScanDoc_BoxID>', '');
        POSContext.SetKeyValue('<#ScanDoc_ScanQty>', '');
        POSContext.SetKeyValue('<#ScanDoc_ScanCountrer>', '');
        POSContext.SetKeyValue('<#ScanDoc_Info>', '');

        POSContext.SetKeyValue('<#ScanDoc_Item>', '');
        POSContext.SetKeyValue('<#ScanDoc_Variant>', '');
        POSContext.SetKeyValue('<#ScanDoc_ItemInfo>', '');
        POSContext.SetKeyValue('<#ScanDoc_VariantInfo>', '');
        POSContext.SetKeyValue('<#ScanDoc_ItemQtyInfo>', '');
        POSContext.SetKeyValue('<#ScanDoc_VariantQtyInfo>', '');
        POSContext.SetKeyValue('<#ScanDoc_ItemBoxQtyInfo>', '');
        POSContext.SetKeyValue('<#ScanDoc_VariantBoxQtyInfo>', '');

        EPOSCtrlInterf.AddContext(POSContext);
    end;

    procedure UpdateItemDataGrid(xItem: code[20]; xVariant: code[20])
    var
    begin
        POSSESSION.GetDataTableInDataGrid(PanelRec, DataGridControlID, DataTableRec);
        EPOSCtrlInterf.InitDataGridControlEx(DataGridControlID, DataTableRec."Data Table ID", DataTableRecRef);
        PosDataSetUtil.InitDataTable(DataTableRec);

        PosDataSetUtil.SetRecRefData(DataTableRecRef);
        PosDataSetUtil.FillDataSet(false, LSDataSet, true);
        EPOSCtrlInterf.AddGridData(DataGridControlID, LSDataSet);
        EPOSCtrlInterf.RefreshDataGridControl(POSSESSION.InterfaceProfileID, DataGridControlID);

    end;


    procedure ScanIT4GDocPressed(xParam: text): Boolean
    var
    begin
        InitGlobals();
        if not POSSESSION.GetPosPanelRec(PanelID, PanelRec) then begin
            posgui.PosMessage(StrSubstNo(Text001, PanelRec.TABLECAPTION, PanelID));
            exit(false);
        end;
        ScanBarcode('', '', xParam);

        IT4GDocLinetmp.Reset;
        if not IT4GDocLinetmp.IsEmpty then
            IT4GDocLinetmp.DeleteAll;

        IT4GDocLinetmp.setfilter("Document No.", '');
        DataTableRecRef.GetTable(IT4GDocLinetmp);
        POSSESSION.GetDataTableInDataGrid(PanelRec, DataGridControlID, DataTableRec);
        EPOSCtrlInterf.InitDataGridControlEx(DataGridControlID, DataTableRec."Data Table ID", DataTableRecRef);

        EPOSCtrlInterf.ShowPanelModal(PanelID);
    end;

    local procedure GetDoc(xParam: text): Boolean
    var
        lblStart: label 'Scan Document First';
        cIT4GTSU: Codeunit "IT4G-Trans. Server Util";
    begin
        GlobalDoc := '';

        IT4GDocLinetmp.Reset;
        if not IT4GDocLinetmp.IsEmpty then
            IT4GDocLinetmp.DeleteAll;

        clear(IT4GDocHeader);
        clear(cIT4GTSU);
        if not cIT4GTSU.GetIT4GDoc(IT4GDocHeader, xParam, GlobalText) then begin
            exit(false);
        end;

        If not IT4GDocHeader.get(xParam) then begin
            GlobalText := lblStart;
            exit(false);
        end else begin
            InitGlobals();
            GlobalDoc := xParam;


            clear(IT4GDocLine);
            IT4GDocLine.setrange("Document No.", xParam);
            IT4GDocLine.setrange("Line Type", IT4GDocLine."Line Type"::Item);
            if IT4GDocLine.findset then
                repeat
                    IT4GDocLinetmp := IT4GDocLine;
                    IT4GDocLinetmp.insert;
                until IT4GDocLine.next = 0;

            DataTableRecRef.GETTABLE(IT4GDocLinetmp);
            UpdateItemDataGrid('', '');
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
        lbLastScanned: label 'Barcode %1 Scanned Item: %2 Variant: %3';
        lbBoxScanned: label 'Box %1 Scanned';
        rSL: Record "IT4G-Doc. Scan";
        NewGUID: Guid;
    begin
        InitBarcode();
        If (GlobalDoc = '') or ((uppercase(copystr(xBarcode, 1, strlen(DocPrefix))) = DocPrefix) and (DocPrefix <> '')) then begin
            if DocPrefix <> '' then xBarcode := copystr(xBarcode, strlen(DocPrefix) + 1);

            GetDoc(xBarcode);
        end else begin
            if uppercase(copystr(xBarcode, 1, strlen(BoxPrefix))) = BoxPrefix then begin
                GlobalBoxNo := xBarcode;
                GlobalText := StrSubstNo(lbBoxScanned, xBarcode);
                exit;
            end else
                IF not rB.GET(xBarcode) then begin
                    //                POSGui.PosMessage(StrSubstNo(lberrorBarcode, xBarcode));
                    GlobalText := StrSubstNo(lberrorBarcode, xBarcode);
                    xBarcode := '';
                    exit;
                end else begin

                    GlobalBarcode := rB."Barcode No.";
                    GlobalItem := rB."Item No.";
                    GlobalVariant := rB."Variant Code";

                    clear(rSL);
                    rSL."Document No." := xDocNo;
                    rSL."Scan Identifier" := NewGUID;
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

                    if not CheckScannedLine(rSL) then exit;

                    GlobalCounter += 1;
                    GlobalText := StrSubstNo(lbLastScanned, xBarcode, rSL."Item No.", rSL."Variant Code");

                end;
            //        POSGui.PosMessage(StrSubstNo(lberrorBarcode + '\TESTTTTTTTT!!!!!!!!!', xBarcode));
        end;
        //        UpdateItemDataGrid();
        UpdateItemDataGrid('', '');

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
        if IT4GDocHeader."Document No." <> '' then begin
            TSUTIL.CreateTSRetryEntry(Database::"IT4G-Doc. Header", IT4GDocHeader."Document No.", '0', '', 1, 0, false, '', '', 0, '');
            TSUTIL.SendUnsentTablesDD3(0, true);
        end;
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

    local Procedure UpdateGlobalBarcode(bBase: Boolean)
    var
        rL: Record "IT4G-Doc. Line";
        rLB: Record "IT4G-Doc. Line Box";
        rLS: Record "IT4G-Doc. Scan";
        rI: record Item;
        rIV: Record "Item Variant";
    begin

        If rI.Get(GlobalItem) then GlobalItemInfo := rI."No." + '  -  ' + rI.Description;
        If rIV.Get(GlobalItem, GlobalVariant) then GlobalVariantInfo := rIV."Code" + '  -  ' + rIV."Description 2";
        Clear(rLS);
        rLS.Setrange("Document No.", GlobalDoc);
        rLS.SetRange("Item No.", GlobalItem);
        rLS.CalcSums("Scanned Quantity", "Scanned Quantity Base");
        if bBase then
            GlobalItemQtyInfo := GlobalItem + ': ' + format(rLS."Scanned Quantity Base")
        else
            GlobalItemQtyInfo := GlobalItem + ': ' + format(rLS."Scanned Quantity");
        rLS.Setrange("Variant Code", GlobalVariant);
        rLS.CalcSums("Scanned Quantity", "Scanned Quantity Base");
        if bBase then
            GlobalVariantQtyInfo := GlobalVariant + ': ' + format(rLS."Scanned Quantity Base")
        else
            GlobalVariantQtyInfo := GlobalVariant + ': ' + format(rLS."Scanned Quantity");
        rLS.Setrange("Variant Code");
        rLS.Setrange("Box No.", GlobalBoxNo);
        rLS.CalcSums("Scanned Quantity", "Scanned Quantity Base");
        if bBase then
            GlobalItemBoxQtyInfo := format(rLS."Scanned Quantity Base")
        else
            GlobalItemBoxQtyInfo := format(rLS."Scanned Quantity");
        rLS.Setrange("Variant Code", GlobalVariant);
        rLS.CalcSums("Scanned Quantity", "Scanned Quantity Base");
        if bBase then
            GlobalVariantBoxQtyInfo := format(rLS."Scanned Quantity Base")
        else
            GlobalVariantBoxQtyInfo := format(rLS."Scanned Quantity");


        Clear(rL);
        rL.Setrange("Document No.", GlobalDoc);
        rL.SetRange("Line Type", rL."Line Type"::Item);
        rL.SetRange(Number, GlobalItem);
        rL.CalcSums(Quantity, "Quantity Base");
        if bBase then
            GlobalItemQtyInfo += '/' + format(rL."Quantity Base")
        else
            GlobalItemQtyInfo += '/' + format(rL.Quantity);
        rL.Setrange("Variant Code", GlobalVariant);
        rL.CalcSums(Quantity, "Quantity Base");
        if bBase then
            GlobalVariantQtyInfo += '/' + format(rL."Quantity Base")
        else
            GlobalVariantQtyInfo += '/' + format(rL.Quantity);

        Clear(rLB);
        rLB.Setrange("Document No.", GlobalDoc);
        rLB.SetRange("Item No.", GlobalItem);
        rLB.CalcSums(Quantity, "Quantity Base");
        if bBase then
            GlobalItemBoxQtyInfo += '/' + format(rLB."Quantity Base")
        else
            GlobalItemBoxQtyInfo += '/' + format(rLB.Quantity);
        rLB.Setrange("Variant Code", GlobalVariant);
        rLB.CalcSums(Quantity, "Quantity Base");
        if bBase then
            GlobalVariantBoxQtyInfo += '/' + format(rLB."Quantity Base")
        else
            GlobalVariantBoxQtyInfo += '/' + format(rLB.Quantity);

    end;

    procedure CheckScannedLine(var rSL: Record "IT4G-Doc. Scan"): Boolean
    var
        rrSL: Record "IT4G-Doc. Line";
    begin

        clear(rrSL);
        rrSL.setrange("Document No.", rSL."Document No.");
        rrSL.SetRange("Line Type", rrSL."Line Type"::Item);
        rrSL.SetRange(Number, rSL."Item No.");
        rrSl.SetRange("Variant Code", rSL."Variant Code");


        if not rrSL.findset then begin
            //TODO: Add setup to ask if permited to insert new lines

            clear(rrSL);
            rrSL."Document No." := rSL."Document No.";
            rrSL."Line Type" := rrSL."Line Type"::Item;
            rrSl."Line Source" := rrSL."Line Source"::Scanning;
            rrSL."Scan Identifier" := CreateGuid();
            rrSL.Number := rSL."Item No.";
            rrSl."Variant Code" := rSL."Variant Code";
            rrSl."Scan Identifier" := CreateGuid();
            rrSL."Unit of Measure" := rSL."Unit of Measure";
            rrSL."Base Unit of Measure" := rSL."Base Unit of Measure";
            rrSL.Quantity := rSL."Scanned Quantity";
            rrSL."Quantity Base" := rSL."Scanned Quantity Base";

            rSl."Scan Identifier" := rrSl."Scan Identifier";
            rSL.Insert();

            rrSL.Insert();
            IT4GDocLinetmp := rrSL;
            IT4GDocLinetmp.insert;
            UpdateItemDataGrid('', '');
        end else begin
            rSl."Scan Identifier" := CreateGuid();
            rSL.Insert();

        end;
        UpdateGlobalBarcode(false);
        exit(true);
    end;
}
