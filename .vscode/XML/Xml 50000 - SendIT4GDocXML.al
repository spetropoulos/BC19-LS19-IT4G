xmlport 50000 SendIT4GDocXML
{
    Caption = 'SendIT4GDocXML';
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;
    schema
    {
        textelement(RootSendIT4GDocXML)
        {
            tableelement("IT4G-Doc. Header"; "IT4G-Doc. Header")
            {
                MinOccurs = Zero;
                XmlName = 'IT4GDocHeader';
                UseTemporary = true;
                fieldelement(CalcNumberofItems; "IT4G-Doc. Header"."Calc. Number of Items")
                {
                }
                fieldelement(CalcNumberofLines; "IT4G-Doc. Header"."Calc. Number of Lines")
                {
                }
                fieldelement(CreatedbyDocumentNo; "IT4G-Doc. Header"."Created by Document No.")
                {
                }
                fieldelement(CreatedbyPOSTerminalNo; "IT4G-Doc. Header"."Created by POS Terminal No.")
                {
                }
                fieldelement(CreatedbyStoreNo; "IT4G-Doc. Header"."Created by Store No.")
                {
                }
                fieldelement(CreatedbySystem; "IT4G-Doc. Header"."Created by System")
                {
                }
                fieldelement(CreatedbyTransactionNo; "IT4G-Doc. Header"."Created by Transaction No.")
                {
                }
                fieldelement(DestinationStore; "IT4G-Doc. Header"."Destination Store")
                {
                }
                fieldelement(DocumentNo; "IT4G-Doc. Header"."Document No.")
                {
                }
                fieldelement(DocumentType; "IT4G-Doc. Header"."Document Type")
                {
                }
                fieldelement(ExternalDocumentDate; "IT4G-Doc. Header"."External Document Date")
                {
                }
                fieldelement(ExternalDocumentNo; "IT4G-Doc. Header"."External Document No.")
                {
                }
                fieldelement(FromLocation; "IT4G-Doc. Header"."From Location")
                {
                }
                fieldelement(FromStore; "IT4G-Doc. Header"."From Store")
                {
                }
                fieldelement(NumberofItems; "IT4G-Doc. Header"."Number of Items")
                {
                }
                fieldelement(NumberofLines; "IT4G-Doc. Header"."Number of Lines")
                {
                }
                fieldelement(RelatedDocumentNo; "IT4G-Doc. Header"."Related Document No.")
                {
                }
                fieldelement(SourceNo; "IT4G-Doc. Header"."Source No.")
                {
                }
                fieldelement(SourceType; "IT4G-Doc. Header"."Source Type")
                {
                }
                fieldelement(ToLocation; "IT4G-Doc. Header"."To Location")
                {
                }
                fieldelement(ToStore; "IT4G-Doc. Header"."To Store")
                {
                }
                fieldelement(Date; "IT4G-Doc. Header".Date)
                {
                }
                fieldelement(CreatedOn; "IT4G-Doc. Header"."Created On")
                {
                }
                fieldelement(CreatedbyUser; "IT4G-Doc. Header"."Created by User")
                {
                }
                fieldelement(CreatedonHost; "IT4G-Doc. Header"."Created on Host")
                {
                }
                fieldelement(CreatedbyStaff; "IT4G-Doc. Header"."Created by Staff")
                {
                }
            }
            tableelement("IT4G-Doc. Line"; "IT4G-Doc. Line")
            {
                MinOccurs = Zero;
                XmlName = 'IT4GDocLine';
                UseTemporary = true;
                fieldelement(BaseUnitofMeasure; "IT4G-Doc. Line"."Base Unit of Measure")
                {
                }
                fieldelement(DocumentNo; "IT4G-Doc. Line"."Document No.")
                {
                }
                fieldelement(LineNo; "IT4G-Doc. Line"."Line No.")
                {
                }
                fieldelement(LineType; "IT4G-Doc. Line"."Line Type")
                {
                }
                fieldelement(Number; "IT4G-Doc. Line".Number)
                {
                }
                fieldelement(Quantity; "IT4G-Doc. Line".Quantity)
                {
                }
                fieldelement(QuantityBase; "IT4G-Doc. Line"."Quantity Base")
                {
                }
                fieldelement(UnitofMeasure; "IT4G-Doc. Line"."Unit of Measure")
                {
                }
                fieldelement(VariantCode; "IT4G-Doc. Line"."Variant Code")
                {
                }
                fieldelement(Amount; "IT4G-Doc. Line".Amount)
                {
                }
            }
            tableelement("IT4G-Doc. Line Box"; "IT4G-Doc. Line Box")
            {
                MinOccurs = Zero;
                XmlName = 'IT4GDocLineBox';
                UseTemporary = true;
                fieldelement(BarcodeNo; "IT4G-Doc. Line Box"."Barcode No.")
                {
                }
                fieldelement(BaseUnitofMeasure; "IT4G-Doc. Line Box"."Base Unit of Measure")
                {
                }
                fieldelement(BoxNo; "IT4G-Doc. Line Box"."Box No.")
                {
                }
                fieldelement(DocumentLineNo; "IT4G-Doc. Line Box"."Document Line No.")
                {
                }
                fieldelement(DocumentNo; "IT4G-Doc. Line Box"."Document No.")
                {
                }
                fieldelement(ItemNo; "IT4G-Doc. Line Box"."Item No.")
                {
                }
                fieldelement(Quantity; "IT4G-Doc. Line Box".Quantity)
                {
                }
                fieldelement(QuantityBase; "IT4G-Doc. Line Box"."Quantity Base")
                {
                }
                fieldelement(UnitofMeasure; "IT4G-Doc. Line Box"."Unit of Measure")
                {
                }
                fieldelement(VariantCode; "IT4G-Doc. Line Box"."Variant Code")
                {
                }
            }
            tableelement("IT4G-Doc. Scan"; "IT4G-Doc. Scan")
            {
                MinOccurs = Zero;
                XmlName = 'IT4GDocScan';
                UseTemporary = true;
                fieldelement(BaseUnitofMeasure; "IT4G-Doc. Scan"."Base Unit of Measure")
                {
                }
                fieldelement(BoxNo; "IT4G-Doc. Scan"."Box No.")
                {
                }
                fieldelement(DocumentNo; "IT4G-Doc. Scan"."Document No.")
                {
                }
                fieldelement(ScanIdentifier; "IT4G-Doc. Scan"."Scan Identifier")
                {
                }
                fieldelement(ScannedQuantity; "IT4G-Doc. Scan"."Scanned Quantity")
                {
                }
                fieldelement(ScannedQuantityBase; "IT4G-Doc. Scan"."Scanned Quantity Base")
                {
                }
                fieldelement(UnitofMeasure; "IT4G-Doc. Scan"."Unit of Measure")
                {
                }
            }
            tableelement("IT4G-Doc. Source"; "IT4G-Doc. Source")
            {
                MinOccurs = Zero;
                XmlName = 'IT4GDocSource';
                UseTemporary = true;
                fieldelement(BillingAddressLine1; "IT4G-Doc. Source".BillingAddressLine1)
                {
                }
                fieldelement(BillingAddressLine2; "IT4G-Doc. Source".BillingAddressLine2)
                {
                }
                fieldelement(BillingCompanyName; "IT4G-Doc. Source".BillingCompanyName)
                {
                }
                fieldelement(BillingEmail; "IT4G-Doc. Source".BillingEmail)
                {
                }
                fieldelement(BillingFirstName; "IT4G-Doc. Source".BillingFirstName)
                {
                }
                fieldelement(BillingIsInvoice; "IT4G-Doc. Source".BillingIsInvoice)
                {
                }
                fieldelement(BillingLastName; "IT4G-Doc. Source".BillingLastName)
                {
                }
                fieldelement(BillingMobiles; "IT4G-Doc. Source".BillingMobiles)
                {
                }
                fieldelement(BillingOccupation; "IT4G-Doc. Source".BillingOccupation)
                {
                }
                fieldelement(BillingPhones; "IT4G-Doc. Source".BillingPhones)
                {
                }
                fieldelement(BillingPostalCode; "IT4G-Doc. Source".BillingPostalCode)
                {
                }
                fieldelement(BillingTaxAgency; "IT4G-Doc. Source".BillingTaxAgency)
                {
                }
                fieldelement(BillingTaxIdentifier; "IT4G-Doc. Source".BillingTaxIdentifier)
                {
                }
                fieldelement(CustomerComments1; "IT4G-Doc. Source".CustomerComments1)
                {
                }
                fieldelement(CustomerComments2; "IT4G-Doc. Source".CustomerComments2)
                {
                }
                fieldelement(CustomerLoginEmail; "IT4G-Doc. Source".CustomerLoginEmail)
                {
                }
                fieldelement(CustomerLoginId; "IT4G-Doc. Source".CustomerLoginId)
                {
                }
                fieldelement(DocumentNo; "IT4G-Doc. Source"."Document No.")
                {
                }
                fieldelement(PaymentMethodId; "IT4G-Doc. Source".PaymentMethodId)
                {
                }
                fieldelement(SAPDeliveryNumberId; "IT4G-Doc. Source".SAPDeliveryNumberId)
                {
                }
                fieldelement(ShippingAddressLine1; "IT4G-Doc. Source".ShippingAddressLine1)
                {
                }
                fieldelement(ShippingAddressLine2; "IT4G-Doc. Source".ShippingAddressLine2)
                {
                }
                fieldelement(ShippingArea; "IT4G-Doc. Source".ShippingArea)
                {
                }
                fieldelement(ShippingCity; "IT4G-Doc. Source".ShippingCity)
                {
                }
                fieldelement(ShippingCoutryCode; "IT4G-Doc. Source".ShippingCoutryCode)
                {
                }
                fieldelement(ShippingEmail; "IT4G-Doc. Source".ShippingEmail)
                {
                }
                fieldelement(ShippingFirstName; "IT4G-Doc. Source".ShippingFirstName)
                {
                }
                fieldelement(ShippingLastName; "IT4G-Doc. Source".ShippingLastName)
                {
                }
                fieldelement(ShippingMobiles; "IT4G-Doc. Source".ShippingMobiles)
                {
                }
                fieldelement(ShippingPhones; "IT4G-Doc. Source".ShippingPhones)
                {
                }
                fieldelement(ShippingPostalCode; "IT4G-Doc. Source".ShippingPostalCode)
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

    procedure SetIT4GDocTables(var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE("IT4G-Doc. Header");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("IT4G-Doc. Line");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("IT4G-Doc. Line Box");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("IT4G-Doc. Scan");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

        RecRef.GETTABLE("IT4G-Doc. Source");
        WebRequestFunctions.GetTableData(BufferUtility, RecRef);

    end;

    procedure GetIT4GDocTables(var BufferUtility: Codeunit "LSC Buffer Utility")
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE("IT4G-Doc. Header");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("IT4G-Doc. Line");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("IT4G-Doc. Line Box");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("IT4G-Doc. Scan");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

        RecRef.GETTABLE("IT4G-Doc. Source");
        WebRequestFunctions.LoadTableDataXML(RecRef, BufferUtility);

    end;

}
