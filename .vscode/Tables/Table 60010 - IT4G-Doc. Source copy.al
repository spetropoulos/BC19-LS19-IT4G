table 60010 "IT4G-Doc. Source"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "IT4G-Doc. Header"."Document No.";
        }
        field(2; CustomerLoginId; Integer)
        {
        }
        field(3; CustomerLoginEmail; Text[100])
        {
        }
        field(4; CustomerComments1; Text[250])
        {
        }
        field(5; CustomerComments2; Text[250])
        {
        }
        field(200; ShippingFirstName; Text[100])
        {
        }
        field(201; ShippingLastName; Text[100])
        {
        }
        field(202; ShippingAddressLine1; Text[100])
        {
        }
        field(203; ShippingAddressLine2; Text[100])
        {
        }
        field(204; ShippingArea; Text[100])
        {
        }
        field(205; ShippingCity; Text[100])
        {
        }
        field(206; ShippingPostalCode; Text[50])
        {
        }
        field(207; ShippingCoutryCode; Text[2])
        {
        }
        field(208; ShippingPhones; Text[50])
        {
        }
        field(209; ShippingMobiles; Text[50])
        {
        }
        field(210; ShippingEmail; Text[50])
        {
        }
        field(500; BillingIsInvoice; Boolean)
        {
        }
        field(501; BillingCompanyName; Text[100])
        {
        }
        field(502; BillingOccupation; Text[50])
        {
        }
        field(503; BillingTaxIdentifier; Text[50])
        {
        }
        field(504; BillingTaxAgency; Text[50])
        {
        }
        field(600; BillingFirstName; Text[100])
        {
        }
        field(601; BillingLastName; Text[100])
        {
        }
        field(602; BillingAddressLine1; Text[100])
        {
        }
        field(603; BillingAddressLine2; Text[100])
        {
        }
        field(604; BillingPostalCode; Text[50])
        {
        }
        field(606; BillingPhones; Text[50])
        {
        }
        field(607; BillingMobiles; Text[50])
        {
        }
        field(608; BillingEmail; Text[50])
        {
        }

        field(1001; SAPDeliveryNumberId; Code[20])
        {
        }
        field(1002; PaymentMethodId; Integer)
        {
        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

