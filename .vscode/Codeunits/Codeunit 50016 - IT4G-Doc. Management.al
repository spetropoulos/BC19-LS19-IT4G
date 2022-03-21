codeunit 50016 "IT4G-Doc. Management"
{
    trigger OnRun()
    begin
    end;

    var

    procedure LSCreateIT4GDoc(
        xSTore: Code[10];
        xPOS: Code[10];
        xTransNo: Integer)
    var
        lblErrSetup: Label 'You must specify %1 in LS Document Code Setup for Document Code %2';
        rTH: Record "LSC Transaction Header";
        rTSE: Record "LSC Trans. Sales Entry";
        rTIE: Record "LSC Trans. Inventory Entry";
        rTPE: Record "LSC Trans. Payment Entry";

        rDoc: Record "IT4G-LS Document";

        rDH: Record "IT4G-Doc. Header";
        rDL: Record "IT4G-Doc. Line";
        rI: Record Item;

    begin
        if not rTH.Get(xSTore, xPOS, xTransNo) then exit;
        if not rDoc.get(rTH."Document Code") then exit;

        if not rDoc."Create IT4G-Doc." then exit;

        if rDoc."IT4G-Doc. Code" = '' then error(StrSubstNo(lblErrSetup, rDoc.FieldCaption("IT4G-Doc. Code"), rDoc.Code));

        clear(rDH);
        rDH."Document No." := rTH."Document No.";
        rDH.Date := rTh.date;
        rDH."From Store" := rTH."Store No.";
        rDH."To Store" := rTH."To Store";
        rDH."Destination Store" := '';
        rDH."Created by Store No." := xSTore;
        rDH."Created by POS Terminal No." := xPOS;
        rDH."Created by Transaction No." := xTransNo;
        rDH."Created by Document No." := rTH."Document No.";
        rDH."Created by System" := rDH."Created by System"::"LS Retail";
        rDH."Created On" := CurrentDateTime;
        rDH."Created by User" := UserId;
        rDH."Created by Staff" := rTH."Staff ID";
        rDh."Created on Host" := '';

        clear(rTSE);
        rTSE.setrange("Store No.", xStore);
        rTSE.setrange("POS Terminal No.", xPOS);
        rTSE.setrange("Transaction No.", xTransNo);
        If rTSE.Findset then
            repeat
                rI.get(rTSE."Item No.");

                clear(rDL);
                rDL."Document No." := rDH."Document No.";
                rDL."Line No." := rTSE."Line No.";
                rDL."Line Type" := rDL."Line Type"::"Trans. Sales Entry";
                rDL.Number := rTSE."Item No.";
                rDL."Variant Code" := rTSE."Variant Code";
                rDL."Unit of Measure" := rTSE."Unit of Measure";
                rDL."Base Unit of Measure" := rI."Base Unit of Measure";
                rDL.Quantity := rTSE."UOM Quantity";
                rDL."Quantity Base" := rTSE.Quantity;
                rDL.Insert;

                rDH."Number of Items" += rDL."Quantity Base";
                rDH."Number of Lines" += 1;

            until rTSE.next = 0;

        clear(rTIE);
        rTIE.setrange("Store No.", xStore);
        rTIE.setrange("POS Terminal No.", xPOS);
        rTIE.setrange("Transaction No.", xTransNo);
        If rTIE.Findset then
            repeat
                rI.get(rTIE."Item No.");

                clear(rDL);
                rDL."Document No." := rDH."Document No.";
                rDL."Line No." := rTIE."Line No.";
                rDL."Line Type" := rDL."Line Type"::"Trans. Inventory Entry";
                rDL.Number := rTIE."Item No.";
                rDL."Variant Code" := rTIE."Variant Code";
                rDL."Unit of Measure" := rTIE."Unit of Measure";
                rDL."Base Unit of Measure" := rI."Base Unit of Measure";
                rDL.Quantity := rTIE."UOM Quantity";
                rDL."Quantity Base" := rTIE.Quantity;
                rDL.Insert;

                rDH."Number of Items" += rDL."Quantity Base";
                rDH."Number of Lines" += 1;

            until rTIE.next = 0;

        clear(rTPE);
        rTPE.setrange("Store No.", xStore);
        rTPE.setrange("POS Terminal No.", xPOS);
        rTPE.setrange("Transaction No.", xTransNo);
        If rTPE.Findset then
            repeat
                clear(rDL);
                rDL."Document No." := rDH."Document No.";
                rDL."Line No." := rTPE."Line No.";
                rDL."Line Type" := rDL."Line Type"::Payment;
                rDL.Number := rTPE."Tender Type";
                rDl.Amount := rTPE."Amount Tendered";
                rDL.Insert;

                rDH."Number of Lines" += 1;

            until rTPE.next = 0;

        rDH.Insert(TRUE);

    end;
}

