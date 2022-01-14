codeunit 50015 "IT4G-POS Dynamic Menus"
{
    SingleInstance = true;
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    begin
        GlobalRec := Rec;
        case xRelType of
            xRelType::"Tender Type":
                IT4G_DynamicPayMenu(Rec);
        end
    end;

    VAR
        xRelType: Enum "IT4G-Document Relation Type";
        globalRec: Record "LSC POS Menu Line";
        POSTRANS: Codeunit "LSC POS Transaction";
        POSSESSION: Codeunit "LSC POS Session";
        POSCTRL: Codeunit "LSC POS Control Interface";
        TmpMenuHeader: Record "LSC POS Menu Header" temporary;
        TmpMenuLine: Record "LSC POS Menu Line" temporary;
        rPOSTrans: Record "LSC POS Transaction";

    local procedure GetBasicMenuConfiguration(var rows: Integer; var columns: Integer; POSDynamicMenu: Record "LSC POS Dynamic Menu"; var POSMenuHeader: Record "LSC POS Menu Header")
    begin
        rows := 4;
        columns := 4;


        if not POSSESSION.GetPosMenuRec(POSDynamicMenu."Base POS Menu", POSMenuHeader) then
            POSMenuHeader.Init;

        rPOSTrans.get(globalRec."Current-RECEIPT");

        if POSDynamicMenu.Rows = 0 then begin
            if POSMenuHeader.Rows <> 0 then
                rows := POSMenuHeader.Rows
            else
                POSMenuHeader.Rows := rows;
        end else begin
            rows := POSDynamicMenu.Rows;
            POSMenuHeader.Rows := rows;
        end;

        if POSDynamicMenu.Columns = 0 then begin
            if POSMenuHeader.Columns <> 0 then
                columns := POSMenuHeader.Columns
            else
                POSMenuHeader.Columns := columns;
        end else begin
            columns := POSDynamicMenu.Columns;
            POSMenuHeader.Columns := columns;
        end;

        if POSMenuHeader."Popup Width" < 300 then
            POSMenuHeader."Popup Width" := 300;
        if POSMenuHeader."Popup Height" < 300 then
            POSMenuHeader."Popup Height" := 300;
    end;

    local procedure SetBackCommand(POSDynamicMenu: Record "LSC POS Dynamic Menu"; var tmpMenuLine: Record "LSC POS Menu Line" temporary)
    var
        Command: Code[20];
        Parameter: Text[100];
    begin
        case POSDynamicMenu."Display Section" of
            POSDynamicMenu."Display Section"::"Main Menu":
                begin
                    Command := 'MENU';
                    Parameter := POSSESSION.GetSalesMenu;
                end;
            POSDynamicMenu."Display Section"::"Additional Menu 1":
                begin
                    Command := 'MENU1';
                    Parameter := POSSESSION.GetAdd1Menu;
                end;
            POSDynamicMenu."Display Section"::"Additional Menu 2":
                begin
                    Command := 'MENU2';
                    Parameter := POSSESSION.GetAdd2Menu;
                end;
            POSDynamicMenu."Display Section"::"Additional Menu 3":
                begin
                    Command := 'MENU3';
                    Parameter := POSSESSION.GetAdd3Menu;
                end;
            else begin
                    Command := 'CANCEL2';
                    Parameter := '';
                end;
        end;
        if POSDynamicMenu."Menu Exit" = POSDynamicMenu."Menu Exit"::"Exit after Selection" then begin
            TmpMenuLine.Validate("Post Command", Command);
            TmpMenuLine."Post Parameter" := Parameter;
        end else begin
            TmpMenuLine.Validate(Command, Command);
            TmpMenuLine.Parameter := Parameter;
        end;
    end;

    procedure IT4G_DynamicPayMenu(var pPosMenuLine: Record "LSC POS Menu Line")
    var
        BasePOSMenuHeader: Record "LSC POS Menu Header";
        POSDynamicMenu: Record "LSC POS Dynamic Menu";
        SortingBuffer: Record "LSC Sorting Buffer" temporary;
        POSVIEW: Codeunit "LSC POS View";
        MenuID: Code[20];
        cols: Integer;
        rows: Integer;
        counter: Integer;
        PageCnt: Integer;
        ButtonPadControlID: Text;
        RecRef: RecordRef;
        RecRef2: RecordRef;
        RecID: RecordID;
        FieldRef: FieldRef;
        tmpMenuHeader: Record "LSC POS Menu Header" temporary;
        tmpMenuLine: Record "LSC POS Menu Line" temporary;
        cC: Codeunit "IT4G-LS Functions";
        rDocReltmp: record "IT4G-LS Document Relations" temporary;
        rTTS: Record "LSC Tender Type Setup";
        rStore: Record "LSC Store";
        rDoc: Record "IT4G-LS Document";
    begin
        if not POSDynamicMenu.get(pPosMenuLine.Parameter) then
            POSDynamicMenu.get('PAYMENT');

        GetBasicMenuConfiguration(rows, cols, POSDynamicMenu, BasePOSMenuHeader);

        if BasePOSMenuHeader."Pre-Execute Total" then POSTRANS.TotalPressed(false);

        TmpMenuHeader.DeleteAll;
        TmpMenuLine.DeleteAll;
        counter := 0;

        MenuID := CopyStr('$DYNMENU$' + POSDynamicMenu.ID, 1, MaxStrLen(MenuID));

        if POSDynamicMenu."Menu Exit" in [POSDynamicMenu."Menu Exit"::"Exit First Button", POSDynamicMenu."Menu Exit"::"Exit First and Last Button"] then
            if POSDynamicMenu."Display Type" <> POSDynamicMenu."Display Type"::"Pop-up" then begin
                counter += 1;
                TmpMenuLine.Init;
                TmpMenuLine."Profile ID" := '##DEFAULT';
                TmpMenuLine."Menu ID" := MenuID;
                TmpMenuLine."Key No." := counter;
                TmpMenuLine.Description := 'Back';
                SetBackCommand(POSDynamicMenu, TmpMenuLine);
                TmpMenuLine.Insert;
            end;

        cC.GetDocumentRelation(rDocReltmp, xRelType::"Tender Type", rPOSTrans."Document Code", POSSESSION.StoreNo(), POSSESSION.TerminalNo(), POSSESSION.StaffID());
        if rDocReltmp.findset then
            repeat
                counter += 1;
                TmpMenuLine.Init;
                TmpMenuLine."Profile ID" := '##DEFAULT';
                TmpMenuLine."Menu ID" := MenuID;
                TmpMenuLine."Key No." := counter;
                TmpMenuLine.Command := 'TENDER_K';
                TmpMenuLine."Parameter Type" := TmpMenuLine."Parameter Type"::"Tender Type";
                TmpMenuLine.Parameter := rDocReltmp."Relation Code";

                case xRelType of
                    xRelType::"Tender Type":
                        if rTTS.get(rDocReltmp."Relation Code") then
                            TmpMenuLine.Description := rTTS.Description;
                    xRelType::Store:
                        if rStore.get(rDocReltmp."Relation Code") then
                            TmpMenuLine.Description := rStore.Name;
                    xRelType::Document:
                        if rDoc.get(rDocReltmp."Relation Code") then
                            TmpMenuLine.Description := rDoc.Description;
                end;

                if POSDynamicMenu."Menu Exit" = POSDynamicMenu."Menu Exit"::"Exit after Selection" then begin
                    SetBackCommand(POSDynamicMenu, TmpMenuLine);
                end;

                TmpMenuLine.Insert();

            until rDocReltmp.Next = 0;

        if POSDynamicMenu."Menu Exit" in [POSDynamicMenu."Menu Exit"::"Exit Last Button", POSDynamicMenu."Menu Exit"::"Exit First and Last Button"] then
            if POSDynamicMenu."Display Type" <> POSDynamicMenu."Display Type"::"Pop-up" then begin
                counter += 1;
                TmpMenuLine.Init;
                TmpMenuLine."Profile ID" := '##DEFAULT';
                TmpMenuLine."Menu ID" := MenuID;
                TmpMenuLine."Key No." := counter;
                TmpMenuLine.Description := 'Back';
                SetBackCommand(POSDynamicMenu, TmpMenuLine);
                TmpMenuLine.Insert;
            end;

        PageCnt := Round(counter / (rows * cols), 1, '>');

        while counter < PageCnt * rows * cols do begin
            counter += 1;
            TmpMenuLine.Init;
            TmpMenuLine."Profile ID" := '##DEFAULT';
            TmpMenuLine."Menu ID" := MenuID;
            TmpMenuLine."Key No." := counter;
            TmpMenuLine.Insert;
        end;

        TmpMenuHeader.DeleteAll;
        TmpMenuHeader.Init;
        TmpMenuHeader.TransferFields(BasePOSMenuHeader, false);
        TmpMenuHeader."Profile ID" := '##DEFAULT';
        TmpMenuHeader."Menu ID" := MenuID;
        TmpMenuHeader."Map Enter To" := 'TENDER_K';
        TmpMenuHeader.Pages := PageCnt;
        tmpMenuHeader."Pre-Execute Total" := true;
        TmpMenuHeader.Insert;


        POSCTRL.UploadMenuHeaderRec(TmpMenuHeader, TmpMenuHeader."Profile ID", TmpMenuHeader."Menu ID");
        POSCTRL.UploadMenuLineRec(TmpMenuLine, TmpMenuHeader."Profile ID", TmpMenuHeader."Menu ID", '');

        case POSDynamicMenu."Display Section" of
            POSDynamicMenu."Display Section"::"Main Menu":
                ButtonPadControlID := POSSESSION.MainMenuButtonPadID();
            POSDynamicMenu."Display Section"::"Additional Menu 1":
                ButtonPadControlID := POSSESSION.AddMenu1ButtonPadID();
            POSDynamicMenu."Display Section"::"Additional Menu 2":
                ButtonPadControlID := POSSESSION.AddMenu2ButtonPadID();
            POSDynamicMenu."Display Section"::"Additional Menu 3":
                ButtonPadControlID := POSSESSION.AddMenu3ButtonPadID();
        end;
        case POSDynamicMenu."Display Type" of
            POSDynamicMenu."Display Type"::"On Top of Menu":
                POSCTRL.StackMenu(TmpMenuHeader."Menu ID", ButtonPadControlID);
            POSDynamicMenu."Display Type"::"Replace Menu":
                POSCTRL.ShowMenu(TmpMenuHeader."Menu ID", ButtonPadControlID);
            POSDynamicMenu."Display Type"::"Pop-up":
                POSCTRL.PopupMenu(TmpMenuHeader."Menu ID");
        end;
        POSVIEW.MessageBeep(' ');
    end;

    procedure SetRelType(xType: Enum "IT4G-Document Relation Type")
    begin
        xRelType := xType;
    end;
}