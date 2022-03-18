xmlport 50004 GetTransactionIT4GXML
{
    Caption = 'GetTransactionIT4GXML';
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(RootGetTransaction)
        {
            tableelement("Transaction Header"; "LSC Transaction Header")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionHeader';
                UseTemporary = true;
                fieldelement(TransactionNo; "Transaction Header"."Transaction No.")
                {
                }
                fieldelement(TransactionType; "Transaction Header"."Transaction Type")
                {
                }
                fieldelement(ReceiptNo; "Transaction Header"."Receipt No.")
                {
                }
                fieldelement(VATBusPostingGroup; "Transaction Header"."VAT Bus.Posting Group")
                {
                }
                fieldelement(StoreNo; "Transaction Header"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Transaction Header"."POS Terminal No.")
                {
                }
                fieldelement(CreatedonPOSTerminal; "Transaction Header"."Created on POS Terminal")
                {
                }
                fieldelement(StaffID; "Transaction Header"."Staff ID")
                {
                }
                fieldelement(Date; "Transaction Header".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(OriginalDate; "Transaction Header"."Original Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Transaction Header".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Transaction Header"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Transaction Header"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(WrongShift; "Transaction Header"."Wrong Shift")
                {
                }
                fieldelement(InfocodeDiscGroup; "Transaction Header"."Infocode Disc. Group")
                {
                }
                fieldelement(CustomerNo; "Transaction Header"."Customer No.")
                {
                }
                fieldelement(TransactionCode; "Transaction Header"."Transaction Code")
                {
                }
                fieldelement(TransSalePmtDiff; "Transaction Header"."Trans. Sale/Pmt. Diff.")
                {
                }
                fieldelement(NetAmount; "Transaction Header"."Net Amount")
                {
                }
                fieldelement(CostAmount; "Transaction Header"."Cost Amount")
                {
                }
                fieldelement(GrossAmount; "Transaction Header"."Gross Amount")
                {
                }
                fieldelement(Payment; "Transaction Header".Payment)
                {
                }
                fieldelement(DiscountAmount; "Transaction Header"."Discount Amount")
                {
                }
                fieldelement(CustomerDiscount; "Transaction Header"."Customer Discount")
                {
                }
                fieldelement(TotalDiscount; "Transaction Header"."Total Discount")
                {
                }
                fieldelement(NoofItems; "Transaction Header"."No. of Items")
                {
                }
                fieldelement(AmounttoAccount; "Transaction Header"."Amount to Account")
                {
                }
                fieldelement(Rounded; "Transaction Header".Rounded)
                {
                }
                fieldelement(CustomerDiscGroup; "Transaction Header"."Customer Disc. Group")
                {
                }
                fieldelement(EntryStatus; "Transaction Header"."Entry Status")
                {
                }
                fieldelement(NoofInvoices; "Transaction Header"."No. of Invoices")
                {
                }
                fieldelement(NoofItemLines; "Transaction Header"."No. of Item Lines")
                {
                }
                fieldelement(StatementCode; "Transaction Header"."Statement Code")
                {
                }
#pragma warning disable AL0432
                //Not able to obsolete
                fieldelement("StatementNo-NOTUSED"; "Transaction Header"."Statement No. - NOT USED")
#pragma warning restore AL0432
                {
                    MinOccurs = Zero;
                }
                fieldelement(RefundReceiptNo; "Transaction Header"."Refund Receipt No.")
                {
                }
                fieldelement(IncomeExpAmount; "Transaction Header"."Income/Exp. Amount")
                {
                }
                fieldelement(ToAccount; "Transaction Header"."To Account")
                {
                }
                fieldelement(NoofPaymentLines; "Transaction Header"."No. of Payment Lines")
                {
                }
                fieldelement(SaleIsReturnSale; "Transaction Header"."Sale Is Return Sale")
                {
                }
                fieldelement(TransIsMixedSaleRefund; "Transaction Header"."Trans. Is Mixed Sale/Refund")
                {
                }
                fieldelement(RevertedGrossAmount; "Transaction Header"."Reverted Gross Amount")
                {
                }
                fieldelement(Counter; "Transaction Header".Counter)
                {
                }
                fieldelement(TimewhenTotalPressed; "Transaction Header"."Time when Total Pressed")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TimewhenTransClosed; "Transaction Header"."Time when Trans. Closed")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TransCurrency; "Transaction Header"."Trans. Currency")
                {
                }
                fieldelement(ItemsPosted; "Transaction Header"."Items Posted")
                {
                }
                fieldelement(PostasShipment; "Transaction Header"."Post as Shipment")
                {
                }
                fieldelement(SafeEntryNo; "Transaction Header"."Safe Entry No.")
                {
                }
                fieldelement(SafeCode; "Transaction Header"."Safe Code")
                {
                }
                fieldelement(ManagerID; "Transaction Header"."Manager ID")
                {
                }
                fieldelement(TableNo; "Transaction Header"."Table No.")
                {
                }
                fieldelement(NoofCovers; "Transaction Header"."No. of Covers")
                {
                }
                fieldelement(SplitNumber; "Transaction Header"."Split Number")
                {
                }
                fieldelement(Comment; "Transaction Header".Comment)
                {
                }
                fieldelement("Sell-toContactNo"; "Transaction Header"."Sell-to Contact No.")
                {
                }
                fieldelement(GiftRegistrationNo; "Transaction Header"."Gift Registration No.")
                {
                }
                fieldelement(MemberCardNo; "Transaction Header"."Member Card No.")
                {
                }
                fieldelement(SalesType; "Transaction Header"."Sales Type")
                {
                }
                fieldelement(StartingPointBalance; "Transaction Header"."Starting Point Balance")
                {
                }
                fieldelement(ContainsForecourtItems; "Transaction Header"."Contains Forecourt Items")
                {
                }
                fieldelement(ApplytoDocNo; "Transaction Header"."Apply to Doc. No.")
                {
                }
                fieldelement(SourceType; "Transaction Header"."Source Type")
                {
                }
                fieldelement(OpenDrawer; "Transaction Header"."Open Drawer")
                {
                }
                fieldelement(Replicated; "Transaction Header".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "Transaction Header"."Replication Counter")
                {
                }
                fieldelement(RetrievedfromReceiptNo; "Transaction Header"."Retrieved from Receipt No.")
                {
                }
                fieldelement("Z-ReportID"; "Transaction Header"."Z-Report ID")
                {
                }
                fieldelement("Y-ReportID"; "Transaction Header"."Y-Report ID")
                {
                }
                fieldelement(CustomerOrderNo; "Transaction Header"."Customer Order ID")
                {
                }
                fieldelement(PlaybackRecordingID; "Transaction Header"."Playback Recording ID")
                {
                }
                fieldelement(PlaybackEntryNo; "Transaction Header"."Playback Entry No.")
                {
                }
#pragma warning disable AL0432
                //Not able to obsolete
                fieldelement(BITimestamp; "Transaction Header"."BI Timestamp")
#pragma warning disable AL0432
                {
                    MinOccurs = Zero;
                }
                fieldelement(CustomerOrder; "Transaction Header"."Customer Order")
                {
                }
                fieldelement(GenBusPostingGroup; "Transaction Header"."Gen. Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(OverridePLBItem; "Transaction Header"."Override PLB Item")
                {
                    MinOccurs = Zero;
                }
                fieldelement(OverrideStaffID; "Transaction Header"."Override Staff ID")
                {
                    MinOccurs = Zero;
                }
                fieldelement(OverrideDateTime; "Transaction Header"."Override Date Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RestrictedFlag; "Transaction Header".RestrictedFlag)
                {
                }
                fieldelement(TaxAreaCode; "Transaction Header"."Tax Area Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(WICTransaction; "Transaction Header"."WIC Transaction")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxLiable; "Transaction Header"."Tax Liable")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxExemptionNo; "Transaction Header"."Tax Exemption No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NetIncExpAmount; "Transaction Header"."Net Income/Exp. Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DocumentCode; "Transaction Header"."Document Code")
                {
                }
                fieldelement(DocumentNo; "Transaction Header"."Document No.")
                {
                }
                fieldelement(ExternalDocNo; "Transaction Header"."External Doc. No.")
                {
                }
                fieldelement(FromLocation; "Transaction Header"."From Location")
                {
                }
                fieldelement(FromStore; "Transaction Header"."From Store")
                {
                }
                fieldelement(LocationCode; "Transaction Header"."Location Code")
                {
                }
                fieldelement(OfflineDocumentNo; "Transaction Header"."Offline Document No.")
                {
                }
                fieldelement(PostSeries; "Transaction Header"."Post Series")
                {
                }
                fieldelement(ReasonCode; "Transaction Header"."Reason Code")
                {
                }
                fieldelement(RelatedDocNo; "Transaction Header"."Related Doc. No.")
                {
                }
                fieldelement(ShiptoCode; "Transaction Header"."Ship-to Code")
                {
                }
                fieldelement(ShipmentMethod; "Transaction Header"."Shipment Method")
                {
                }
                fieldelement(ShipmentReason; "Transaction Header"."Shipment Reason")
                {
                }
                fieldelement(ToLocation; "Transaction Header"."To Location")
                {
                }
                fieldelement(ToStore; "Transaction Header"."To Store")
                {
                }
                fieldelement(TransDocumentNo; "Transaction Header"."Trans. Document No.")
                {
                }
                fieldelement(WEBOrderNo; "Transaction Header"."WEB Order No.")
                {
                }
            }
            tableelement("Trans. Sales Entry"; "LSC Trans. Sales Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransSalesEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Sales Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Sales Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Sales Entry"."Receipt No.")
                {
                }
                fieldelement(BarcodeNo; "Trans. Sales Entry"."Barcode No.")
                {
                }
                fieldelement(ItemNo; "Trans. Sales Entry"."Item No.")
                {
                }
                fieldelement(SalesStaff; "Trans. Sales Entry"."Sales Staff")
                {
                }
                fieldelement(ItemCategoryCode; "Trans. Sales Entry"."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; "Trans. Sales Entry"."Retail Product Code")
                {
                }
                fieldelement(Price; "Trans. Sales Entry".Price)
                {
                }
                fieldelement(NetPrice; "Trans. Sales Entry"."Net Price")
                {
                }
                fieldelement(Quantity; "Trans. Sales Entry".Quantity)
                {
                }
                fieldelement(PriceGroupCode; "Trans. Sales Entry"."Price Group Code")
                {
                }
                fieldelement(VATBusPostingGroup; "Trans. Sales Entry"."VAT Bus. Posting Group")
                {
                }
                fieldelement(VATCode; "Trans. Sales Entry"."VAT Code")
                {
                }
                fieldelement(xTransactionStatus; "Trans. Sales Entry"."xTransaction Status")
                {
                }
                fieldelement(DiscountAmount; "Trans. Sales Entry"."Discount Amount")
                {
                }
                fieldelement(CostAmount; "Trans. Sales Entry"."Cost Amount")
                {
                }
                fieldelement(Date; "Trans. Sales Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Sales Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Trans. Sales Entry"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Trans. Sales Entry"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NetAmount; "Trans. Sales Entry"."Net Amount")
                {
                }
                fieldelement(VATAmount; "Trans. Sales Entry"."VAT Amount")
                {
                }
                fieldelement(PromotionNo; "Trans. Sales Entry"."Promotion No.")
                {
                }
                fieldelement(StandardNetPrice; "Trans. Sales Entry"."Standard Net Price")
                {
                }
                fieldelement(DiscAmountFromStdPrice; "Trans. Sales Entry"."Disc. Amount From Std. Price")
                {
                }
                fieldelement(xStatementNo; "Trans. Sales Entry"."xStatement No.")
                {
                }
                fieldelement(CustomerNo; "Trans. Sales Entry"."Customer No.")
                {
                }
                fieldelement(Section; "Trans. Sales Entry".Section)
                {
                }
                fieldelement(Shelf; "Trans. Sales Entry".Shelf)
                {
                }
                fieldelement(StatementCode; "Trans. Sales Entry"."Statement Code")
                {
                }
                fieldelement(ItemDiscGroup; "Trans. Sales Entry"."Item Disc. Group")
                {
                }
                fieldelement(TransactionCode; "Trans. Sales Entry"."Transaction Code")
                {
                }
                fieldelement(StoreNo; "Trans. Sales Entry"."Store No.")
                {
                }
                fieldelement(ItemNumberScanned; "Trans. Sales Entry"."Item Number Scanned")
                {
                }
                fieldelement(KeyboardItemEntry; "Trans. Sales Entry"."Keyboard Item Entry")
                {
                }
                fieldelement(PriceinBarcode; "Trans. Sales Entry"."Price in Barcode")
                {
                }
                fieldelement(PriceChange; "Trans. Sales Entry"."Price Change")
                {
                }
                fieldelement(WeightManuallyEntered; "Trans. Sales Entry"."Weight Manually Entered")
                {
                }
                fieldelement(LinewasDiscounted; "Trans. Sales Entry"."Line was Discounted")
                {
                }
                fieldelement(ScaleItem; "Trans. Sales Entry"."Scale Item")
                {
                }
                fieldelement(WeightItem; "Trans. Sales Entry"."Weight Item")
                {
                }
                fieldelement(ReturnNoSale; "Trans. Sales Entry"."Return No Sale")
                {
                }
                fieldelement(ItemCorrectedLine; "Trans. Sales Entry"."Item Corrected Line")
                {
                }
                fieldelement(TypeofSale; "Trans. Sales Entry"."Type of Sale")
                {
                }
                fieldelement(LinkedNonotOrig; "Trans. Sales Entry"."Linked No. not Orig.")
                {
                }
                fieldelement(OrigofaLinkedItemList; "Trans. Sales Entry"."Orig. of a Linked Item List")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Sales Entry"."POS Terminal No.")
                {
                }
                fieldelement(StaffID; "Trans. Sales Entry"."Staff ID")
                {
                }
                fieldelement(ItemPostingGroup; "Trans. Sales Entry"."Item Posting Group")
                {
                }
                fieldelement(TotalRoundedAmt; "Trans. Sales Entry"."Total Rounded Amt.")
                {
                }
                fieldelement(Counter; "Trans. Sales Entry".Counter)
                {
                }
                fieldelement(VariantCode; "Trans. Sales Entry"."Variant Code")
                {
                }
                fieldelement(SerialNo; "Trans. Sales Entry"."Serial No.")
                {
                }
                fieldelement(SerialLotNoNotValid; "Trans. Sales Entry"."Serial/Lot No. Not Valid")
                {
                }
                fieldelement(LotNo; "Trans. Sales Entry"."Lot No.")
                {
                }
                fieldelement(ExpirationDate; "Trans. Sales Entry"."Expiration Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(MemberPointsType; "Trans. Sales Entry"."Member Points Type")
                {
                }
                fieldelement(MemberPoints; "Trans. Sales Entry"."Member Points")
                {
                }
                fieldelement(OfferBlockedPoints; "Trans. Sales Entry"."Offer Blocked Points")
                {
                }
                fieldelement(TransDate; "Trans. Sales Entry"."Trans. Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TransTime; "Trans. Sales Entry"."Trans. Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostingExceptionKey; "Trans. Sales Entry"."Posting Exception Key")
                {
                }
                fieldelement(LineDiscount; "Trans. Sales Entry"."Line Discount")
                {
                }
                fieldelement(Replicated; "Trans. Sales Entry".Replicated)
                {
                }
                fieldelement(CustomerDiscount; "Trans. Sales Entry"."Customer Discount")
                {
                }
                fieldelement(InfocodeDiscount; "Trans. Sales Entry"."Infocode Discount")
                {
                }
                fieldelement(CustInvoiceDiscount; "Trans. Sales Entry"."Cust. Invoice Discount")
                {
                }
                fieldelement(UnitofMeasure; "Trans. Sales Entry"."Unit of Measure")
                {
                }
                fieldelement(UOMQuantity; "Trans. Sales Entry"."UOM Quantity")
                {
                }
                fieldelement(UOMPrice; "Trans. Sales Entry"."UOM Price")
                {
                }
                fieldelement(TotalDiscount; "Trans. Sales Entry"."Total Discount")
                {
                }
                fieldelement(TotalDisc; "Trans. Sales Entry"."Total Disc.%")
                {
                }
                fieldelement(TotDiscInfoLineNo; "Trans. Sales Entry"."Tot. Disc Info Line No.")
                {
                }
                fieldelement(PeriodicDiscType; "Trans. Sales Entry"."Periodic Disc. Type")
                {
                }
                fieldelement(PeriodicDiscGroup; "Trans. Sales Entry"."Periodic Disc. Group")
                {
                }
                fieldelement(PeriodicDiscount; "Trans. Sales Entry"."Periodic Discount")
                {
                }
                fieldelement(DealLine; "Trans. Sales Entry"."Deal Line")
                {
                }
                fieldelement(DealHeaderLineNo; "Trans. Sales Entry"."Deal Header Line No.")
                {
                }
                fieldelement(DealLineNo; "Trans. Sales Entry"."Deal Line No.")
                {
                }
                fieldelement(DealLineAddedAmt; "Trans. Sales Entry"."Deal Line Added Amt.")
                {
                }
                fieldelement(DealModifierAddedAmt; "Trans. Sales Entry"."Deal Modifier Added Amt.")
                {
                }
                fieldelement(DealModifierLineNo; "Trans. Sales Entry"."Deal Modifier Line No.")
                {
                }
                fieldelement(DiscountAmtForPrinting; "Trans. Sales Entry"."Discount Amt. For Printing")
                {
                }
                fieldelement(CouponDiscount; "Trans. Sales Entry"."Coupon Discount")
                {
                }
                fieldelement(CouponAmtForPrinting; "Trans. Sales Entry"."Coupon Amt. For Printing")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Sales Entry"."Replication Counter")
                {
                }
                fieldelement(SalesType; "Trans. Sales Entry"."Sales Type")
                {
                }
                fieldelement(OrigfromInfocode; "Trans. Sales Entry"."Orig. from Infocode")
                {
                }
                fieldelement(OrigfromSubcode; "Trans. Sales Entry"."Orig. from Subcode")
                {
                }
                fieldelement(ParentLineNo; "Trans. Sales Entry"."Parent Line No.")
                {
                }
                fieldelement(InfocodeEntryLineNo; "Trans. Sales Entry"."Infocode Entry Line No.")
                {
                }
                fieldelement(ExcludedBOMLineNo; "Trans. Sales Entry"."Excluded BOM Line No.")
                {
                }
                fieldelement(InfocodeSelectedQty; "Trans. Sales Entry"."Infocode Selected Qty.")
                {
                }
                fieldelement(ParentItemNo; "Trans. Sales Entry"."Parent Item No.")
                {
                }
                fieldelement(OrigTransStore; "Trans. Sales Entry"."Orig Trans Store")
                {
                }
                fieldelement(OrigTransPos; "Trans. Sales Entry"."Orig Trans Pos")
                {
                }
                fieldelement(OrigTransNo; "Trans. Sales Entry"."Orig Trans No.")
                {
                }
                fieldelement(OrigTransLineNo; "Trans. Sales Entry"."Orig Trans Line No.")
                {
                }
                fieldelement(RefundQty; "Trans. Sales Entry"."Refund Qty.")
                {
                }
                fieldelement(RefundedLineNo; "Trans. Sales Entry"."Refunded Line No.")
                {
                }
                fieldelement(RefundedTransNo; "Trans. Sales Entry"."Refunded Trans. No.")
                {
                }
                fieldelement(RefundedPOSNo; "Trans. Sales Entry"."Refunded POS No.")
                {
                }
                fieldelement(RefundedStoreNo; "Trans. Sales Entry"."Refunded Store No.")
                {
                }
                fieldelement(CreatedbyStaffID; "Trans. Sales Entry"."Created by Staff ID")
                {
                }
                fieldelement(BITimestamp; "Trans. Sales Entry"."BI Timestamp")
                {
                    MinOccurs = Zero;
                }
                fieldelement(GenBusPostingGroup; "Trans. Sales Entry"."Gen. Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATBusPostingGroup; "Trans. Sales Entry"."VAT Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(GenProdPostingGroup; "Trans. Sales Entry"."Gen. Prod. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATProdPostingGroup; "Trans. Sales Entry"."VAT Prod. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PLBItem; "Trans. Sales Entry"."PLB Item")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxGroupCode; "Trans. Sales Entry"."Tax Group Code")
                {
                }
                fieldelement(TaxCalculationType; "Trans. Sales Entry"."VAT Calculation Type")
                {
                }
                fieldelement(SalesTaxRounding; "Trans. Sales Entry"."Sales Tax Rounding")
                {
                }
                fieldelement(IT4GDocNo; "Trans. Sales Entry"."IT4G-Doc. No.")
                {
                }
                fieldelement(IT4GDocLineNo; "Trans. Sales Entry"."IT4G-Doc. Line No.")
                {
                }
                fieldelement(LocationCode; "Trans. Sales Entry"."Location Code")
                {
                }
            }
            tableelement("Trans. Payment Entry"; "LSC Trans. Payment Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransPaymentEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Payment Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Payment Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Payment Entry"."Receipt No.")
                {
                }
                fieldelement(StatementCode; "Trans. Payment Entry"."Statement Code")
                {
                }
                fieldelement(CardNo; "Trans. Payment Entry"."Card No.")
                {
                }
                fieldelement(ExchangeRate; "Trans. Payment Entry"."Exchange Rate")
                {
                }
                fieldelement(TenderType; "Trans. Payment Entry"."Tender Type")
                {
                }
                fieldelement(AmountTendered; "Trans. Payment Entry"."Amount Tendered")
                {
                }
                fieldelement(CurrencyCode; "Trans. Payment Entry"."Currency Code")
                {
                }
                fieldelement(AmountinCurrency; "Trans. Payment Entry"."Amount in Currency")
                {
                }
                fieldelement(CardorAccount; "Trans. Payment Entry"."Card or Account")
                {
                }
                fieldelement(Date; "Trans. Payment Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Payment Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Trans. Payment Entry"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Trans. Payment Entry"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StaffID; "Trans. Payment Entry"."Staff ID")
                {
                }
                fieldelement(StoreNo; "Trans. Payment Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Payment Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionStatus; "Trans. Payment Entry"."Transaction Status")
                {
                }
                fieldelement(StatementNo; "Trans. Payment Entry"."Statement No.")
                {
                }
                fieldelement(ManagersKeyLive; "Trans. Payment Entry"."Managers Key Live")
                {
                }
                fieldelement(ChangeLine; "Trans. Payment Entry"."Change Line")
                {
                }
                fieldelement(Counter; "Trans. Payment Entry".Counter)
                {
                }
                fieldelement(TransDate; "Trans. Payment Entry"."Trans. Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TransTime; "Trans. Payment Entry"."Trans. Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(MessageNo; "Trans. Payment Entry"."Message No.")
                {
                }
                fieldelement(Replicated; "Trans. Payment Entry".Replicated)
                {
                }
                fieldelement(Quantity; "Trans. Payment Entry".Quantity)
                {
                }
                fieldelement("Z-ReportID"; "Trans. Payment Entry"."Z-Report ID")
                {
                }
                fieldelement(TenderDeclID; "Trans. Payment Entry"."Tender Decl. ID")
                {
                }
                fieldelement("Y-ReportID"; "Trans. Payment Entry"."Y-Report ID")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Payment Entry"."Replication Counter")
                {
                }
                fieldelement(Safetype; "Trans. Payment Entry"."Safe type")
                {
                }
                fieldelement(CreatedbyStaffID; "Trans. Payment Entry"."Created by Staff ID")
                {
                }
                fieldelement(OrderNo; "Trans. Payment Entry"."Order No.")
                {
                }
            }
            tableelement("Trans. Income/Expense Entry"; "LSC Trans. Inc./Exp. Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransIncomeExpenseEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Income/Expense Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Income/Expense Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Income/Expense Entry"."Receipt  No.")
                {
                }
                fieldelement(No; "Trans. Income/Expense Entry"."No.")
                {
                }
                fieldelement(StoreNo; "Trans. Income/Expense Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Income/Expense Entry"."POS Terminal No.")
                {
                }
                fieldelement(StaffID; "Trans. Income/Expense Entry"."Staff ID")
                {
                }
                fieldelement(TransactionStatus; "Trans. Income/Expense Entry"."Transaction Status")
                {
                }
                fieldelement(VATCode; "Trans. Income/Expense Entry"."VAT Code")
                {
                }
                fieldelement(Amount; "Trans. Income/Expense Entry".Amount)
                {
                }
                fieldelement(AccountType; "Trans. Income/Expense Entry"."Account Type")
                {
                }
                fieldelement(NetAmount; "Trans. Income/Expense Entry"."Net Amount")
                {
                }
                fieldelement(StatementNo; "Trans. Income/Expense Entry"."Statement No.")
                {
                }
                fieldelement(StatementCode; "Trans. Income/Expense Entry"."Statement Code")
                {
                }
                fieldelement(VATAmount; "Trans. Income/Expense Entry"."VAT Amount")
                {
                }
                fieldelement(Counter; "Trans. Income/Expense Entry".Counter)
                {
                }
                fieldelement(Date; "Trans. Income/Expense Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Income/Expense Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Trans. Income/Expense Entry"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Trans. Income/Expense Entry"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RetailChargeCode; "Trans. Income/Expense Entry"."Retail Charge Code")
                {
                }
                fieldelement(Replicated; "Trans. Income/Expense Entry".Replicated)
                {
                }
                fieldelement("Z-ReportID"; "Trans. Income/Expense Entry"."Z-Report ID")
                {
                }
                fieldelement(ExchangeRate; "Trans. Income/Expense Entry"."Exchange Rate")
                {
                }
                fieldelement(CurrencyCode; "Trans. Income/Expense Entry"."Currency Code")
                {
                }
                fieldelement(AmountinCurrency; "Trans. Income/Expense Entry"."Amount in Currency")
                {
                }
                fieldelement("Y-ReportID"; "Trans. Income/Expense Entry"."Y-Report ID")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Income/Expense Entry"."Replication Counter")
                {
                }
                fieldelement(TaxGroupCode; "Trans. Income/Expense Entry"."Tax Group Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(SalesTaxRounding; "Trans. Income/Expense Entry"."Sales Tax Rounding")
                {
                    MinOccurs = Zero;
                }
            }
            tableelement("Trans. Infocode Entry"; "LSC Trans. Infocode Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransInfocodeEntry';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Infocode Entry"."Store No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Infocode Entry"."Transaction No.")
                {
                }
                fieldelement(TransactionType; "Trans. Infocode Entry"."Transaction Type")
                {
                }
                fieldelement(LineNo; "Trans. Infocode Entry"."Line No.")
                {
                }
                fieldelement(Infocode; "Trans. Infocode Entry".Infocode)
                {
                }
                fieldelement(Information; "Trans. Infocode Entry".Information)
                {
                }
                fieldelement(InfoAmt; "Trans. Infocode Entry"."Info. Amt.")
                {
                }
                fieldelement(TextType; "Trans. Infocode Entry"."Text Type")
                {
                }
                fieldelement(Date; "Trans. Infocode Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Infocode Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(POSTerminalNo; "Trans. Infocode Entry"."POS Terminal No.")
                {
                }
                fieldelement(StaffID; "Trans. Infocode Entry"."Staff ID")
                {
                }
                fieldelement(No; "Trans. Infocode Entry"."No.")
                {
                }
                fieldelement(VariantCode; "Trans. Infocode Entry"."Variant Code")
                {
                }
                fieldelement(Amount; "Trans. Infocode Entry".Amount)
                {
                }
                fieldelement(TypeofInput; "Trans. Infocode Entry"."Type of Input")
                {
                }
                fieldelement(Subcode; "Trans. Infocode Entry".Subcode)
                {
                }
                fieldelement(EntryLineNo; "Trans. Infocode Entry"."Entry Line No.")
                {
                }
                fieldelement(EntryVariantCode; "Trans. Infocode Entry"."Entry Variant Code")
                {
                }
                fieldelement(EntryTriggerFunction; "Trans. Infocode Entry"."Entry Trigger Function")
                {
                }
                fieldelement(EntryTriggerCode; "Trans. Infocode Entry"."Entry Trigger Code")
                {
                }
                fieldelement(StatementNo; "Trans. Infocode Entry"."Statement No.")
                {
                }
                fieldelement(StatementCode; "Trans. Infocode Entry"."Statement Code")
                {
                }
                fieldelement(SourceCode; "Trans. Infocode Entry"."Source Code")
                {
                }
                fieldelement(SerialNo; "Trans. Infocode Entry"."Serial No.")
                {
                }
                fieldelement(SelectedQuantity; "Trans. Infocode Entry"."Selected Quantity")
                {
                }
                fieldelement(Counter; "Trans. Infocode Entry".Counter)
                {
                }
                fieldelement(Replicated; "Trans. Infocode Entry".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "Trans. Infocode Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Tender Declar. Entry"; "LSC Trans. Tender Declar. Entr")
            {
                MinOccurs = Zero;
                XmlName = 'TransTenderDeclarEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Tender Declar. Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Tender Declar. Entry"."Line No.")
                {
                }
                fieldelement(SlipNo; "Trans. Tender Declar. Entry"."Slip No.")
                {
                }
                fieldelement(StatementCode; "Trans. Tender Declar. Entry"."Statement Code")
                {
                }
                fieldelement(POSCurrCode; "Trans. Tender Declar. Entry"."POS Curr. Code")
                {
                }
                fieldelement(CardNo; "Trans. Tender Declar. Entry"."Card No.")
                {
                }
                fieldelement(TenderType; "Trans. Tender Declar. Entry"."Tender Type")
                {
                }
                fieldelement(AmountTendered; "Trans. Tender Declar. Entry"."Amount Tendered")
                {
                }
                fieldelement(CurrencyCode; "Trans. Tender Declar. Entry"."Currency Code")
                {
                }
                fieldelement(AmountinCurrency; "Trans. Tender Declar. Entry"."Amount in Currency")
                {
                }
                fieldelement(Date; "Trans. Tender Declar. Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Tender Declar. Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Trans. Tender Declar. Entry"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Trans. Tender Declar. Entry"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StaffID; "Trans. Tender Declar. Entry"."Staff ID")
                {
                }
                fieldelement(StoreNo; "Trans. Tender Declar. Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Tender Declar. Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionStatus; "Trans. Tender Declar. Entry"."Transaction Status")
                {
                }
                fieldelement(StatementNoNOTUSED; "Trans. Tender Declar. Entry"."Statement No. NOT USED")
                {
                }
                fieldelement(BankAmountTendered; "Trans. Tender Declar. Entry"."Bank Amount Tendered")
                {
                }
                fieldelement(BankAmountinCurrency; "Trans. Tender Declar. Entry"."Bank Amount in Currency")
                {
                }
                fieldelement(SafeAmountTendered; "Trans. Tender Declar. Entry"."Safe Amount Tendered")
                {
                }
                fieldelement(SafeAmountinCurrency; "Trans. Tender Declar. Entry"."Safe Amount in Currency")
                {
                }
                fieldelement(FixedFloatAmountTendered; "Trans. Tender Declar. Entry"."Fixed Float Amount Tendered")
                {
                }
                fieldelement(FixedFloatAmountinCurrency; "Trans. Tender Declar. Entry"."Fixed Float Amount in Currency")
                {
                }
                fieldelement(Quantity; "Trans. Tender Declar. Entry".Quantity)
                {
                }
                fieldelement(Replicated; "Trans. Tender Declar. Entry".Replicated)
                {
                }
                fieldelement("Z-ReportID"; "Trans. Tender Declar. Entry"."Z-Report ID")
                {
                }
                fieldelement("Y-ReportID"; "Trans. Tender Declar. Entry"."Y-Report ID")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Tender Declar. Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Inventory Entry"; "LSC Trans. Inventory Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransInventoryEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Inventory Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Inventory Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Inventory Entry"."Receipt No.")
                {
                }
                fieldelement(BarcodeNo; "Trans. Inventory Entry"."Barcode No.")
                {
                }
                fieldelement(ItemNo; "Trans. Inventory Entry"."Item No.")
                {
                }
                fieldelement(Quantity; "Trans. Inventory Entry".Quantity)
                {
                }
                fieldelement(TransactionStatus; "Trans. Inventory Entry"."Transaction Status")
                {
                }
                fieldelement(Date; "Trans. Inventory Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Inventory Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(StatementNo; "Trans. Inventory Entry"."Statement No.")
                {
                }
                fieldelement(StoreNo; "Trans. Inventory Entry"."Store No.")
                {
                }
                fieldelement(ItemNumberScanned; "Trans. Inventory Entry"."Item Number Scanned")
                {
                }
                fieldelement(KeyboardItemEntry; "Trans. Inventory Entry"."Keyboard Item Entry")
                {
                }
                fieldelement(PriceinBarcode; "Trans. Inventory Entry"."Price in Barcode")
                {
                }
                fieldelement(WeightManuallyEntered; "Trans. Inventory Entry"."Weight Manually Entered")
                {
                }
                fieldelement(ScaleItem; "Trans. Inventory Entry"."Scale Item")
                {
                }
                fieldelement(WeightItem; "Trans. Inventory Entry"."Weight Item")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Inventory Entry"."POS Terminal No.")
                {
                }
                fieldelement(StaffID; "Trans. Inventory Entry"."Staff ID")
                {
                }
                fieldelement(VariantCode; "Trans. Inventory Entry"."Variant Code")
                {
                }
                fieldelement(SerialNo; "Trans. Inventory Entry"."Serial No.")
                {
                }
                fieldelement(LotNo; "Trans. Inventory Entry"."Lot No.")
                {
                }
                fieldelement(ExpirationDate; "Trans. Inventory Entry"."Expiration Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Replicated; "Trans. Inventory Entry".Replicated)
                {
                }
                fieldelement(UnitofMeasure; "Trans. Inventory Entry"."Unit of Measure")
                {
                }
                fieldelement(UOMQuantity; "Trans. Inventory Entry"."UOM Quantity")
                {
                }
                fieldelement(UOMPrice; "Trans. Inventory Entry"."UOM Price")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Inventory Entry"."Replication Counter")
                {
                }
                fieldelement(SalesType; "Trans. Inventory Entry"."Sales Type")
                {
                }
                fieldelement(IT4GDocNo; "Trans. Inventory Entry"."IT4G-Doc. No.")
                {
                }
                fieldelement(IT4GDocLineNo; "Trans. Inventory Entry"."IT4G-Doc. Line No.")
                {
                }
                fieldelement(LocationCode; "Trans. Inventory Entry"."Location Code")
                {
                }

            }
            tableelement("POS Card Entry"; "LSC POS Card Entry")
            {
                MinOccurs = Zero;
                XmlName = 'POSCardEntry';
                UseTemporary = true;
                fieldelement(StoreNo; "POS Card Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "POS Card Entry"."POS Terminal No.")
                {
                }
                fieldelement(EntryNo; "POS Card Entry"."Entry No.")
                {
                }
                fieldelement(TransactionNo; "POS Card Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "POS Card Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "POS Card Entry"."Receipt No.")
                {
                }
                fieldelement(EFTPOSTerminalNo; "POS Card Entry"."EFT POS Terminal No.")
                {
                }
                fieldelement(TenderType; "POS Card Entry"."Tender Type")
                {
                }
                fieldelement(TransactionType; "POS Card Entry"."Transaction Type")
                {
                }
                fieldelement(MSRinput; "POS Card Entry"."MSR input")
                {
                }
                fieldelement(Date; "POS Card Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "POS Card Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(AuthorisationOk; "POS Card Entry"."Authorisation Ok")
                {
                }
                fieldelement(Voided; "POS Card Entry".Voided)
                {
                }
                fieldelement(CardNumber; "POS Card Entry"."Card Number")
                {
                }
                fieldelement(CardType; "POS Card Entry"."Card Type")
                {
                }
                fieldelement(CardTypeName; "POS Card Entry"."Card Type Name")
                {
                }
                fieldelement(ExpiryDate; "POS Card Entry"."Expiry Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Authcode; "POS Card Entry"."Auth.code")
                {
                }
                fieldelement(Rescode; "POS Card Entry"."Res.code")
                {
                }
                fieldelement(Message; "POS Card Entry".Message)
                {
                }
                fieldelement(CardClass; "POS Card Entry"."Card Class")
                {
                }
                fieldelement(EFTMerchantNo; "POS Card Entry"."EFT Merchant No.")
                {
                }
                fieldelement(EFTTerminalID; "POS Card Entry"."EFT Terminal ID")
                {
                }
                fieldelement(EFTTransNo; "POS Card Entry"."EFT Trans. No.")
                {
                }
                fieldelement(EFTTransactionID; "POS Card Entry"."EFT Transaction ID")
                {
                }
                fieldelement(EFTAdditionalID; "POS Card Entry"."EFT Additional ID")
                {
                }
                fieldelement(EFTBatchNo; "POS Card Entry"."EFT Batch No.")
                {
                }
                fieldelement(AuthSourceCode; "POS Card Entry"."Auth. Source Code")
                {
                }
                fieldelement(EFTTransTime; "POS Card Entry"."EFT Trans. Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EFTTransDate; "POS Card Entry"."EFT Trans. Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Amount; "POS Card Entry".Amount)
                {
                }
                fieldelement(VAT; "POS Card Entry".VAT)
                {
                }
                fieldelement(Cashback; "POS Card Entry".Cashback)
                {
                }
                fieldelement(EFTStoreNo; "POS Card Entry"."EFT Store No.")
                {
                }
                fieldelement(EFTServerName; "POS Card Entry"."EFT Server Name")
                {
                }
                fieldelement(EFTVerificationMethod; "POS Card Entry"."EFT Verification Method")
                {
                }
                fieldelement(EFTAuthorizationStatus; "POS Card Entry"."EFT Authorization Status")
                {
                }
                fieldelement(EFTTransactionType; "POS Card Entry"."EFT Transaction Type")
                {
                }
                fieldelement(EFTStaffID; "POS Card Entry"."EFT Staff ID")
                {
                }
                fieldelement(EFTDateTime; "POS Card Entry"."EFT DateTime")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ExtraData; "POS Card Entry"."Extra Data")
                {
                }
                fieldelement(VoidedSlipNo; "POS Card Entry"."Voided Slip No.")
                {
                }
                fieldelement(VoidedEntryNo; "POS Card Entry"."Voided Entry No.")
                {
                }
                fieldelement(VoidedEFTTransNo; "POS Card Entry"."Voided EFT Trans. No.")
                {
                }
                fieldelement(VoidedEFTTransactionID; "POS Card Entry"."Voided EFT Transaction ID")
                {
                }
                fieldelement(Encrypted; "POS Card Entry".Encrypted)
                {
                }
                fieldelement(Replicated; "POS Card Entry".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "POS Card Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Discount Entry"; "LSC Trans. Discount Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransDiscountEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Discount Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Discount Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Discount Entry"."Receipt No.")
                {
                }
                fieldelement(StoreNo; "Trans. Discount Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Discount Entry"."POS Terminal No.")
                {
                }
                fieldelement(MemberAttribute; "Trans. Discount Entry"."Member Attribute")
                {
                }
                fieldelement(MemberAttributeValue; "Trans. Discount Entry"."Member Attribute Value")
                {
                }
                fieldelement(TrackingNo; "Trans. Discount Entry"."Tracking No.")
                {
                }
                fieldelement(OfferType; "Trans. Discount Entry"."Offer Type")
                {
                }
                fieldelement(OfferNo; "Trans. Discount Entry"."Offer No.")
                {
                }
                fieldelement(DiscountAmount; "Trans. Discount Entry"."Discount Amount")
                {
                }
                fieldelement(Points; "Trans. Discount Entry".Points)
                {
                }
                fieldelement(SequenceCode; "Trans. Discount Entry"."Sequence Code")
                {
                }
                fieldelement(SequenceFunction; "Trans. Discount Entry"."Sequence Function")
                {
                }
                fieldelement(RecipeLineNo; "Trans. Discount Entry".RecipeLineNo)
                {
                }
                fieldelement(ReplicationCounter; "Trans. Discount Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Deal Entry"; "LSC Trans. Deal Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransDealEntry';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Deal Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Deal Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Deal Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Deal Entry"."Line No.")
                {
                }
                fieldelement(DealNo; "Trans. Deal Entry"."Deal No.")
                {
                }
                fieldelement(DealHeaderLineNo; "Trans. Deal Entry"."Deal Header Line No.")
                {
                }
                fieldelement(Quantity; "Trans. Deal Entry".Quantity)
                {
                }
                fieldelement(Amount; "Trans. Deal Entry".Amount)
                {
                }
                fieldelement(Price; "Trans. Deal Entry".Price)
                {
                }
                fieldelement(Date; "Trans. Deal Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(TotalDealLineAddedAmt; "Trans. Deal Entry"."Total Deal Line Added Amt.")
                {
                }
                fieldelement(TotalDealModifierAddedAmt; "Trans. Deal Entry"."Total Deal Modifier Added Amt.")
                {
                }
            }
            tableelement("Trans. Point Entry"; "LSC Trans. Point Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransPointEntry';
                UseTemporary = true;
                fieldelement(ReceiptNo; "Trans. Point Entry"."Receipt No.")
                {
                }
                fieldelement(Points; "Trans. Point Entry".Points)
                {
                }
                fieldelement(Date; "Trans. Point Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(POSTerminalNo; "Trans. Point Entry"."POS Terminal No.")
                {
                }
                fieldelement(CardNo; "Trans. Point Entry"."Card No.")
                {
                }
                fieldelement(EntryType; "Trans. Point Entry"."Entry Type")
                {
                }
                fieldelement(StoreNo; "Trans. Point Entry"."Store No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Point Entry"."Transaction No.")
                {
                }
                fieldelement(PointType; "Trans. Point Entry"."Point Type")
                {
                }
                fieldelement(ValuePerPoint; "Trans. Point Entry"."Value Per Point")
                {
                }
                fieldelement(DiscBenefitPoints; "Trans. Point Entry"."Disc. Benefit Points")
                {
                }
                fieldelement(TenderPoints; "Trans. Point Entry"."Tender Points")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Point Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Hospitality Entry"; "LSC Trans. Hospitality Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransHospitalityEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Hospitality Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Hospitality Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Hospitality Entry"."Receipt No.")
                {
                }
                fieldelement(StoreNo; "Trans. Hospitality Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Hospitality Entry"."POS Terminal No.")
                {
                }
                fieldelement(ItemNo; "Trans. Hospitality Entry"."Item No.")
                {
                }
                fieldelement(RestaurantMenuTypeCode; "Trans. Hospitality Entry"."Restaurant Menu Type Code")
                {
                }
                fieldelement(RestaurantMenuType; "Trans. Hospitality Entry"."Restaurant Menu Type")
                {
                }
                fieldelement(OriginalReceiptNo; "Trans. Hospitality Entry"."Original Receipt No.")
                {
                }
                fieldelement(Replicated; "Trans. Hospitality Entry".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "Trans. Hospitality Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. SalesTax Entry"; "LSC Trans. SalesTax Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransSalesTaxEntry';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. SalesTax Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. SalesTax Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. SalesTax Entry"."Transaction No.")
                {
                }
                fieldelement(EntryNo; "Trans. SalesTax Entry"."Entry No.")
                {
                }
                fieldelement(TaxAreaCode; "Trans. SalesTax Entry"."Tax Area Code")
                {
                }
                fieldelement(TaxJurisdictionCode; "Trans. SalesTax Entry"."Tax Jurisdiction Code")
                {
                }
                fieldelement(TaxGroupCode; "Trans. SalesTax Entry"."Tax Group Code")
                {
                }
                fieldelement(ExpenseCapitalize; "Trans. SalesTax Entry"."Expense/Capitalize")
                {
                }
                fieldelement(TaxType; "Trans. SalesTax Entry"."Tax Type")
                {
                }
                fieldelement(UseTax; "Trans. SalesTax Entry"."Use Tax")
                {
                }
                fieldelement(Positive; "Trans. SalesTax Entry".Positive)
                {
                }
                fieldelement(TaxLiable; "Trans. SalesTax Entry"."Tax Liable")
                {
                }
                fieldelement(Quantity; "Trans. SalesTax Entry".Quantity)
                {
                }
                fieldelement(TaxPercentage; "Trans. SalesTax Entry"."Tax %")
                {
                }
                fieldelement(TaxBaseAmount; "Trans. SalesTax Entry"."Tax Base Amount")
                {
                }
                fieldelement(TaxAmount; "Trans. SalesTax Entry"."Tax Amount")
                {
                }
                fieldelement(TaxDifference; "Trans. SalesTax Entry"."Tax Difference")
                {
                }
                fieldelement(AvaTaxJurisdiction; "Trans. SalesTax Entry"."AvaTax Jurisdiction")
                {
                }
                fieldelement(AvaTaxName; "Trans. SalesTax Entry"."AvaTax Name")
                {
                }
                fieldelement(AvaTaxCustomerUsageType; "Trans. SalesTax Entry"."AvaTax Customer Usage Type")
                {
                }
                fieldelement(ReplicationCounter; "Trans. SalesTax Entry"."Replication Counter")
                {
                }

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        WebRequestFunctions: Codeunit "LSC Web Request Functions";

    procedure SetTransactionTables(var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE("Transaction Header");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Sales Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Payment Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Income/Expense Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Infocode Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Tender Declar. Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Inventory Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("POS Card Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Discount Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Deal Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Point Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Hospitality Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. SalesTax Entry");
        WebRequestFunctions.GetTableDataXML(BufferUtility, RecRef);
    end;

    procedure GetTransactionTables(var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE("Transaction Header");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Sales Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Payment Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Income/Expense Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Infocode Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Tender Declar. Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Inventory Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("POS Card Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Discount Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Deal Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Point Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Hospitality Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. SalesTax Entry");
        WebRequestFunctions.LoadTableData(RecRef, BufferUtility);
    end;

}

