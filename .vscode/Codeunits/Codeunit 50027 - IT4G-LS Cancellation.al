codeunit 50027 "IT4G-LS Cancellation"
{
    Procedure CancelLSDoc(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer; xRetTxt: Text): boolean
    var
        Trans: Record "LSC Transaction Header";
        newTrans: Record "LSC Transaction Header";
        SE: Record "LSC Trans. Sales Entry";
        newSE: Record "LSC Trans. Sales Entry";
        PE: Record "LSC Trans. Payment Entry";
        newPE: Record "LSC Trans. Payment Entry";
        IEE: Record "LSC Trans. Inc./Exp. Entry";
        newIEE: Record "LSC Trans. Inc./Exp. Entry";
        IE: Record "LSC Trans. Infocode Entry";
        newIE: Record "LSC Trans. Infocode Entry";
        CE: Record "LSC Trans. Coupon Entry";
        newCE: Record "LSC Trans. Coupon Entry";
        TE: Record "LSC Trans. Tender Declar. Entr";
        newTE: Record "LSC Trans. Tender Declar. Entr";
        TI: Record "LSC Trans. Inventory Entry";
        newTI: Record "LSC Trans. Inventory Entry";
        PCE: Record "LSC POS Card Entry";
        newPCE: Record "LSC POS Card Entry";
        TC: Record "LSC Trans. Cash Declaration";
        newTC: Record "LSC Trans. Cash Declaration";
        TS: Record "LSC Trans. Safe Entry";
        newTS: Record "LSC Trans. Safe Entry";
        MM: Record "LSC Trans. Mix & Match Entry";
        newMM: Record "LSC Trans. Mix & Match Entry";
        TransHospitalityEntry: Record "LSC Trans. Hospitality Entry";
        newTransHospitalityEntry: Record "LSC Trans. Hospitality Entry";
        TOH: Record "LSC Transaction Order Header";
        newTOH: Record "LSC Transaction Order Header";
        TOE: Record "LSC Transaction Order Entry";
        newTOE: Record "LSC Transaction Order Entry";
        TransDiscEntry: Record "LSC Trans. Discount Entry";
        newTransDiscEntry: Record "LSC Trans. Discount Entry";
        TransDiscBenefitEntry: Record "LSC Trans. Disc. Benefit Entry";
        newTransDiscBenefitEntry: Record "LSC Trans. Disc. Benefit Entry";
        TransOrderDisc: Record "LSC Transaction Order Discount";
        newTransOrderDisc: Record "LSC Transaction Order Discount";
        TransPointEntry_l: Record "LSC Trans. Point Entry";
        newTransPointEntry_l: Record "LSC Trans. Point Entry";
        TransSalesTaxEntry: Record "LSC Trans. SalesTax Entry";
        newTransSalesTaxEntry: Record "LSC Trans. SalesTax Entry";
        TransInvAdjmtEntry: Record "LSC Trans. Inv. Adjmt. Entry";
        newTransInvAdjmtEntry: Record "LSC Trans. Inv. Adjmt. Entry";
        TransInvAdjmtEntrySt: Record "LSC Trans. Inv Adjmt. Entry St";
        newTransInvAdjmtEntrySt: Record "LSC Trans. Inv Adjmt. Entry St";
        TransSignature: Record "LSC Transaction Signature";
        newTransSignature: Record "LSC Transaction Signature";
        TSUtil: Codeunit "LSC POS Trans. Server Utility";
        CancelTransNo: Integer;
        rDoc: Record "IT4G-LS Document";
        lblnoCancel: Label 'No cancellation Specified for Document %1';
        cC: Codeunit "IT4G-LS Functions";
        enSerType: enum "IT4G-DocSeriesRetType";
        cNSM: Codeunit NoSeriesManagement;
        lblSeriesNotFound: label 'No Document series setup found for Document Code ';
        rTransDoc: Record "IT4G-Doc. Header";

    Begin
        //TODO: Check if you can cancel the decument        
        //TODO: If Cancel refund return related trans
        //TODO: Check for Coupons etc

        Clear(Trans);
        Trans.setrange("Store No.", xStore);
        Trans.setrange("POS Terminal No.", xPOS);
        If Trans.FindLast() then CancelTransNo := Trans."Transaction No." + 1;

        Trans.Get(xStore, xPOS, xTransNo);
        rDoc.get(Trans."Document Code");
        If rDoc."Cancel Document Code" = '' then begin
            xRetTxt := StrSubstNo(lblnoCancel, rDoc.Code);
            exit(false);
        end;

        NewTrans.TransferFields(Trans);
        newTrans."Transaction No." := CancelTransNo;
        newTrans."Cancellation Type" := newTrans."Cancellation Type"::Cancellation;
        newTrans."Cancellation Entry No." := Trans."Transaction No.";

        Trans."Cancellation Type" := Trans."Cancellation Type"::Cancelled;
        Trans."Cancellation Entry No." := CancelTransNo;
        Trans.Modify;

        //TODO: Assign new Document etc   
        newTrans."Document Code" := rDoc."Cancel Document Code";
        rDoc.Get(newTrans."Document Code");
        newTrans."Post Series" := cC.GetDocumentSeries(rDoc."Code", newTrans."Store No.", newTrans."POS Terminal No.", newTrans.Date, enSerType::"No. Series");

        if newTrans."Post Series" = '' then error(lblSeriesNotFound + newTrans."Document Code");
        newTrans."Document No." := cNSM.GetNextNo(newTrans."Post Series", Today, true);

        newTrans."Net Amount" := -newTrans."Net Amount";
        newTrans."Cost Amount" := -newTrans."Cost Amount";
        newTrans."Gross Amount" := -newTrans."Gross Amount";
        newTrans."Payment" := -newTrans."Payment";
        newTrans."Discount Amount" := -newTrans."Discount Amount";
        newTrans."Customer Discount" := -newTrans."Customer Discount";
        newTrans."Total Discount" := -newTrans."Total Discount";
        newTrans."No. of Items" := -newTrans."No. of Items";
        newTrans.Date := Today;
        newTrans.Time := Time;
        newTrans.Insert();

        SE.SetRange("Store No.", xStore);
        SE.SetRange("POS Terminal No.", xPOS);
        SE.SetRange("Transaction No.", xTransNo);
        If SE.findset() then
            repeat
                newSE.TransferFields(SE);
                newSE."Transaction No." := CancelTransNo;
                newSE.Date := newTrans.Date;
                newSE.Time := newTrans.Time;
                newSE."Receipt No." := newTrans."Receipt No.";

                newSE."Quantity" := -newSE."Quantity";
                newSE."Discount Amount" := -newSE."Discount Amount";
                newSE."Cost Amount" := -newSE."Cost Amount";
                newSE."Net Amount" := -newSE."Net Amount";
                newSE."VAT Amount" := -newSE."VAT Amount";
                newSE."Total Rounded Amt." := -newSE."Total Rounded Amt.";
                newSE."Member Points" := -newSE."Member Points";

                newSE.Insert;
            until SE.next() = 0;

        PE.SetRange("Store No.", xStore);
        PE.SetRange("POS Terminal No.", xPOS);
        PE.SetRange("Transaction No.", xTransNo);
        If PE.findset() then
            repeat
                newPE.TransferFields(PE);
                newPE."Transaction No." := CancelTransNo;
                newPE.Date := newTrans.Date;
                newPE.Time := newTrans.Time;
                newPE."Receipt No." := newTrans."Receipt No.";

                newPE."Amount Tendered" := -newPE."Amount Tendered";
                newPE."Amount in Currency" := -newPE."Amount in Currency";

                newPE.Insert;
            until PE.next() = 0;

        IEE.SetRange("Store No.", xStore);
        IEE.SetRange("POS Terminal No.", xPOS);
        IEE.SetRange("Transaction No.", xTransNo);
        If IEE.findset() then
            repeat
                newIEE.TransferFields(IEE);
                newIEE."Transaction No." := CancelTransNo;
                newIEE.Date := newTrans.Date;
                newIEE.Time := newTrans.Time;
                newIEE.Insert;
            until IEE.next() = 0;

        IE.SetRange("Store No.", xStore);
        IE.SetRange("POS Terminal No.", xPOS);
        IE.SetRange("Transaction No.", xTransNo);
        If IE.findset() then
            repeat
                newIE.TransferFields(IE);
                newIE."Transaction No." := CancelTransNo;
                newIE.Date := newTrans.Date;
                newIE.Time := newTrans.Time;

                newIE.Insert;
            until IE.next() = 0;

        CE.SetRange("Store No.", xStore);
        CE.SetRange("POS Terminal No.", xPOS);
        CE.SetRange("Transaction No.", xTransNo);
        If CE.findset() then
            repeat
                newCE.TransferFields(CE);
                newCE."Transaction No." := CancelTransNo;
                newCE.Date := newTrans.Date;
                newCE."Receipt No." := newTrans."Receipt No.";

                newCE.Insert;
            until CE.next() = 0;

        TE.SetRange("Store No.", xStore);
        TE.SetRange("POS Terminal No.", xPOS);
        TE.SetRange("Transaction No.", xTransNo);
        If TE.findset() then
            repeat
                newTE.TransferFields(TE);
                newTE."Transaction No." := CancelTransNo;
                newTE.Date := newTrans.Date;
                newTE.Time := newTrans.Time;

                newTE.Insert;
            until TE.next() = 0;

        TI.SetRange("Store No.", xStore);
        TI.SetRange("POS Terminal No.", xPOS);
        TI.SetRange("Transaction No.", xTransNo);
        If TI.findset() then
            repeat
                newTI.TransferFields(TI);
                newTI."Transaction No." := CancelTransNo;
                newTI."Receipt No." := newTrans."Receipt No.";
                newTI.Date := newTrans.Date;
                newTI.Time := newTrans.Time;
                newTI.Insert;
            until TI.next() = 0;

        PCE.SetRange("Store No.", xStore);
        PCE.SetRange("POS Terminal No.", xPOS);
        PCE.SetRange("Transaction No.", xTransNo);
        If PCE.findset() then
            repeat
                newPCE.TransferFields(PCE);
                newPCE."Transaction No." := CancelTransNo;
                newPCE."Receipt No." := newTrans."Receipt No.";
                newPCE.Date := newTrans.Date;
                newPCE.Time := newTrans.Time;
                newPCE.Insert;
            until PCE.next() = 0;

        TC.SetRange("Store No.", xStore);
        TC.SetRange("POS Terminal No.", xPOS);
        TC.SetRange("Transaction No.", xTransNo);
        If TC.findset() then
            repeat
                newTC.TransferFields(TC);
                newTC."Transaction No." := CancelTransNo;
                newTC."Receipt No." := newTrans."Receipt No.";
                newTC.Insert;
            until TC.next() = 0;

        TS.SetRange("Store No.", xStore);
        TS.SetRange("POS Terminal No.", xPOS);
        TS.SetRange("Transaction No.", xTransNo);
        If TS.findset() then
            repeat
                newTS.TransferFields(TS);
                newTS."Transaction No." := CancelTransNo;
                newTS."Receipt No." := newTrans."Receipt No.";
                newTS.Date := newTrans.Date;
                newTS.Time := newTrans.Time;
                newTS.Insert;
            until TS.next() = 0;

        MM.SetRange("Store No.", xStore);
        MM.SetRange("POS Terminal No.", xPOS);
        MM.SetRange("Transaction No.", xTransNo);
        If MM.findset() then
            repeat
                newMM.TransferFields(MM);
                newMM."Transaction No." := CancelTransNo;
                newMM.Date := newTrans.Date;
                newMM.Time := newTrans.Time;
                newMM.Insert;
            until MM.next() = 0;

        TransHospitalityEntry.SetRange("Store No.", xStore);
        TransHospitalityEntry.SetRange("POS Terminal No.", xPOS);
        TransHospitalityEntry.SetRange("Transaction No.", xTransNo);
        If TransHospitalityEntry.findset() then
            repeat
                newTransHospitalityEntry.TransferFields(TransHospitalityEntry);
                newTransHospitalityEntry."Transaction No." := CancelTransNo;
                newTransHospitalityEntry."Receipt No." := newTrans."Receipt No.";
                newTransHospitalityEntry.Insert;
            until TransHospitalityEntry.next() = 0;
        //------------Transaction Order !!!!!!!!!!!!!!! -Start
        TOH.SetRange("Store No.", xStore);
        TOH.SetRange("POS Terminal No.", xPOS);
        TOH.SetRange("Transaction No.", xTransNo);
        If TOH.findset() then
            repeat
                newTOH.TransferFields(TOH);
                newTOH."Transaction No." := CancelTransNo;
                newTOH.Insert;
            until TOH.next() = 0;

        TOE.SetRange("Store No.", xStore);
        TOE.SetRange("POS Terminal No.", xPOS);
        TOE.SetRange("Transaction No.", xTransNo);
        If TOE.findset() then
            repeat
                newTOE.TransferFields(TOE);
                newTOE."Transaction No." := CancelTransNo;
                newTOE.Insert;
            until TOE.next() = 0;

        //------------Transaction Order !!!!!!!!!!!!!!! -End

        TransDiscEntry.SetRange("Store No.", xStore);
        TransDiscEntry.SetRange("POS Terminal No.", xPOS);
        TransDiscEntry.SetRange("Transaction No.", xTransNo);
        If TransDiscEntry.findset() then
            repeat
                newTransDiscEntry.TransferFields(TransDiscEntry);
                newTransDiscEntry."Transaction No." := CancelTransNo;
                newTransDiscEntry.Insert;
            until TransDiscEntry.next() = 0;

        TransDiscBenefitEntry.SetRange("Store No.", xStore);
        TransDiscBenefitEntry.SetRange("POS Terminal No.", xPOS);
        TransDiscBenefitEntry.SetRange("Transaction No.", xTransNo);
        If TransDiscBenefitEntry.findset() then
            repeat
                newTransDiscBenefitEntry.TransferFields(TransDiscBenefitEntry);
                newTransDiscBenefitEntry."Transaction No." := CancelTransNo;
                newTransDiscBenefitEntry.Insert;
            until TransDiscBenefitEntry.next() = 0;

        TransOrderDisc.SetRange("Store No.", xStore);
        TransOrderDisc.SetRange("POS Terminal No.", xPOS);
        TransOrderDisc.SetRange("Transaction No.", xTransNo);
        If TransOrderDisc.findset() then
            repeat
                newTransOrderDisc.TransferFields(TransOrderDisc);
                newTransOrderDisc."Transaction No." := CancelTransNo;
                newTransOrderDisc.Insert;
            until TransOrderDisc.next() = 0;

        TransPointEntry_l.SetRange("Store No.", xStore);
        TransPointEntry_l.SetRange("POS Terminal No.", xPOS);
        TransPointEntry_l.SetRange("Transaction No.", xTransNo);
        If TransPointEntry_l.findset() then
            repeat
                newTransPointEntry_l.TransferFields(TransPointEntry_l);
                newTransPointEntry_l."Transaction No." := CancelTransNo;
                newTransPointEntry_l.Insert;
            until TransPointEntry_l.next() = 0;

        TransSalesTaxEntry.SetRange("Store No.", xStore);
        TransSalesTaxEntry.SetRange("POS Terminal No.", xPOS);
        TransSalesTaxEntry.SetRange("Transaction No.", xTransNo);
        If TransSalesTaxEntry.findset() then
            repeat
                newTransSalesTaxEntry.TransferFields(TransSalesTaxEntry);
                newTransSalesTaxEntry."Transaction No." := CancelTransNo;
                newTransSalesTaxEntry.Insert;
            until TransSalesTaxEntry.next() = 0;

        TransInvAdjmtEntry.SetRange("Store No.", xStore);
        TransInvAdjmtEntry.SetRange("POS Terminal No.", xPOS);
        TransInvAdjmtEntry.SetRange("Transaction No.", xTransNo);
        If TransInvAdjmtEntry.findset() then
            repeat
                newTransInvAdjmtEntry.TransferFields(TransInvAdjmtEntry);
                newTransInvAdjmtEntry."Transaction No." := CancelTransNo;
                newTransInvAdjmtEntry.Insert;
            until TransInvAdjmtEntry.next() = 0;

        TransInvAdjmtEntrySt.SetRange("Store No.", xStore);
        TransInvAdjmtEntrySt.SetRange("POS Terminal No.", xPOS);
        TransInvAdjmtEntrySt.SetRange("Transaction No.", xTransNo);
        If TransInvAdjmtEntrySt.findset() then
            repeat
                newTransInvAdjmtEntrySt.TransferFields(TransInvAdjmtEntrySt);
                newTransInvAdjmtEntrySt."Transaction No." := CancelTransNo;
                newTransInvAdjmtEntrySt.Insert;
            until TransInvAdjmtEntrySt.next() = 0;

        TransSignature.SetRange("Store No.", xStore);
        TransSignature.SetRange("POS Terminal No.", xPOS);
        TransSignature.SetRange("Transaction No.", xTransNo);
        If TransSignature.findset() then
            repeat
                newTransSignature.TransferFields(TransSignature);
                newTransSignature."Transaction No." := CancelTransNo;
                newTransSignature.Insert;
            until TransSignature.next() = 0;


        //TODO: Update related Documents
        if rTransDoc.get(Trans."Document No.") then begin
            rTransDoc.Validate(Status, rTransDoc.Status::Canceled);
        end;
        //TODO: Send NewTrans and all related Transactions
        TSUtil.SendAtEndOfTransaction(Trans);
        TSUtil.SendAtEndOfTransaction(newTrans);

    End;

}
