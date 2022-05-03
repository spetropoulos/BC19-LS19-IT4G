xmlport 50003 SendTransactionIT4GXML
{
    Caption = 'SendTransactionIT4GXML';
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(RootSendTransaction)
        {
            tableelement("Transaction Header"; "LSC Transaction Header")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionHeader';
                UseTemporary = true;
                fieldelement(TransactionNo; "Transaction Header"."Transaction No.")
                {
                }
                fieldelement(AllowCancel; "Transaction Header"."Allow Cancel")
                {
                }
                fieldelement(CancellationEntryNo; "Transaction Header"."Cancellation Entry No.")
                {
                }
                fieldelement(CancellationType; "Transaction Header"."Cancellation Type")
                {
                }
                fieldelement(IT4GLoyaltyID; "Transaction Header"."IT4G-Loyalty ID")
                {
                }
                fieldelement(IT4GLoyaltyCard; "Transaction Header"."IT4G-Loyalty Card")
                {
                }
                fieldelement(TransactionType; "Transaction Header"."Transaction Type")
                {
                }
                fieldelement(ReceiptNo; "Transaction Header"."Receipt No.")
                {
                }
                fieldelement(GenBusPostingGroup; "Transaction Header"."Gen. Bus. Posting Group")
                {
                    MinOccurs = Zero;
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
                fieldelement(CustomerOrder; "Transaction Header"."Customer Order")
                {
                }
                fieldelement(OverridePLBItem; "Transaction Header"."Override PLB Item")
                {
                }
                fieldelement(OverrideStaffID; "Transaction Header"."Override Staff ID")
                {
                }
                fieldelement(OverrideDateTime; "Transaction Header"."Override Date Time")
                {
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
                fieldelement(GenBusPostingGroup; "Trans. Sales Entry"."Gen. Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATBusPostingGroup; "Trans. Sales Entry"."VAT Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "Trans. Sales Entry"."Gen. Prod. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATProdPostingGroup; "Trans. Sales Entry"."VAT Prod. Posting Group")
                {
                    MinOccurs = Zero;
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
            tableelement("Trans. Coupon Entry"; "LSC Trans. Coupon Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransCouponEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Coupon Entry"."Transaction No.")
                {
                }
                fieldelement(EntryType; "Trans. Coupon Entry"."Entry Type")
                {
                }
                fieldelement(LineNo; "Trans. Coupon Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Coupon Entry"."Receipt No.")
                {
                }
                fieldelement(Barcode; "Trans. Coupon Entry".Barcode)
                {
                }
                fieldelement(IssuedAmount; "Trans. Coupon Entry"."Issued Amount")
                {
                }
                fieldelement(UsedQuantity; "Trans. Coupon Entry"."Used Quantity")
                {
                }
                fieldelement(IssuedQuantity; "Trans. Coupon Entry"."Issued Quantity")
                {
                }
                fieldelement(UsedAmount; "Trans. Coupon Entry"."Used Amount")
                {
                }
                fieldelement(Discount; "Trans. Coupon Entry"."Discount %")
                {
                }
                fieldelement(DiscountAmount; "Trans. Coupon Entry"."Discount Amount")
                {
                }
                fieldelement(CouponIssuer; "Trans. Coupon Entry"."Coupon Issuer")
                {
                }
                fieldelement(ItemNo; "Trans. Coupon Entry"."Item No.")
                {
                }
                fieldelement(CouponFunction; "Trans. Coupon Entry"."Coupon Function")
                {
                }
                fieldelement(TransactionStatus; "Trans. Coupon Entry"."Transaction Status")
                {
                }
                fieldelement(StoreNo; "Trans. Coupon Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Coupon Entry"."POS Terminal No.")
                {
                }
                fieldelement(CouponCode; "Trans. Coupon Entry"."Coupon Code")
                {
                }
                fieldelement(Date; "Trans. Coupon Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(MemberAccountNo; "Trans. Coupon Entry"."Member Account No.")
                {
                }
                fieldelement(ValidFromDate; "Trans. Coupon Entry"."Valid From Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ValidToDate; "Trans. Coupon Entry"."Valid To Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CreatedbyOfferNo; "Trans. Coupon Entry"."Created by Offer No.")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Coupon Entry"."Replication Counter")
                {
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
            tableelement("Trans. Mix & Match Entry"; "LSC Trans. Mix & Match Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransMixMatchEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Mix & Match Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Mix & Match Entry"."Line No.")
                {
                }
                fieldelement(MixMatchGroup; "Trans. Mix & Match Entry"."Mix & Match Group")
                {
                }
                fieldelement(StoreNo; "Trans. Mix & Match Entry"."Store No.")
                {
                }
                fieldelement(Date; "Trans. Mix & Match Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Mix & Match Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(DiscountAmount; "Trans. Mix & Match Entry"."Discount Amount")
                {
                }
                fieldelement(Quantity; "Trans. Mix & Match Entry".Quantity)
                {
                }
                fieldelement(POSTerminalNo; "Trans. Mix & Match Entry"."POS Terminal No.")
                {
                }
                fieldelement(Counter; "Trans. Mix & Match Entry".Counter)
                {
                }
                fieldelement(Replicated; "Trans. Mix & Match Entry".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "Trans. Mix & Match Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Cash Declaration"; "LSC Trans. Cash Declaration")
            {
                MinOccurs = Zero;
                XmlName = 'TransCashDeclaration';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Cash Declaration"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Cash Declaration"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Cash Declaration"."Transaction No.")
                {
                }
                fieldelement(TenderType; "Trans. Cash Declaration"."Tender Type")
                {
                }
                fieldelement(CurrencyCode; "Trans. Cash Declaration"."Currency Code")
                {
                }
                fieldelement(Type; "Trans. Cash Declaration".Type)
                {
                }
                fieldelement(Amount; "Trans. Cash Declaration".Amount)
                {
                }
                fieldelement(Qty; "Trans. Cash Declaration"."Qty.")
                {
                }
                fieldelement(Total; "Trans. Cash Declaration".Total)
                {
                }
                fieldelement(ReceiptNo; "Trans. Cash Declaration"."Receipt No.")
                {
                }
                fieldelement(Description; "Trans. Cash Declaration".Description)
                {
                }
                fieldelement(StaffID; "Trans. Cash Declaration"."Staff ID")
                {
                }
                fieldelement(DeclType; "Trans. Cash Declaration"."Decl. Type")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Cash Declaration"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Safe Entry"; "LSC Trans. Safe Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransSafeEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Trans. Safe Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Safe Entry"."Line No.")
                {
                }
                fieldelement(SafeNo; "Trans. Safe Entry"."Safe No.")
                {
                }
                fieldelement(ReceiptNo; "Trans. Safe Entry"."Receipt No.")
                {
                }
                fieldelement(TransactionType; "Trans. Safe Entry"."Transaction Type")
                {
                }
                fieldelement(SafeType; "Trans. Safe Entry"."Safe Type")
                {
                }
                fieldelement(StatementCode; "Trans. Safe Entry"."Statement Code")
                {
                }
                fieldelement(BankBagNo; "Trans. Safe Entry"."Bank Bag No.")
                {
                }
                fieldelement(ExchangeRate; "Trans. Safe Entry"."Exchange Rate")
                {
                }
                fieldelement(TenderType; "Trans. Safe Entry"."Tender Type")
                {
                }
                fieldelement(Description; "Trans. Safe Entry".Description)
                {
                }
                fieldelement(AmountTendered; "Trans. Safe Entry"."Amount Tendered")
                {
                }
                fieldelement(CurrencyCode; "Trans. Safe Entry"."Currency Code")
                {
                }
                fieldelement(AmountinCurrency; "Trans. Safe Entry"."Amount in Currency")
                {
                }
                fieldelement(Uncounted; "Trans. Safe Entry".Uncounted)
                {
                }
                fieldelement(Date; "Trans. Safe Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Trans. Safe Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Trans. Safe Entry"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Trans. Safe Entry"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StaffID; "Trans. Safe Entry"."Staff ID")
                {
                }
                fieldelement(StoreNo; "Trans. Safe Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Safe Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionStatus; "Trans. Safe Entry"."Transaction Status")
                {
                }
                fieldelement(StatementNo; "Trans. Safe Entry"."Statement No.")
                {
                }
                fieldelement(BalAccountType; "Trans. Safe Entry"."Bal. Account Type")
                {
                }
                fieldelement(BalAccountNo; "Trans. Safe Entry"."Bal. Account No.")
                {
                }
                fieldelement(ManagersKeyLive; "Trans. Safe Entry"."Managers Key Live")
                {
                }
                fieldelement(ChangeLine; "Trans. Safe Entry"."Change Line")
                {
                }
                fieldelement(Counter; "Trans. Safe Entry".Counter)
                {
                }
                fieldelement(Replicated; "Trans. Safe Entry".Replicated)
                {
                }
                fieldelement(Quantity; "Trans. Safe Entry".Quantity)
                {
                }
                fieldelement("Z-ReportID"; "Trans. Safe Entry"."Z-Report ID")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Safe Entry"."Replication Counter")
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
                }
                fieldelement(EFTTransDate; "POS Card Entry"."EFT Trans. Date")
                {
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
            tableelement("POS Voided Trans. Line"; "LSC POS Voided Trans. Line")
            {
                MinOccurs = Zero;
                XmlName = 'POSVoidedTransLine';
                UseTemporary = true;
                fieldelement(EntryType; "POS Voided Trans. Line"."Entry Type")
                {
                }
                fieldelement(LineNo; "POS Voided Trans. Line"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "POS Voided Trans. Line"."Receipt No.")
                {
                }
                fieldelement(BarcodeNo; "POS Voided Trans. Line"."Barcode No.")
                {
                }
                fieldelement(Number; "POS Voided Trans. Line".Number)
                {
                }
                fieldelement(EntryStatus; "POS Voided Trans. Line"."Entry Status")
                {
                }
                fieldelement(CurrencyCode; "POS Voided Trans. Line"."Currency Code")
                {
                }
                fieldelement(VariantCode; "POS Voided Trans. Line"."Variant Code")
                {
                }
                fieldelement(Description; "POS Voided Trans. Line".Description)
                {
                }
                fieldelement(UnitofMeasure; "POS Voided Trans. Line"."Unit of Measure")
                {
                }
                fieldelement(StoreNo; "POS Voided Trans. Line"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "POS Voided Trans. Line"."POS Terminal No.")
                {
                }
                fieldelement(SalesStaff; "POS Voided Trans. Line"."Sales Staff")
                {
                }
                fieldelement(TextType; "POS Voided Trans. Line"."Text Type")
                {
                }
                fieldelement(ItemCategoryCode; "POS Voided Trans. Line"."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; "POS Voided Trans. Line"."Retail Product Code")
                {
                }
                fieldelement(Price; "POS Voided Trans. Line".Price)
                {
                }
                fieldelement(NetPrice; "POS Voided Trans. Line"."Net Price")
                {
                }
                fieldelement(Quantity; "POS Voided Trans. Line".Quantity)
                {
                }
                fieldelement(PriceGroupCode; "POS Voided Trans. Line"."Price Group Code")
                {
                }
                fieldelement(VATCode; "POS Voided Trans. Line"."VAT Code")
                {
                }
                fieldelement(VAT; "POS Voided Trans. Line"."VAT %")
                {
                }
                fieldelement(Discount; "POS Voided Trans. Line"."Discount %")
                {
                }
                fieldelement(DiscountAmount; "POS Voided Trans. Line"."Discount Amount")
                {
                }
                fieldelement(CostAmount; "POS Voided Trans. Line"."Cost Amount")
                {
                }
                fieldelement(CostPrice; "POS Voided Trans. Line"."Cost Price")
                {
                }
                fieldelement(NetAmount; "POS Voided Trans. Line"."Net Amount")
                {
                }
                fieldelement(VATAmount; "POS Voided Trans. Line"."VAT Amount")
                {
                }
                fieldelement(Amount; "POS Voided Trans. Line".Amount)
                {
                }
                fieldelement(AmountInCurrency; "POS Voided Trans. Line"."Amount In Currency")
                {
                }
                fieldelement(CardType; "POS Voided Trans. Line"."Card Type")
                {
                }
                fieldelement(CardCustomerCoupItemNo; "POS Voided Trans. Line"."Card/Customer/Coup.Item No")
                {
                }
                fieldelement(VatBusPostingGroup; "POS Voided Trans. Line"."Vat Bus. Posting Group")
                {
                }
                fieldelement(VatProdPostingGroup; "POS Voided Trans. Line"."Vat Prod. Posting Group")
                {
                }
                fieldelement(GenBusPostingGroup; "POS Voided Trans. Line"."Gen. Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(GenProdPostingGroup; "POS Voided Trans. Line"."Gen. Prod. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ItemDiscGroup; "POS Voided Trans. Line"."Item Disc. Group")
                {
                }
                fieldelement(NoDiscountAllowed; "POS Voided Trans. Line"."No Discount Allowed")
                {
                }
                fieldelement(CardEntryNo; "POS Voided Trans. Line"."Card Entry No.")
                {
                }
                fieldelement(CouponEANOrg; "POS Voided Trans. Line"."Coupon EAN Org.")
                {
                }
                fieldelement(ItemNumberScanned; "POS Voided Trans. Line"."Item Number Scanned")
                {
                }
                fieldelement(PriceinBarcode; "POS Voided Trans. Line"."Price in Barcode")
                {
                }
                fieldelement(PriceChange; "POS Voided Trans. Line"."Price Change")
                {
                }
                fieldelement(WeightmanuallyEntered; "POS Voided Trans. Line"."Weight manually Entered")
                {
                }
                fieldelement(ScaleItem; "POS Voided Trans. Line"."Scale Item")
                {
                }
                fieldelement(QuantityinBarcode; "POS Voided Trans. Line"."Quantity in Barcode")
                {
                }
                fieldelement(DispensePrinting; "POS Voided Trans. Line"."Dispense Printing")
                {
                }
                fieldelement(LinkedNonotOrig; "POS Voided Trans. Line"."Linked No. not Orig.")
                {
                }
                fieldelement(OrigofaLinkedItemList; "POS Voided Trans. Line"."Orig. of a Linked Item List")
                {
                }
                fieldelement(PriceOverride; "POS Voided Trans. Line"."Price Override")
                {
                }
                fieldelement(ItemDeptNegative; "POS Voided Trans. Line"."Item/Dept. Negative")
                {
                }
                fieldelement(CountasOne; "POS Voided Trans. Line"."Count as One")
                {
                }
                fieldelement(ItemPostingGroup; "POS Voided Trans. Line"."Item Posting Group")
                {
                }
                fieldelement(TotalRoundedAmt; "POS Voided Trans. Line"."Total Rounded Amt.")
                {
                }
                fieldelement(OrgPriceIncVAT; "POS Voided Trans. Line"."Org. Price Inc. VAT")
                {
                }
                fieldelement(OrgPriceExcVAT; "POS Voided Trans. Line"."Org. Price Exc. VAT")
                {
                }
                fieldelement(SerialNo; "POS Voided Trans. Line"."Serial No.")
                {
                }
                fieldelement(LotNo; "POS Voided Trans. Line"."Lot No.")
                {
                }
                fieldelement(ExpirationDate; "POS Voided Trans. Line"."Expiration Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(OfferBlockedPoints; "POS Voided Trans. Line"."Offer Blocked Points")
                {
                }
                fieldelement(OrigfromInfocode; "POS Voided Trans. Line"."Orig. from Infocode")
                {
                }
                fieldelement(OrigfromSubcode; "POS Voided Trans. Line"."Orig. from Subcode")
                {
                }
                fieldelement(InfocodeEntryLineNo; "POS Voided Trans. Line"."Infocode Entry Line No.")
                {
                }
                fieldelement(InfocodeSelectedQty; "POS Voided Trans. Line"."Infocode Selected Qty.")
                {
                }
                fieldelement(ShiftedfromLineNo; "POS Voided Trans. Line"."Shifted from Line No.")
                {
                }
                fieldelement(SplitfromLineNoQty; "POS Voided Trans. Line"."Split from Line No. Qty.")
                {
                }
                fieldelement(SplitfromLineNo; "POS Voided Trans. Line"."Split from Line No.")
                {
                }
                fieldelement(DiscInfoLineNo; "POS Voided Trans. Line"."Disc. Info Line No.")
                {
                }
                fieldelement(DiscountTriggered; "POS Voided Trans. Line"."Discount Triggered")
                {
                }
                fieldelement(QuantityDiscounted; "POS Voided Trans. Line"."Quantity Discounted")
                {
                }
                fieldelement(PeriodicDiscType; "POS Voided Trans. Line"."Periodic Disc. Type")
                {
                }
                fieldelement(PeriodicDiscGroup; "POS Voided Trans. Line"."Periodic Disc. Group")
                {
                }
                fieldelement(InfoCodeDiscDisable; "POS Voided Trans. Line"."InfoCode Disc. Disable")
                {
                }
                fieldelement(InfoCodeDisc; "POS Voided Trans. Line"."InfoCode Disc. %")
                {
                }
                fieldelement(PeriodicDisc; "POS Voided Trans. Line"."Periodic Disc. %")
                {
                }
                fieldelement(PromotionNo; "POS Voided Trans. Line"."Promotion No.")
                {
                }
                fieldelement(MixMatchLineNo; "POS Voided Trans. Line"."Mix & Match Line No.")
                {
                }
                fieldelement(LineDisc; "POS Voided Trans. Line"."Line Disc. %")
                {
                }
                fieldelement(TotalDisc; "POS Voided Trans. Line"."Total Disc. %")
                {
                }
                fieldelement(TotDiscInfoLineNo; "POS Voided Trans. Line"."Tot. Disc Info Line No.")
                {
                }
                fieldelement(TotalDiscAmount; "POS Voided Trans. Line"."Total Disc. Amount")
                {
                }
                fieldelement(PeriodicDiscountAmount; "POS Voided Trans. Line"."Periodic Discount Amount")
                {
                }
                fieldelement(DealLine; "POS Voided Trans. Line"."Deal Line")
                {
                }
                fieldelement(DealModifierLineNo; "POS Voided Trans. Line"."Deal Modifier Line No.")
                {
                }
                fieldelement(DealLineNo; "POS Voided Trans. Line"."Deal Line No.")
                {
                }
                fieldelement(DealTotalDiscAmt; "POS Voided Trans. Line"."Deal Total Disc. Amt.")
                {
                }
                fieldelement(PromptedforIPO; "POS Voided Trans. Line"."Prompted for IPO")
                {
                }
                fieldelement(CustomerPrice; "POS Voided Trans. Line"."Customer Price")
                {
                }
                fieldelement(ItemPointOfferMemberPoints; "POS Voided Trans. Line"."Item Point Offer Member Points")
                {
                }
                fieldelement(CustomerDisc; "POS Voided Trans. Line"."Customer Disc. %")
                {
                }
                fieldelement(CustomerQtyUsed; "POS Voided Trans. Line"."Customer Qty Used")
                {
                }
                fieldelement(CouponQtyUsed; "POS Voided Trans. Line"."Coupon Qty Used")
                {
                }
                fieldelement(CouponDiscountAmount; "POS Voided Trans. Line"."Coupon Discount Amount")
                {
                }
                fieldelement(ParentTransactionDocNo; "POS Voided Trans. Line"."Parent Transaction Doc. No.")
                {
                }
                fieldelement(ParentLine; "POS Voided Trans. Line"."Parent Line")
                {
                }
                fieldelement(RoundNo; "POS Voided Trans. Line"."Round No.")
                {
                }
                fieldelement(GuestSeatNo; "POS Voided Trans. Line"."Guest/Seat No.")
                {
                }
                fieldelement(Marked; "POS Voided Trans. Line".Marked)
                {
                }
                fieldelement(GroupMarking; "POS Voided Trans. Line"."Group Marking")
                {
                }
                fieldelement(ParentCompression; "POS Voided Trans. Line"."Parent Compression")
                {
                }
                fieldelement(JournalCompression; "POS Voided Trans. Line"."Journal Compression")
                {
                }
                fieldelement(KitchenRouting; "POS Voided Trans. Line"."Kitchen Routing")
                {
                }
                fieldelement(SplitOriginLineNo; "POS Voided Trans. Line"."Split Origin Line No.")
                {
                }
                fieldelement(ViewLineinJournal; "POS Voided Trans. Line"."View Line in Journal")
                {
                }
                fieldelement("System-ExcludefromOffers"; "POS Voided Trans. Line"."System-Exclude from Offers")
                {
                }
                fieldelement("System-UnchangableQuantity"; "POS Voided Trans. Line"."System-Unchangable Quantity")
                {
                }
                fieldelement("System-UnchangablePrice"; "POS Voided Trans. Line"."System-Unchangable Price")
                {
                }
                fieldelement("System-UnchangableDiscounts"; "POS Voided Trans. Line"."System-Unchangable Discounts")
                {
                }
                fieldelement("System-ExcludefromVoid"; "POS Voided Trans. Line"."System-Exclude from Void")
                {
                }
                fieldelement("System-UnchangableOffer"; "POS Voided Trans. Line"."System-Unchangable Offer")
                {
                }
                fieldelement("System-ExcludefromRefund"; "POS Voided Trans. Line"."System-Exclude from Refund")
                {
                }
                fieldelement("System-BlockPromotionPrice"; "POS Voided Trans. Line"."System-Block Promotion Price")
                {
                }
                fieldelement("System-BlockPeriodicDiscount"; "POS Voided Trans. Line"."System-Block Periodic Discount")
                {
                }
                fieldelement(TransDate; "POS Voided Trans. Line"."Trans. Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TransTime; "POS Voided Trans. Line"."Trans. Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Prepayment; "POS Voided Trans. Line"."Prepayment %")
                {
                }
                fieldelement(PrepmtLineAmount; "POS Voided Trans. Line"."Prepmt. Line Amount")
                {
                }
                fieldelement(PrepaymentLine; "POS Voided Trans. Line"."Prepayment Line")
                {
                }
                fieldelement(PrepaymentVoided; "POS Voided Trans. Line"."Prepayment Voided")
                {
                }
                fieldelement(CouponFunction; "POS Voided Trans. Line"."Coupon Function")
                {
                }
                fieldelement(CouponCode; "POS Voided Trans. Line"."Coupon Code")
                {
                }
                fieldelement(CouponAmount; "POS Voided Trans. Line"."Coupon Amount")
                {
                }
                fieldelement(CouponDiscount; "POS Voided Trans. Line"."Coupon Discount %")
                {
                }
                fieldelement(ValidinTransaction; "POS Voided Trans. Line"."Valid in Transaction")
                {
                }
                fieldelement(NoofCouponstoPrint; "POS Voided Trans. Line"."No. of Coupons to Print")
                {
                }
                fieldelement(AutomaticallyCreated; "POS Voided Trans. Line"."Automatically Created")
                {
                }
                fieldelement(CouponBarcodeNo; "POS Voided Trans. Line"."Coupon Barcode No.")
                {
                }
                fieldelement(FirstValidDate; "POS Voided Trans. Line"."First Valid Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LastValidDate; "POS Voided Trans. Line"."Last Valid Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CreatedorUsedbyOfferNo; "POS Voided Trans. Line"."Created or Used by Offer No.")
                {
                }
                fieldelement(CouponLinkedtoLineNo; "POS Voided Trans. Line"."Coupon Linked to Line No.")
                {
                }
                fieldelement(Replicated; "POS Voided Trans. Line".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "POS Voided Trans. Line"."Replication Counter")
                {
                }
                fieldelement(DiscountAmtForPrinting; "POS Voided Trans. Line"."Discount Amt. For Printing")
                {
                }
                fieldelement(CouponAmtForPrinting; "POS Voided Trans. Line"."Coupon Amt. For Printing")
                {
                }
                fieldelement(SalesType; "POS Voided Trans. Line"."Sales Type")
                {
                }
                fieldelement(RestaurantMenuTypeCode; "POS Voided Trans. Line"."Restaurant Menu Type Code")
                {
                }
                fieldelement(RestaurantMenuType; "POS Voided Trans. Line"."Restaurant Menu Type")
                {
                }
                fieldelement(ExcludedBomLineNo; "POS Voided Trans. Line"."Excluded Bom Line No.")
                {
                }
                fieldelement(ExcludedBomItem; "POS Voided Trans. Line"."Excluded Bom Item")
                {
                }
                fieldelement(OrgPriceBeforeRounding; "POS Voided Trans. Line"."Org. Price Before Rounding")
                {
                }
                fieldelement(DealAddedAmount; "POS Voided Trans. Line"."Deal Added Amount")
                {
                }
                fieldelement(ParentItemNo; "POS Voided Trans. Line"."Parent Item No.")
                {
                }
                fieldelement(ProductionTimeMin; "POS Voided Trans. Line"."Production Time (Min.)")
                {
                }
                fieldelement(TimeModifiedMin; "POS Voided Trans. Line"."Time Modified (Min.)")
                {
                }
                fieldelement(OrigTransStore; "POS Voided Trans. Line"."Orig. Trans. Store")
                {
                }
                fieldelement(OrigTransPos; "POS Voided Trans. Line"."Orig. Trans. Pos")
                {
                }
                fieldelement(OrigTransNo; "POS Voided Trans. Line"."Orig. Trans. No.")
                {
                }
                fieldelement(OrigTransLineNo; "POS Voided Trans. Line"."Orig. Trans. Line No.")
                {
                }
                fieldelement(RemainingQuantity; "POS Voided Trans. Line"."Remaining Quantity")
                {
                }
                fieldelement(OrigPerDiscType; "POS Voided Trans. Line"."Orig Per. Disc. Type")
                {
                }
                fieldelement(OrigPerDiscGroup; "POS Voided Trans. Line"."Orig Per. Disc. Group")
                {
                }
                fieldelement(SafeType; "POS Voided Trans. Line"."Safe Type")
                {
                }
                fieldelement(BenefitItem; "POS Voided Trans. Line"."Benefit Item")
                {
                }
                fieldelement(Fuelitem; "POS Voided Trans. Line"."Fuel item")
                {
                }
                fieldelement(RetailSpecialOrder; "POS Voided Trans. Line"."Retail Special Order")
                {
                }
                fieldelement(DeliveringMethod; "POS Voided Trans. Line"."Delivering Method")
                {
                }
                fieldelement(VendorDeliversto; "POS Voided Trans. Line"."Vendor Delivers to")
                {
                }
                fieldelement(Sourcing; "POS Voided Trans. Line".Sourcing)
                {
                }
                fieldelement(Deliverfrom; "POS Voided Trans. Line"."Deliver from")
                {
                }
                fieldelement(DeliveryLocationCode; "POS Voided Trans. Line"."Delivery Location Code")
                {
                }
                fieldelement(SetLimitAmount; "POS Voided Trans. Line"."Set Limit Amount")
                {
                }
                fieldelement(SPOPrepayment; "POS Voided Trans. Line"."SPO Prepayment %")
                {
                }
                fieldelement("Payment-Actual"; "POS Voided Trans. Line"."Payment-Actual")
                {
                }
                fieldelement(WhseProcess; "POS Voided Trans. Line"."Whse Process")
                {
                }
                fieldelement(Status; "POS Voided Trans. Line".Status)
                {
                }
                fieldelement(DeliveryStatus; "POS Voided Trans. Line"."Delivery Status")
                {
                }
                fieldelement(ConfigurationID; "POS Voided Trans. Line"."Configuration ID")
                {
                }
                fieldelement(MandatoryOptionsExist; "POS Voided Trans. Line"."Mandatory Options Exist")
                {
                }
                fieldelement(AddChargeOption; "POS Voided Trans. Line"."Add.Charge Option")
                {
                }
                fieldelement(DeliveryReferenceNo; "POS Voided Trans. Line"."Delivery Reference No")
                {
                }
                fieldelement(DeliveryUserID; "POS Voided Trans. Line"."Delivery User ID")
                {
                }
                fieldelement(DeliveryDateTime; "POS Voided Trans. Line"."Delivery Date Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Counter; "POS Voided Trans. Line".Counter)
                {
                }
                fieldelement(OptionValueText; "POS Voided Trans. Line"."Option Value Text")
                {
                }
                fieldelement(EstimatedDeliveryDate; "POS Voided Trans. Line"."Estimated Delivery Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NolaterthanDate; "POS Voided Trans. Line"."No later than Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement("Payment-AtOrderEntry-Limit"; "POS Voided Trans. Line"."Payment-At Order Entry-Limit")
                {
                }
                fieldelement("Payment-AtDelivery-Limit"; "POS Voided Trans. Line"."Payment-At Delivery-Limit")
                {
                }
                fieldelement(ReturnPolicy; "POS Voided Trans. Line"."Return Policy")
                {
                }
                fieldelement(NonRefundAmount; "POS Voided Trans. Line"."Non Refund Amount")
                {
                }
                fieldelement(SourcingStatus; "POS Voided Trans. Line"."Sourcing Status")
                {
                }
                fieldelement("Payment-AtPurchaseOrder-Limit"; "POS Voided Trans. Line"."Payment-At PurchaseOrder-Limit")
                {
                }
                fieldelement(SPODocumentMethod; "POS Voided Trans. Line"."SPO Document Method")
                {
                }
                fieldelement(StoreSalesLocation; "POS Voided Trans. Line"."Store Sales Location")
                {
                }
                fieldelement(SPOWhseLocation; "POS Voided Trans. Line"."SPO Whse Location")
                {
                }
                fieldelement(VendorNo; "POS Voided Trans. Line"."Vendor No.")
                {
                }
                fieldelement(AdditionalChargeCode; "POS Voided Trans. Line"."Additional Charge Code")
                {
                }
                fieldelement(IncludeInParentLine; "POS Voided Trans. Line"."Include In Parent Line")
                {
                }
                fieldelement(AddChargeExists; "POS Voided Trans. Line"."Add. Charge Exists")
                {
                }
                fieldelement(PaymentProfileCode; "POS Voided Trans. Line"."Payment Profile Code")
                {
                }
                fieldelement(CancelPermitted; "POS Voided Trans. Line"."Cancel Permitted")
                {
                }
                fieldelement(AddChrgLinkedtoLine; "POS Voided Trans. Line"."Add.Chrg Linked to Line")
                {
                }
                fieldelement(RetailChargeCode; "POS Voided Trans. Line"."Retail Charge Code")
                {
                }
                fieldelement(SpecialOrderDepositEntry; "POS Voided Trans. Line"."Special Order Deposit Entry")
                {
                }
                fieldelement(CreatedbyStaffID; "POS Voided Trans. Line"."Created by Staff ID")
                {
                }
            }
            tableelement("Transaction Status"; "LSC Transaction Status")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionStatus';
                UseTemporary = true;
                fieldelement(StoreNo; "Transaction Status"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Transaction Status"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Transaction Status"."Transaction No.")
                {
                }
                fieldelement(Status; "Transaction Status".Status)
                {
                }
                fieldelement(StatementNo; "Transaction Status"."Statement No.")
                {
                }
                fieldelement(PostedStatementNo; "Transaction Status"."Posted Statement No.")
                {
                }
                fieldelement(Date; "Transaction Status".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(BlockedCustomer; "Transaction Status"."Blocked Customer")
                {
                }
                fieldelement(ItemsBlocked; "Transaction Status"."Items Blocked")
                {
                }
                fieldelement(SalePmtDifference; "Transaction Status"."Sale/Pmt. Difference")
                {
                }
                fieldelement(CustomerNo; "Transaction Status"."Customer No.")
                {
                }
                fieldelement(AmounttoAccount; "Transaction Status"."Amount to Account")
                {
                }
                fieldelement(ItemsBarcNotonFile; "Transaction Status"."Items/Barc. Not on File")
                {
                }
                fieldelement(TransonWrongShift; "Transaction Status"."Trans. on Wrong Shift")
                {
                }
                fieldelement(SalesAmount; "Transaction Status"."Sales Amount")
                {
                }
                fieldelement(VATAmount; "Transaction Status"."VAT Amount")
                {
                }
                fieldelement(TotalDiscount; "Transaction Status"."Total Discount")
                {
                }
                fieldelement(LineDiscount; "Transaction Status"."Line Discount")
                {
                }
                fieldelement(Income; "Transaction Status".Income)
                {
                }
                fieldelement(Expenses; "Transaction Status".Expenses)
                {
                }
                fieldelement(DiscountTotalAmount; "Transaction Status"."Discount Total Amount")
                {
                }
                fieldelement(NoofTransSalesEntries; "Transaction Status"."No of Trans. Sales Entries")
                {
                }
                fieldelement(InvTransaction; "Transaction Status"."Inv. Transaction")
                {
                }
                fieldelement(SerialLotNoNotValid; "Transaction Status"."Serial/Lot No. Not Valid")
                {
                }
                fieldelement(AdvancedShiftNo; "Transaction Status"."Advanced Shift No.")
                {
                }
                fieldelement(ReplicationCounter; "Transaction Status"."Replication Counter")
                {
                }
                fieldelement(IncludedinStatistics; "Transaction Status"."Included in Statistics")
                {
                }
            }
            tableelement("Trans. Sales Entry Status"; "LSC Trans. Sales Entry Status")
            {
                MinOccurs = Zero;
                XmlName = 'TransSalesEntryStatus';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Sales Entry Status"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Sales Entry Status"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Sales Entry Status"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Sales Entry Status"."Line No.")
                {
                }
                fieldelement(Status; "Trans. Sales Entry Status".Status)
                {
                }
                fieldelement(StatementNo; "Trans. Sales Entry Status"."Statement No.")
                {
                }
                fieldelement(ItemNo; "Trans. Sales Entry Status"."Item No.")
                {
                }
                fieldelement(VariantCode; "Trans. Sales Entry Status"."Variant Code")
                {
                }
                fieldelement(Quantity; "Trans. Sales Entry Status".Quantity)
                {
                }
                fieldelement(Date; "Trans. Sales Entry Status".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(SerialNo; "Trans. Sales Entry Status"."Serial No.")
                {
                }
                fieldelement(LotNo; "Trans. Sales Entry Status"."Lot No.")
                {
                }
                fieldelement(ReplicationCounter; "Trans. Sales Entry Status"."Replication Counter")
                {
                }
            }
            tableelement("Transaction Order Header"; "LSC Transaction Order Header")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionOrderHeader';
                UseTemporary = true;
                fieldelement(StoreNo; "Transaction Order Header"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Transaction Order Header"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Transaction Order Header"."Transaction No.")
                {
                }
                fieldelement(TransDate; "Transaction Order Header"."Trans. Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ReceiptNo; "Transaction Order Header"."Receipt No.")
                {
                }
                fieldelement(Processed; "Transaction Order Header".Processed)
                {
                }
                fieldelement(OrderCollect; "Transaction Order Header"."Order Collect")
                {
                }
                fieldelement(AdditionalPayment; "Transaction Order Header"."Additional Payment")
                {
                }
                fieldelement(FirstName; "Transaction Order Header"."First Name")
                {
                }
                fieldelement(MiddleName; "Transaction Order Header"."Middle Name")
                {
                }
                fieldelement(LastName; "Transaction Order Header"."Last Name")
                {
                }
                fieldelement(FullName; "Transaction Order Header"."Full Name")
                {
                }
                fieldelement(Address; "Transaction Order Header".Address)
                {
                }
                fieldelement(Address2; "Transaction Order Header"."Address 2")
                {
                }
                fieldelement(City; "Transaction Order Header".City)
                {
                }
                fieldelement(County; "Transaction Order Header".County)
                {
                }
                fieldelement(PostCode; "Transaction Order Header"."Post Code")
                {
                }
                fieldelement(PhoneNo; "Transaction Order Header"."Phone No.")
                {
                }
                fieldelement(Email; "Transaction Order Header".Email)
                {
                }
                fieldelement(CountryRegionCode; "Transaction Order Header"."Country/Region Code")
                {
                }
                fieldelement(HouseApartmentNo; "Transaction Order Header"."House/Apartment No.")
                {
                }
                fieldelement(MobilePhoneNo; "Transaction Order Header"."Mobile Phone No.")
                {
                }
                fieldelement(DaytimePhoneNo; "Transaction Order Header"."Daytime Phone No.")
                {
                }
                fieldelement(CustomerNo; "Transaction Order Header"."Customer No.")
                {
                }
                fieldelement(PrimaryContact; "Transaction Order Header"."Primary Contact")
                {
                }
                fieldelement("Ship-toFirstName"; "Transaction Order Header"."Ship-to First Name")
                {
                }
                fieldelement("Ship-toLastName"; "Transaction Order Header"."Ship-to Last Name")
                {
                }
                fieldelement("Ship-toAddress1"; "Transaction Order Header"."Ship-to Address 1")
                {
                }
                fieldelement("Ship-toAddress2"; "Transaction Order Header"."Ship-to Address 2")
                {
                }
                fieldelement("Ship-toCity"; "Transaction Order Header"."Ship-to City")
                {
                }
                fieldelement("Ship-toCounty"; "Transaction Order Header"."Ship-to County")
                {
                }
                fieldelement("Ship-toPostCode"; "Transaction Order Header"."Ship-to Post Code")
                {
                }
                fieldelement("Ship-toPhoneNo"; "Transaction Order Header"."Ship-to Phone No.")
                {
                }
                fieldelement("Ship-toCountryRegionCode"; "Transaction Order Header"."Ship-to Country/Region Code")
                {
                }
                fieldelement("Ship-toHouseApartmentNo"; "Transaction Order Header"."Ship-to House/Apartment No.")
                {
                }
                fieldelement(ContactViaMail; "Transaction Order Header"."Contact Via Mail")
                {
                }
                fieldelement(ContactViaPhone; "Transaction Order Header"."Contact Via Phone")
                {
                }
                fieldelement(ContactViaEmail; "Transaction Order Header"."Contact Via Email")
                {
                }
                fieldelement(GeneralComments; "Transaction Order Header"."General Comments")
                {
                }
                fieldelement(DeliveryInstructions; "Transaction Order Header"."Delivery Instructions")
                {
                }
                fieldelement(MemberCardNo; "Transaction Order Header"."Member Card No.")
                {
                }
                fieldelement(SourceType; "Transaction Order Header"."Source Type")
                {
                }
                fieldelement(Replicated; "Transaction Order Header".Replicated)
                {
                }
                fieldelement(ReplicationCounter; "Transaction Order Header"."Replication Counter")
                {
                }
                fieldelement(RetailSpecialOrder; "Transaction Order Header"."Retail Special Order")
                {
                }
                fieldelement(SourceCode; "Transaction Order Header"."Source Code")
                {
                }
                fieldelement(ShippingZonesCode; "Transaction Order Header"."Shipping Zones Code")
                {
                }
                fieldelement(ShippingZonesDescription; "Transaction Order Header"."Shipping Zones Description")
                {
                }
                fieldelement(OrderNo; "Transaction Order Header"."Order No.")
                {
                }
                fieldelement(ExternalDocumentNo; "Transaction Order Header"."External Document No.")
                {
                }
                fieldelement(ReservedByPOSNo; "Transaction Order Header"."Reserved By POS No.")
                {
                }
                fieldelement(WebTransactionGUID; "Transaction Order Header"."Web Transaction GUID")
                {
                }
                fieldelement(OrderAmountforPrinting; "Transaction Order Header"."Order Amount for Printing")
                {
                }
                fieldelement(DepositAmountforPrinting; "Transaction Order Header"."Deposit Amount for Printing")
                {
                }
                fieldelement("Sell-toContactNo"; "Transaction Order Header"."Sell-to Contact No.")
                {
                }
                fieldelement(ErrorText; "Transaction Order Header"."Error Text")
                {
                }
                fieldelement(ErrorinProcess; "Transaction Order Header"."Error in Process")
                {
                }
                fieldelement(Cancelation; "Transaction Order Header".Cancelation)
                {
                }
                fieldelement(PreCancelation; "Transaction Order Header"."Pre Cancelation")
                {
                }
                fieldelement(TaxAreaCode; "Transaction Order Header"."Tax Area Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxLiable; "Transaction Order Header"."Tax Liable")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxExemptionNo; "Transaction Order Header"."Tax Exemption No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NetIncExpAmount; "Transaction Order Header"."Net Income/Exp. Amount")
                {
                    MinOccurs = Zero;
                }
            }
            tableelement("Transaction Order Entry"; "LSC Transaction Order Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionOrderEntry';
                UseTemporary = true;
                fieldelement(TransactionNo; "Transaction Order Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Transaction Order Entry"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Transaction Order Entry"."Receipt No.")
                {
                }
                fieldelement(BarcodeNo; "Transaction Order Entry"."Barcode No.")
                {
                }
                fieldelement(ItemNo; "Transaction Order Entry"."Item No.")
                {
                }
                fieldelement(SalesStaff; "Transaction Order Entry"."Sales Staff")
                {
                }
                fieldelement(ItemCategoryCode; "Transaction Order Entry"."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; "Transaction Order Entry"."Retail Product Code")
                {
                }
                fieldelement(Price; "Transaction Order Entry".Price)
                {
                }
                fieldelement(NetPrice; "Transaction Order Entry"."Net Price")
                {
                }
                fieldelement(Quantity; "Transaction Order Entry".Quantity)
                {
                }
                fieldelement(PriceGroupCode; "Transaction Order Entry"."Price Group Code")
                {
                }
                fieldelement(VATBusPostingGroup; "Transaction Order Entry"."VAT Bus. Posting Group")
                {
                }
                fieldelement(VATCode; "Transaction Order Entry"."VAT Code")
                {
                }
                fieldelement(xTransactionStatus; "Transaction Order Entry"."xTransaction Status")
                {
                }
                fieldelement(DiscountAmount; "Transaction Order Entry"."Discount Amount")
                {
                }
                fieldelement(CostAmount; "Transaction Order Entry"."Cost Amount")
                {
                }
                fieldelement(Date; "Transaction Order Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Time; "Transaction Order Entry".Time)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShiftNo; "Transaction Order Entry"."Shift No.")
                {
                }
                fieldelement(ShiftDate; "Transaction Order Entry"."Shift Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NetAmount; "Transaction Order Entry"."Net Amount")
                {
                }
                fieldelement(VATAmount; "Transaction Order Entry"."VAT Amount")
                {
                }
                fieldelement(PromotionNo; "Transaction Order Entry"."Promotion No.")
                {
                }
                fieldelement(StandardNetPrice; "Transaction Order Entry"."Standard Net Price")
                {
                }
                fieldelement(DiscAmountFromStdPrice; "Transaction Order Entry"."Disc. Amount From Std. Price")
                {
                }
                fieldelement(xStatementNo; "Transaction Order Entry"."xStatement No.")
                {
                }
                fieldelement(CustomerNo; "Transaction Order Entry"."Customer No.")
                {
                }
                fieldelement(Section; "Transaction Order Entry".Section)
                {
                }
                fieldelement(Shelf; "Transaction Order Entry".Shelf)
                {
                }
                fieldelement(StatementCode; "Transaction Order Entry"."Statement Code")
                {
                }
                fieldelement(ItemDiscGroup; "Transaction Order Entry"."Item Disc. Group")
                {
                }
                fieldelement(TransactionCode; "Transaction Order Entry"."Transaction Code")
                {
                }
                fieldelement(StoreNo; "Transaction Order Entry"."Store No.")
                {
                }
                fieldelement(ItemNumberScanned; "Transaction Order Entry"."Item Number Scanned")
                {
                }
                fieldelement(KeyboardItemEntry; "Transaction Order Entry"."Keyboard Item Entry")
                {
                }
                fieldelement(PriceinBarcode; "Transaction Order Entry"."Price in Barcode")
                {
                }
                fieldelement(PriceChange; "Transaction Order Entry"."Price Change")
                {
                }
                fieldelement(WeightManuallyEntered; "Transaction Order Entry"."Weight Manually Entered")
                {
                }
                fieldelement(LinewasDiscounted; "Transaction Order Entry"."Line was Discounted")
                {
                }
                fieldelement(ScaleItem; "Transaction Order Entry"."Scale Item")
                {
                }
                fieldelement(WeightItem; "Transaction Order Entry"."Weight Item")
                {
                }
                fieldelement(ReturnNoSale; "Transaction Order Entry"."Return No Sale")
                {
                }
                fieldelement(ItemCorrectedLine; "Transaction Order Entry"."Item Corrected Line")
                {
                }
                fieldelement(TypeofSale; "Transaction Order Entry"."Type of Sale")
                {
                }
                fieldelement(LinkedNonotOrig; "Transaction Order Entry"."Linked No. not Orig.")
                {
                }
                fieldelement(OrigofaLinkedItemList; "Transaction Order Entry"."Orig. of a Linked Item List")
                {
                }
                fieldelement(POSTerminalNo; "Transaction Order Entry"."POS Terminal No.")
                {
                }
                fieldelement(StaffID; "Transaction Order Entry"."Staff ID")
                {
                }
                fieldelement(ItemPostingGroup; "Transaction Order Entry"."Item Posting Group")
                {
                }
                fieldelement(TotalRoundedAmt; "Transaction Order Entry"."Total Rounded Amt.")
                {
                }
                fieldelement(Counter; "Transaction Order Entry".Counter)
                {
                }
                fieldelement(VariantCode; "Transaction Order Entry"."Variant Code")
                {
                }
                fieldelement(SerialNo; "Transaction Order Entry"."Serial No.")
                {
                }
                fieldelement(SerialLotNoNotValid; "Transaction Order Entry"."Serial/Lot No. Not Valid")
                {
                }
                fieldelement(LotNo; "Transaction Order Entry"."Lot No.")
                {
                }
                fieldelement(ExpirationDate; "Transaction Order Entry"."Expiration Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(MemberPointsType; "Transaction Order Entry"."Member Points Type")
                {
                }
                fieldelement(MemberPoints; "Transaction Order Entry"."Member Points")
                {
                }
                fieldelement(OfferBlockedPoints; "Transaction Order Entry"."Offer Blocked Points")
                {
                }
                fieldelement(LineDiscount; "Transaction Order Entry"."Line Discount")
                {
                }
                fieldelement(Replicated; "Transaction Order Entry".Replicated)
                {
                }
                fieldelement(CustomerDiscount; "Transaction Order Entry"."Customer Discount")
                {
                }
                fieldelement(InfocodeDiscount; "Transaction Order Entry"."Infocode Discount")
                {
                }
                fieldelement(CustInvoiceDiscount; "Transaction Order Entry"."Cust. Invoice Discount")
                {
                }
                fieldelement(UnitofMeasure; "Transaction Order Entry"."Unit of Measure")
                {
                }
                fieldelement(UOMQuantity; "Transaction Order Entry"."UOM Quantity")
                {
                }
                fieldelement(UOMPrice; "Transaction Order Entry"."UOM Price")
                {
                }
                fieldelement(TotalDiscount; "Transaction Order Entry"."Total Discount")
                {
                }
                fieldelement(TotalDisc; "Transaction Order Entry"."Total Disc.%")
                {
                }
                fieldelement(TotDiscInfoLineNo; "Transaction Order Entry"."Tot. Disc Info Line No.")
                {
                }
                fieldelement(PeriodicDiscType; "Transaction Order Entry"."Periodic Disc. Type")
                {
                }
                fieldelement(PeriodicDiscGroup; "Transaction Order Entry"."Periodic Disc. Group")
                {
                }
                fieldelement(PeriodicDiscount; "Transaction Order Entry"."Periodic Discount")
                {
                }
                fieldelement(DealLine; "Transaction Order Entry"."Deal Line")
                {
                }
                fieldelement(DealHeaderLineNo; "Transaction Order Entry"."Deal Header Line No.")
                {
                }
                fieldelement(DealLineNo; "Transaction Order Entry"."Deal Line No.")
                {
                }
                fieldelement(DealLineAddedAmt; "Transaction Order Entry"."Deal Line Added Amt.")
                {
                }
                fieldelement(DealModifierAddedAmt; "Transaction Order Entry"."Deal Modifier Added Amt.")
                {
                }
                fieldelement(DealModifierLineNo; "Transaction Order Entry"."Deal Modifier Line No.")
                {
                }
                fieldelement(DiscountAmtForPrinting; "Transaction Order Entry"."Discount Amt. For Printing")
                {
                }
                fieldelement(CouponDiscount; "Transaction Order Entry"."Coupon Discount")
                {
                }
                fieldelement(CouponAmtForPrinting; "Transaction Order Entry"."Coupon Amt. For Printing")
                {
                }
                fieldelement(ReplicationCounter; "Transaction Order Entry"."Replication Counter")
                {
                }
                fieldelement(SalesType; "Transaction Order Entry"."Sales Type")
                {
                }
                fieldelement(OrigfromInfocode; "Transaction Order Entry"."Orig. from Infocode")
                {
                }
                fieldelement(OrigfromSubcode; "Transaction Order Entry"."Orig. from Subcode")
                {
                }
                fieldelement(ParentLineNo; "Transaction Order Entry"."Parent Line No.")
                {
                }
                fieldelement(InfocodeEntryLineNo; "Transaction Order Entry"."Infocode Entry Line No.")
                {
                }
                fieldelement(ExcludedBOMLineNo; "Transaction Order Entry"."Excluded BOM Line No.")
                {
                }
                fieldelement(InfocodeSelectedQty; "Transaction Order Entry"."Infocode Selected Qty.")
                {
                }
                fieldelement(ParentItemNo; "Transaction Order Entry"."Parent Item No.")
                {
                }
                fieldelement(OrigTransStore; "Transaction Order Entry"."Orig. Trans. Store")
                {
                }
                fieldelement(OrigTransPos; "Transaction Order Entry"."Orig. Trans. Pos")
                {
                }
                fieldelement(OrigTransNo; "Transaction Order Entry"."Orig. Trans. No.")
                {
                }
                fieldelement(OrigTransLineNo; "Transaction Order Entry"."Orig. Trans. Line No.")
                {
                }
                fieldelement(RefundQty; "Transaction Order Entry"."Refund Qty.")
                {
                }
                fieldelement(RefundedLineNo; "Transaction Order Entry"."Refunded Line No.")
                {
                }
                fieldelement(RefundedTransNo; "Transaction Order Entry"."Refunded Trans. No.")
                {
                }
                fieldelement(RefundedPOSNo; "Transaction Order Entry"."Refunded POS No.")
                {
                }
                fieldelement(RefundedStoreNo; "Transaction Order Entry"."Refunded Store No.")
                {
                }
                fieldelement(RetailSpecialOrder; "Transaction Order Entry"."Retail Special Order")
                {
                }
                fieldelement(DeliveringMethod; "Transaction Order Entry"."Delivering Method")
                {
                }
                fieldelement(VendorDeliversto; "Transaction Order Entry"."Vendor Delivers to")
                {
                }
                fieldelement(Sourcing; "Transaction Order Entry".Sourcing)
                {
                }
                fieldelement(Deliverfrom; "Transaction Order Entry"."Deliver from")
                {
                }
                fieldelement(DeliveryLocationCode; "Transaction Order Entry"."Delivery Location Code")
                {
                }
                fieldelement(SPOPrepayment; "Transaction Order Entry"."SPO Prepayment %")
                {
                }
                fieldelement("Payment-Actual"; "Transaction Order Entry"."Payment-Actual")
                {
                }
                fieldelement(WhseProcess; "Transaction Order Entry"."Whse Process")
                {
                }
                fieldelement(Status; "Transaction Order Entry".Status)
                {
                }
                fieldelement(DeliveryStatus; "Transaction Order Entry"."Delivery Status")
                {
                }
                fieldelement(ConfigurationID; "Transaction Order Entry"."Configuration ID")
                {
                }
                fieldelement(MandatoryOptionsExist; "Transaction Order Entry"."Mandatory Options Exist")
                {
                }
                fieldelement(AddChargeOption; "Transaction Order Entry"."Add.Charge Option")
                {
                }
                fieldelement(DeliveryReferenceNo; "Transaction Order Entry"."Delivery Reference No")
                {
                }
                fieldelement(DeliveryUserID; "Transaction Order Entry"."Delivery User ID")
                {
                }
                fieldelement(DeliveryDateTime; "Transaction Order Entry"."Delivery Date Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(OptionValueText; "Transaction Order Entry"."Option Value Text")
                {
                }
                fieldelement(EstimatedDeliveryDate; "Transaction Order Entry"."Estimated Delivery Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NolaterthanDate; "Transaction Order Entry"."No later than Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement("Payment-AtOrderEntry-Limit"; "Transaction Order Entry"."Payment-At Order Entry-Limit")
                {
                }
                fieldelement("Payment-AtDelivery-Limit"; "Transaction Order Entry"."Payment-At Delivery-Limit")
                {
                }
                fieldelement(ReturnPolicy; "Transaction Order Entry"."Return Policy")
                {
                }
                fieldelement(NonRefundAmount; "Transaction Order Entry"."Non Refund Amount")
                {
                }
                fieldelement(SourcingStatus; "Transaction Order Entry"."Sourcing Status")
                {
                }
                fieldelement("Payment-AtPurchaseOrder-Limit"; "Transaction Order Entry"."Payment-At PurchaseOrder-Limit")
                {
                }
                fieldelement(SPODocumentMethod; "Transaction Order Entry"."SPO Document Method")
                {
                }
                fieldelement(StoreSalesLocation; "Transaction Order Entry"."Store Sales Location")
                {
                }
                fieldelement(SPOWhseLocation; "Transaction Order Entry"."SPO Whse Location")
                {
                }
                fieldelement(VendorNo; "Transaction Order Entry"."Vendor No.")
                {
                }
                fieldelement(AdditionalChargeCode; "Transaction Order Entry"."Additional Charge Code")
                {
                }
                fieldelement(PaymentProfileCode; "Transaction Order Entry"."Payment Profile Code")
                {
                }
                fieldelement(DeliverNow; "Transaction Order Entry"."Deliver Now")
                {
                }
                fieldelement(CancelPermitted; "Transaction Order Entry"."Cancel Permitted")
                {
                }
                fieldelement(CancelNow; "Transaction Order Entry"."Cancel Now")
                {
                }
                fieldelement(AddChrglinkedtoline; "Transaction Order Entry"."Add.Chrg linked to line")
                {
                }
                fieldelement(QtytoHandle; "Transaction Order Entry"."Qty. to Handle")
                {
                }
                fieldelement(PreCancelSourcingStatus; "Transaction Order Entry"."Pre Cancel Sourcing Status")
                {
                }
                fieldelement(PostAvilableQty; "Transaction Order Entry"."Post Avilable Qty.")
                {
                }
                fieldelement(PostDeliveredQty; "Transaction Order Entry"."Post Delivered Qty.")
                {
                }
                fieldelement(TaxGroupCode; "Transaction Order Entry"."Tax Group Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxCalculationType; "Transaction Order Entry"."VAT Calculation Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(SalesTaxRounding; "Transaction Order Entry"."Sales Tax Rounding")
                {
                    MinOccurs = Zero;
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
            tableelement("Trans. Disc. Benefit Entry"; "LSC Trans. Disc. Benefit Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransDiscBenefitEntry';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Disc. Benefit Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Disc. Benefit Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Disc. Benefit Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Disc. Benefit Entry"."Line No.")
                {
                }
                fieldelement(OfferType; "Trans. Disc. Benefit Entry"."Offer Type")
                {
                }
                fieldelement(OfferNo; "Trans. Disc. Benefit Entry"."Offer No.")
                {
                }
                fieldelement(OfferLineNo; "Trans. Disc. Benefit Entry"."Offer Line No.")
                {
                }
                fieldelement(Type; "Trans. Disc. Benefit Entry".Type)
                {
                }
                fieldelement(No; "Trans. Disc. Benefit Entry"."No.")
                {
                }
                fieldelement(VariantCode; "Trans. Disc. Benefit Entry"."Variant Code")
                {
                }
                fieldelement(Description; "Trans. Disc. Benefit Entry".Description)
                {
                }
                fieldelement(ValueType; "Trans. Disc. Benefit Entry"."Value Type")
                {
                }
                fieldelement(Value; "Trans. Disc. Benefit Entry".Value)
                {
                }
                fieldelement(Quantity; "Trans. Disc. Benefit Entry".Quantity)
                {
                }
                fieldelement(ReplicationCounter; "Trans. Disc. Benefit Entry"."Replication Counter")
                {
                }
            }
            tableelement("Transaction Order Discount"; "LSC Transaction Order Discount")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionOrderDiscount';
                UseTemporary = true;
                fieldelement(TransactionNo; "Transaction Order Discount"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Transaction Order Discount"."Line No.")
                {
                }
                fieldelement(ReceiptNo; "Transaction Order Discount"."Receipt No.")
                {
                }
                fieldelement(StoreNo; "Transaction Order Discount"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Transaction Order Discount"."POS Terminal No.")
                {
                }
                fieldelement(MemberAttribute; "Transaction Order Discount"."Member Attribute")
                {
                }
                fieldelement(MemberAttributeValue; "Transaction Order Discount"."Member Attribute Value")
                {
                }
                fieldelement(TrackingNo; "Transaction Order Discount"."Tracking No.")
                {
                }
                fieldelement(OfferType; "Transaction Order Discount"."Offer Type")
                {
                }
                fieldelement(OfferNo; "Transaction Order Discount"."Offer No.")
                {
                }
                fieldelement(DiscountAmount; "Transaction Order Discount"."Discount Amount")
                {
                }
                fieldelement(Points; "Transaction Order Discount".Points)
                {
                }
                fieldelement(SequenceCode; "Transaction Order Discount"."Sequence Code")
                {
                }
                fieldelement(SequenceFunction; "Transaction Order Discount"."Sequence Function")
                {
                }
                fieldelement(ReplicationCounter; "Transaction Order Discount"."Replication Counter")
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
            tableelement("Trans. Inv. Adjmt. Entry"; "LSC Trans. Inv. Adjmt. Entry")
            {
                MinOccurs = Zero;
                XmlName = 'TransInvAdjmtEntry';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Inv. Adjmt. Entry"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Inv. Adjmt. Entry"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Inv. Adjmt. Entry"."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Inv. Adjmt. Entry"."Line No.")
                {
                }
                fieldelement(LocationCode; "Trans. Inv. Adjmt. Entry"."Location Code")
                {
                }
                fieldelement(ItemNo; "Trans. Inv. Adjmt. Entry"."Item No.")
                {
                }
                fieldelement(VariantCode; "Trans. Inv. Adjmt. Entry"."Variant Code")
                {
                }
                fieldelement(Quantity; "Trans. Inv. Adjmt. Entry".Quantity)
                {
                }
                fieldelement(Date; "Trans. Inv. Adjmt. Entry".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ReplicationCounter; "Trans. Inv. Adjmt. Entry"."Replication Counter")
                {
                }
            }
            tableelement("Trans. Inv. Adjmt. Entry St."; "LSC Trans. Inv Adjmt. Entry St")
            {
                MinOccurs = Zero;
                XmlName = 'TransInvAdjmtEntrySt';
                UseTemporary = true;
                fieldelement(StoreNo; "Trans. Inv. Adjmt. Entry St."."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Trans. Inv. Adjmt. Entry St."."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Trans. Inv. Adjmt. Entry St."."Transaction No.")
                {
                }
                fieldelement(LineNo; "Trans. Inv. Adjmt. Entry St."."Line No.")
                {
                }
                fieldelement(LocationCode; "Trans. Inv. Adjmt. Entry St."."Location Code")
                {
                }
                fieldelement(Status; "Trans. Inv. Adjmt. Entry St.".Status)
                {
                }
                fieldelement(ItemNo; "Trans. Inv. Adjmt. Entry St."."Item No.")
                {
                }
                fieldelement(VariantCode; "Trans. Inv. Adjmt. Entry St."."Variant Code")
                {
                }
                fieldelement(Quantity; "Trans. Inv. Adjmt. Entry St.".Quantity)
                {
                }
                fieldelement(Date; "Trans. Inv. Adjmt. Entry St.".Date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ReplicationCounter; "Trans. Inv. Adjmt. Entry St."."Replication Counter")
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
            tableelement("Transaction Signature"; "LSC Transaction Signature")
            {
                MinOccurs = Zero;
                XmlName = 'TransactionSignature';
                UseTemporary = true;
                fieldelement(StoreNo; "Transaction Signature"."Store No.")
                {
                }
                fieldelement(POSTerminalNo; "Transaction Signature"."POS Terminal No.")
                {
                }
                fieldelement(TransactionNo; "Transaction Signature"."Transaction No.")
                {
                }
                fieldelement(TransactionType; "Transaction Signature"."Transaction Type")
                {
                }
                fieldelement(ReceiptNo; "Transaction Signature"."Receipt No.")
                {
                }
                fieldelement(TransDate; "Transaction Signature"."Trans. Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TransTime; "Transaction Signature"."Trans. Time")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CreditSale; "Transaction Signature"."Credit Sale")
                {
                }
                fieldelement(CreditNo; "Transaction Signature"."Credit No.")
                {
                }
                fieldelement(Training; "Transaction Signature".Training)
                {
                }
                fieldelement(TrainingNo; "Transaction Signature"."Training No.")
                {
                }
                fieldelement(NetAmount; "Transaction Signature"."Net Amount")
                {
                }
                fieldelement(Amount; "Transaction Signature".Amount)
                {
                }
                fieldelement(PrivateKeyVersion; "Transaction Signature"."Private Key Version")
                {
                }
                fieldelement(Signature; "Transaction Signature".Signature)
                {
                }
                fieldelement(ReplicationCounter; "Transaction Signature"."Replication Counter")
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
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Sales Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Payment Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Income/Expense Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Coupon Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Infocode Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Tender Declar. Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Inventory Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Mix & Match Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Cash Declaration");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Safe Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("POS Card Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("POS Voided Trans. Line");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Transaction Status");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Sales Entry Status");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Transaction Order Header");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Transaction Order Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Discount Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Disc. Benefit Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Point Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Transaction Order Discount");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Deal Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Hospitality Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Inv. Adjmt. Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. Inv. Adjmt. Entry St.");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Transaction Signature");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("Trans. SalesTax Entry");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);
    end;

    procedure GetTransactionTables(var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE("Transaction Header");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Sales Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Payment Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Income/Expense Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Coupon Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Infocode Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Tender Declar. Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Inventory Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Mix & Match Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Cash Declaration");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Safe Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("POS Card Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("POS Voided Trans. Line");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Transaction Status");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Sales Entry Status");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Transaction Order Header");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Transaction Order Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Discount Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Disc. Benefit Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Point Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Transaction Order Discount");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Deal Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Hospitality Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Inv. Adjmt. Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. Inv. Adjmt. Entry St.");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Transaction Signature");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("Trans. SalesTax Entry");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);
    end;
}

