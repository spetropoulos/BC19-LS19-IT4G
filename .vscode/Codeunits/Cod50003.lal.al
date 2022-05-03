codeunit 50003 "lala"
{
    var
        jTxt: Text;
        cC: Codeunit "IT4G-Functions";
        jObj: jSonObject;
        jToken: jSonToken;

    trigger OnRun()
    begin
        GenerateJson();
        cC.ExportFile(jTXT, 'c:\kouvas\lala.json', 'json');
    end;

    Procedure GenerateJson(): Text
    begin
        jTXT += '{';
        jTXT += '  "publicSalt": "",';
        jTXT += '  "publicSignature": "",';
        jTXT += '  "privateSignature": "",';
        jTXT += '  "mark": 0,';
        jTXT += '  "uid": "",';
        jTXT += '  "iaprSignPolicy": "",';
        jTXT += '  "uniqueId": "",';
        jTXT += '  "cancellationMark": 0,';
        jTXT += '  "classificationMark": 0,';
        jTXT += '  "version": "",';
        jTXT += '  "authenticationCode": "",';
        jTXT += '  "languageCode": "",';
        jTXT += '  "currency": "",';
        jTXT += '  "currencyCode": "",';
        jTXT += '  "invoiceType": "",';
        jTXT += '  "invoiceTypeCode": "",';
        jTXT += '  "documentType": "",';
        jTXT += '  "documentTypeCode": "",';
        jTXT += '  "copyTypeNamePurpose": "",';
        jTXT += '  "series": "",';
        jTXT += '  "number": "",';
        jTXT += '  "issuerFormatedInvoiceSeriesNumber": "",';
        jTXT += '  "dateIssued": "",';
        jTXT += '  "relativeDocuments": ';
        jTXT += '  [""';

        jTXT += '  ],';
        jTXT += '  "correlatedInvoices": ';
        jTXT += '  [0';

        jTXT += '  ],';
        jTXT += '  "recipientRole": "",';
        jTXT += '  "referenceCode": "",';
        jTXT += '  "orderCode": "",';
        jTXT += '  "lotNumber": "",';
        jTXT += '  "vatCurrencyCode": "",';
        jTXT += '  "vatPointDate": "",';
        jTXT += '  "orderConfirmationNumber": "",';
        jTXT += '  "receivingAdviceNumber": "",';
        jTXT += '  "dispatchAdvice": "",';
        jTXT += '  "issuer": ';
        jTXT += '  {';
        jTXT += '    "registeredName": "",';
        jTXT += '    "brandName": "",';
        jTXT += '    "contactPerson": "",';
        jTXT += '    "registrationNumber": "",';
        jTXT += '    "envelopeNumber": "",';
        jTXT += '    "ysn": "",';
        jTXT += '    "vat": "",';
        jTXT += '    "paidUpSharedCapital": 0,';
        jTXT += '    "sharedCapitalSubscribed": 0,';
        jTXT += '    "taxOffice": "",';
        jTXT += '    "taxOfficeCode": "",';
        jTXT += '    "activities": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "generalCommercialRegistryNumber": "",';
        jTXT += '    "phones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "faxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "emails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "url": "",';
        jTXT += '    "address": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branch": "",';
        jTXT += '    "branchCode": 0,';
        jTXT += '    "branchId": "",';
        jTXT += '    "posId": "",';
        jTXT += '    "branchAddress": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branchPhones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "branchFaxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "taxRegime": "",';
        jTXT += '    "category": "",';
        jTXT += '    "type": "",';
        jTXT += '    "code": "",';
        jTXT += '    "externalCode": "",';
        jTXT += '    "otherInfo": "",';
        jTXT += '    "identityType": "",';
        jTXT += '    "identityIdentifier": "",';
        jTXT += '    "taxRepresentativeName": "",';
        jTXT += '    "taxRepresentativeVat": "",';
        jTXT += '    "taxRepresentativeCountry": "",';
        jTXT += '    "taxRepresentativeCountryCode": "",';
        jTXT += '    "vatExemptionNote": "",';
        jTXT += '    "fuelDistributorCode": ""';

        jTXT += '  },';
        jTXT += '  "counterParty": ';
        jTXT += '  {';
        jTXT += '    "registeredName": "",';
        jTXT += '    "brandName": "",';
        jTXT += '    "contactPerson": "",';
        jTXT += '    "registrationNumber": "",';
        jTXT += '    "envelopeNumber": "",';
        jTXT += '    "ysn": "",';
        jTXT += '    "vat": "",';
        jTXT += '    "paidUpSharedCapital": 0,';
        jTXT += '    "sharedCapitalSubscribed": 0,';
        jTXT += '    "taxOffice": "",';
        jTXT += '    "taxOfficeCode": "",';
        jTXT += '    "activities": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "generalCommercialRegistryNumber": "",';
        jTXT += '    "phones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "faxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "emails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "url": "",';
        jTXT += '    "address": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branch": "",';
        jTXT += '    "branchCode": 0,';
        jTXT += '    "branchId": "",';
        jTXT += '    "posId": "",';
        jTXT += '    "branchAddress": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branchPhones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "branchFaxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "taxRegime": "",';
        jTXT += '    "category": "",';
        jTXT += '    "type": "",';
        jTXT += '    "code": "",';
        jTXT += '    "externalCode": "",';
        jTXT += '    "otherInfo": "",';
        jTXT += '    "identityType": "",';
        jTXT += '    "identityIdentifier": "",';
        jTXT += '    "taxRepresentativeName": "",';
        jTXT += '    "taxRepresentativeVat": "",';
        jTXT += '    "taxRepresentativeCountry": "",';
        jTXT += '    "taxRepresentativeCountryCode": "",';
        jTXT += '    "vatExemptionNote": "",';
        jTXT += '    "fuelDistributorCode": ""';

        jTXT += '  },';
        jTXT += '  "recipient": ';
        jTXT += '  {';
        jTXT += '    "registeredName": "",';
        jTXT += '    "brandName": "",';
        jTXT += '    "contactPerson": "",';
        jTXT += '    "registrationNumber": "",';
        jTXT += '    "envelopeNumber": "",';
        jTXT += '    "ysn": "",';
        jTXT += '    "vat": "",';
        jTXT += '    "paidUpSharedCapital": 0,';
        jTXT += '    "sharedCapitalSubscribed": 0,';
        jTXT += '    "taxOffice": "",';
        jTXT += '    "taxOfficeCode": "",';
        jTXT += '    "activities": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "generalCommercialRegistryNumber": "",';
        jTXT += '    "phones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "faxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "emails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "url": "",';
        jTXT += '    "address": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branch": "",';
        jTXT += '    "branchCode": 0,';
        jTXT += '    "branchId": "",';
        jTXT += '    "posId": "",';
        jTXT += '    "branchAddress": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branchPhones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "branchFaxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "taxRegime": "",';
        jTXT += '    "category": "",';
        jTXT += '    "type": "",';
        jTXT += '    "code": "",';
        jTXT += '    "externalCode": "",';
        jTXT += '    "otherInfo": "",';
        jTXT += '    "identityType": "",';
        jTXT += '    "identityIdentifier": "",';
        jTXT += '    "taxRepresentativeName": "",';
        jTXT += '    "taxRepresentativeVat": "",';
        jTXT += '    "taxRepresentativeCountry": "",';
        jTXT += '    "taxRepresentativeCountryCode": "",';
        jTXT += '    "vatExemptionNote": "",';
        jTXT += '    "fuelDistributorCode": ""';

        jTXT += '  },';
        jTXT += '  "billingContractor": ';
        jTXT += '  {';
        jTXT += '    "registeredName": "",';
        jTXT += '    "brandName": "",';
        jTXT += '    "contactPerson": "",';
        jTXT += '    "registrationNumber": "",';
        jTXT += '    "envelopeNumber": "",';
        jTXT += '    "ysn": "",';
        jTXT += '    "vat": "",';
        jTXT += '    "paidUpSharedCapital": 0,';
        jTXT += '    "sharedCapitalSubscribed": 0,';
        jTXT += '    "taxOffice": "",';
        jTXT += '    "taxOfficeCode": "",';
        jTXT += '    "activities": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "generalCommercialRegistryNumber": "",';
        jTXT += '    "phones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "faxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "emails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "url": "",';
        jTXT += '    "address": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branch": "",';
        jTXT += '    "branchCode": 0,';
        jTXT += '    "branchId": "",';
        jTXT += '    "posId": "",';
        jTXT += '    "branchAddress": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branchPhones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "branchFaxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "taxRegime": "",';
        jTXT += '    "category": "",';
        jTXT += '    "type": "",';
        jTXT += '    "code": "",';
        jTXT += '    "externalCode": "",';
        jTXT += '    "otherInfo": "",';
        jTXT += '    "identityType": "",';
        jTXT += '    "identityIdentifier": "",';
        jTXT += '    "taxRepresentativeName": "",';
        jTXT += '    "taxRepresentativeVat": "",';
        jTXT += '    "taxRepresentativeCountry": "",';
        jTXT += '    "taxRepresentativeCountryCode": "",';
        jTXT += '    "vatExemptionNote": "",';
        jTXT += '    "fuelDistributorCode": ""';

        jTXT += '  },';
        jTXT += '  "originator": ';
        jTXT += '  {';
        jTXT += '    "registeredName": "",';
        jTXT += '    "brandName": "",';
        jTXT += '    "contactPerson": "",';
        jTXT += '    "registrationNumber": "",';
        jTXT += '    "envelopeNumber": "",';
        jTXT += '    "ysn": "",';
        jTXT += '    "vat": "",';
        jTXT += '    "paidUpSharedCapital": 0,';
        jTXT += '    "sharedCapitalSubscribed": 0,';
        jTXT += '    "taxOffice": "",';
        jTXT += '    "taxOfficeCode": "",';
        jTXT += '    "activities": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "generalCommercialRegistryNumber": "",';
        jTXT += '    "phones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "faxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "emails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "url": "",';
        jTXT += '    "address": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branch": "",';
        jTXT += '    "branchCode": 0,';
        jTXT += '    "branchId": "",';
        jTXT += '    "posId": "",';
        jTXT += '    "branchAddress": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branchPhones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "branchFaxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "taxRegime": "",';
        jTXT += '    "category": "",';
        jTXT += '    "type": "",';
        jTXT += '    "code": "",';
        jTXT += '    "externalCode": "",';
        jTXT += '    "otherInfo": "",';
        jTXT += '    "identityType": "",';
        jTXT += '    "identityIdentifier": "",';
        jTXT += '    "taxRepresentativeName": "",';
        jTXT += '    "taxRepresentativeVat": "",';
        jTXT += '    "taxRepresentativeCountry": "",';
        jTXT += '    "taxRepresentativeCountryCode": "",';
        jTXT += '    "vatExemptionNote": "",';
        jTXT += '    "fuelDistributorCode": ""';

        jTXT += '  },';
        jTXT += '  "sender": ';
        jTXT += '  {';
        jTXT += '    "registeredName": "",';
        jTXT += '    "brandName": "",';
        jTXT += '    "contactPerson": "",';
        jTXT += '    "registrationNumber": "",';
        jTXT += '    "envelopeNumber": "",';
        jTXT += '    "ysn": "",';
        jTXT += '    "vat": "",';
        jTXT += '    "paidUpSharedCapital": 0,';
        jTXT += '    "sharedCapitalSubscribed": 0,';
        jTXT += '    "taxOffice": "",';
        jTXT += '    "taxOfficeCode": "",';
        jTXT += '    "activities": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "generalCommercialRegistryNumber": "",';
        jTXT += '    "phones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "faxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "emails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "url": "",';
        jTXT += '    "address": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branch": "",';
        jTXT += '    "branchCode": 0,';
        jTXT += '    "branchId": "",';
        jTXT += '    "posId": "",';
        jTXT += '    "branchAddress": ';
        jTXT += '    {';
        jTXT += '      "country": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "municipality": "",';
        jTXT += '      "municipalityCode": "",';
        jTXT += '      "region": "",';
        jTXT += '      "regionCode": "",';
        jTXT += '      "city": "",';
        jTXT += '      "cityCode": "",';
        jTXT += '      "street": "",';
        jTXT += '      "number": "",';
        jTXT += '      "postal": "",';
        jTXT += '      "geographicalCoordinates": ';
        jTXT += '      {';
        jTXT += '        "item1": "",';
        jTXT += '        "item2": ""';

        jTXT += '      },';
        jTXT += '      "gln": ""';

        jTXT += '    },';
        jTXT += '    "branchPhones": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "branchFaxes": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "taxRegime": "",';
        jTXT += '    "category": "",';
        jTXT += '    "type": "",';
        jTXT += '    "code": "",';
        jTXT += '    "externalCode": "",';
        jTXT += '    "otherInfo": "",';
        jTXT += '    "identityType": "",';
        jTXT += '    "identityIdentifier": "",';
        jTXT += '    "taxRepresentativeName": "",';
        jTXT += '    "taxRepresentativeVat": "",';
        jTXT += '    "taxRepresentativeCountry": "",';
        jTXT += '    "taxRepresentativeCountryCode": "",';
        jTXT += '    "vatExemptionNote": "",';
        jTXT += '    "fuelDistributorCode": ""';

        jTXT += '  },';
        jTXT += '  "allowancesCharges": ';
        jTXT += '  [';
        jTXT += '    {';
        jTXT += '      "type": "",';
        jTXT += '      "description": "",';
        jTXT += '      "code": "",';
        jTXT += '      "level": 0,';
        jTXT += '      "percentage": 0,';
        jTXT += '      "amount": 0,';
        jTXT += '      "amountAC": 0,';
        jTXT += '      "grossAmount": 0,';
        jTXT += '      "grossAmountAC": 0,';
        jTXT += '      "underlyingValue": 0,';
        jTXT += '      "underlyingValueAC": 0,';
        jTXT += '      "vatPercentage": 0,';
        jTXT += '      "vatAmount": 0,';
        jTXT += '      "vatAmountAC": 0';

        jTXT += '    }';
        jTXT += '  ],';
        jTXT += '  "banks": ';
        jTXT += '  [';
        jTXT += '    {';
        jTXT += '      "bicCode": "",';
        jTXT += '      "name": "",';
        jTXT += '      "vatinid": "",';
        jTXT += '      "vat": "",';
        jTXT += '      "vatin": "",';
        jTXT += '      "branchCode": "",';
        jTXT += '      "branch": "",';
        jTXT += '      "account": "",';
        jTXT += '      "iban": "",';
        jTXT += '      "contactDetails": ""';

        jTXT += '    }';
        jTXT += '  ],';
        jTXT += '  "contractOrderDetails": ';
        jTXT += '  {';
        jTXT += '    "startDate": "",';
        jTXT += '    "endDate": "",';
        jTXT += '    "contractTypeCode": "",';
        jTXT += '    "name": "",';
        jTXT += '    "code": "",';
        jTXT += '    "date": "",';
        jTXT += '    "webPostNumber": "",';
        jTXT += '    "budgetRegistrationCode": "",';
        jTXT += '    "budgetCommitmentCode": "",';
        jTXT += '    "orderNumbers": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "misCode": "",';
        jTXT += '    "coFundingProjectCode": "",';
        jTXT += '    "coFundingProjectYear": "",';
        jTXT += '    "coFundingProjectDeedCode": ""';

        jTXT += '  },';
        jTXT += '  "distributionDetails": ';
        jTXT += '  {';
        jTXT += '    "internalDocumentId": "",';
        jTXT += '    "installationId": "",';
        jTXT += '    "shippingMethod": "",';
        jTXT += '    "shippingMethodCode": "",';
        jTXT += '    "movePurpose": "",';
        jTXT += '    "totalQuantity": 0,';
        jTXT += '    "movePurposeCode": 0,';
        jTXT += '    "dispatchDate": "",';
        jTXT += '    "dispatchTime": "",';
        jTXT += '    "vehileNumber": "",';
        jTXT += '    "delivery": "",';
        jTXT += '    "relativeDocuments": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "salesman": "",';
        jTXT += '    "billOfLading": "",';
        jTXT += '    "houseBill": "",';
        jTXT += '    "ldm": 0,';
        jTXT += '    "project": "",';
        jTXT += '    "deliveryDate": "",';
        jTXT += '    "freightVolume": 0,';
        jTXT += '    "billedFreightWeight": 0,';
        jTXT += '    "grossFreightWeight": 0,';
        jTXT += '    "content": "",';
        jTXT += '    "deliveryOriginDetails": ';
        jTXT += '    {';
        jTXT += '      "address": ';
        jTXT += '      {';
        jTXT += '        "country": "",';
        jTXT += '        "countryCode": "",';
        jTXT += '        "municipality": "",';
        jTXT += '        "municipalityCode": "",';
        jTXT += '        "region": "",';
        jTXT += '        "regionCode": "",';
        jTXT += '        "city": "",';
        jTXT += '        "cityCode": "",';
        jTXT += '        "street": "",';
        jTXT += '        "number": "",';
        jTXT += '        "postal": "",';
        jTXT += '        "geographicalCoordinates": ';
        jTXT += '        {';
        jTXT += '          "item1": "",';
        jTXT += '          "item2": ""';

        jTXT += '        },';
        jTXT += '        "gln": ""';

        jTXT += '      },';
        jTXT += '      "remarks": "",';
        jTXT += '      "phones": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "faxes": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "emails": ';
        jTXT += '      [""';

        jTXT += '      ]';
        jTXT += '    },';
        jTXT += '    "deliveryDestinationDetails": ';
        jTXT += '    {';
        jTXT += '      "address": ';
        jTXT += '      {';
        jTXT += '        "country": "",';
        jTXT += '        "countryCode": "",';
        jTXT += '        "municipality": "",';
        jTXT += '        "municipalityCode": "",';
        jTXT += '        "region": "",';
        jTXT += '        "regionCode": "",';
        jTXT += '        "city": "",';
        jTXT += '        "cityCode": "",';
        jTXT += '        "street": "",';
        jTXT += '        "number": "",';
        jTXT += '        "postal": "",';
        jTXT += '        "geographicalCoordinates": ';
        jTXT += '        {';
        jTXT += '          "item1": "",';
        jTXT += '          "item2": ""';

        jTXT += '        },';
        jTXT += '        "gln": ""';

        jTXT += '      },';
        jTXT += '      "remarks": "",';
        jTXT += '      "phones": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "faxes": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "emails": ';
        jTXT += '      [""';

        jTXT += '      ]';
        jTXT += '    }';
        jTXT += '  },';
        jTXT += '  "paymentDetails": ';
        jTXT += '  {';
        jTXT += '    "totalPieces": 0,';
        jTXT += '    "previousBalance": 0,';
        jTXT += '    "newBalance": 0,';
        jTXT += '    "prepaymentAmount": 0,';
        jTXT += '    "roundingAmount": 0,';
        jTXT += '    "electronicPaymentCode": "",';
        jTXT += '    "paymentMethods": ';
        jTXT += '    [';
        jTXT += '      {';
        jTXT += '        "paymentMethodId": "",';
        jTXT += '        "paymentMethodType": "",';
        jTXT += '        "paymentMethodTypeCode": 0,';
        jTXT += '        "amount": 0,';
        jTXT += '        "amountAC": 0,';
        jTXT += '        "remarks": ""';

        jTXT += '      }';
        jTXT += '    ],';
        jTXT += '    "paymentDate": "",';
        jTXT += '    "paymentReferenceID": "",';
        jTXT += '    "payingCompanyVATNumber": "",';
        jTXT += '    "otherPaymentDetails": "",';
        jTXT += '    "counterpartCurrency": "",';
        jTXT += '    "exchangeCurrencyRate": 0,';
        jTXT += '    "counterpartCurrencyRate": 0,';
        jTXT += '    "localCurrencyValue": 0,';
        jTXT += '    "counterpartCurrencyValue": 0,';
        jTXT += '    "exchangeCurrency": "",';
        jTXT += '    "counterpartNewBalance": 0,';
        jTXT += '    "expenses": 0,';
        jTXT += '    "localCurrencyExpenses": 0,';
        jTXT += '    "exchangeCurrencyExpenses": 0,';
        jTXT += '    "exchangeCurrencyValue": 0,';
        jTXT += '    "securityAmount": 0,';
        jTXT += '    "totalAmountDescription": "",';
        jTXT += '    "future1": "",';
        jTXT += '    "future2": "",';
        jTXT += '    "future3": 0,';
        jTXT += '    "future4": 0';

        jTXT += '  },';
        jTXT += '  "additionalDetails": ';
        jTXT += '  {';
        jTXT += '    "locationEmail": "",';
        jTXT += '    "approver": "",';
        jTXT += '    "approverEmails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "attention": "",';
        jTXT += '    "approvalLogicalOperator": "",';
        jTXT += '    "issuingOfficer": "",';
        jTXT += '    "principalFunctionality": "",';
        jTXT += '    "eInvoiceDocumentType": "",';
        jTXT += '    "notificationDelay": "",';
        jTXT += '    "generalPurposeTags": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "accountingDepartmentEmails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "readOnlyAccessEmails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "thirdPartyEmails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "aseds": "",';
        jTXT += '    "extraStructuredContent": "",';
        jTXT += '    "extraStructuredContentType": "",';
        jTXT += '    "transmissionMethod": "",';
        jTXT += '    "user": "",';
        jTXT += '    "documentTags": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "zipCodeForPostOffice": "",';
        jTXT += '    "sendAsPdf": false,';
        jTXT += '    "avoidEmailGrouping": false,';
        jTXT += '    "pdfNotificationEmails": ';
        jTXT += '    [""';

        jTXT += '    ],';
        jTXT += '    "documentTemplate": "",';
        jTXT += '    "qrCodePPM": 0,';
        jTXT += '    "callback": false,';
        jTXT += '    "approvalDocumentId": ""';

        jTXT += '  },';
        jTXT += '  "details": ';
        jTXT += '  [';
        jTXT += '    {';
        jTXT += '      "lineNo": 0,';
        jTXT += '      "classificationLineNo": 0,';
        jTXT += '      "date": "",';
        jTXT += '      "code": "",';
        jTXT += '      "buyerCode": "",';
        jTXT += '      "cpvCode": "",';
        jTXT += '      "itemCodification": "",';
        jTXT += '      "categoryId": "",';
        jTXT += '      "countryCode": "",';
        jTXT += '      "tariffCodeID": "",';
        jTXT += '      "orderID": "",';
        jTXT += '      "transportId": "",';
        jTXT += '      "lotLifeCircle": "",';
        jTXT += '      "deliveryId": "",';
        jTXT += '      "descriptions": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "specialFeatures": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "startingDate": "",';
        jTXT += '      "expirationDate": "",';
        jTXT += '      "measurementUnit": "",';
        jTXT += '      "measurementUnitCode": 0,';
        jTXT += '      "measurementUnitCodeEN": "",';
        jTXT += '      "costPrice": "",';
        jTXT += '      "quantityPreviousBalance": "",';
        jTXT += '      "quantityReceived": 0,';
        jTXT += '      "quantitySold": 0,';
        jTXT += '      "quantityNewBalance": "",';
        jTXT += '      "quantity": 0,';
        jTXT += '      "quantityMeasurementUnitId": "",';
        jTXT += '      "measurementUnit2": "",';
        jTXT += '      "quantity2": 0,';
        jTXT += '      "netWeight": 0,';
        jTXT += '      "grossWeight": 0,';
        jTXT += '      "volume": 0,';
        jTXT += '      "allowancesCharges": ';
        jTXT += '      [';
        jTXT += '        {';
        jTXT += '          "type": "",';
        jTXT += '          "description": "",';
        jTXT += '          "code": "",';
        jTXT += '          "level": 0,';
        jTXT += '          "percentage": 0,';
        jTXT += '          "amount": 0,';
        jTXT += '          "amountAC": 0,';
        jTXT += '          "grossAmount": 0,';
        jTXT += '          "grossAmountAC": 0,';
        jTXT += '          "underlyingValue": 0,';
        jTXT += '          "underlyingValueAC": 0,';
        jTXT += '          "vatPercentage": 0,';
        jTXT += '          "vatAmount": 0,';
        jTXT += '          "vatAmountAC": 0';

        jTXT += '        }';
        jTXT += '      ],';
        jTXT += '      "internalId": "",';
        jTXT += '      "totalSurchargeAmount": 0,';
        jTXT += '      "totalSpecialTaxes": 0,';
        jTXT += '      "totalCost": 0,';
        jTXT += '      "totalNetValueBeforeTotalDiscount": 0,';
        jTXT += '      "lineApportionedDiscountValue": 0,';
        jTXT += '      "currency": "",';
        jTXT += '      "rate": 0,';
        jTXT += '      "foreignCurrencyValue": 0,';
        jTXT += '      "remarks": "",';
        jTXT += '      "reason": "",';
        jTXT += '      "detailRecipient": ';
        jTXT += '      {';
        jTXT += '        "registeredName": "",';
        jTXT += '        "brandName": "",';
        jTXT += '        "contactPerson": "",';
        jTXT += '        "registrationNumber": "",';
        jTXT += '        "envelopeNumber": "",';
        jTXT += '        "ysn": "",';
        jTXT += '        "vat": "",';
        jTXT += '        "paidUpSharedCapital": 0,';
        jTXT += '        "sharedCapitalSubscribed": 0,';
        jTXT += '        "taxOffice": "",';
        jTXT += '        "taxOfficeCode": "",';
        jTXT += '        "activities": ';
        jTXT += '        [""';

        jTXT += '        ],';
        jTXT += '        "generalCommercialRegistryNumber": "",';
        jTXT += '        "phones": ';
        jTXT += '        [""';

        jTXT += '        ],';
        jTXT += '        "faxes": ';
        jTXT += '        [""';

        jTXT += '        ],';
        jTXT += '        "emails": ';
        jTXT += '        [""';

        jTXT += '        ],';
        jTXT += '        "url": "",';
        jTXT += '        "address": ';
        jTXT += '        {';
        jTXT += '          "country": "",';
        jTXT += '          "countryCode": "",';
        jTXT += '          "municipality": "",';
        jTXT += '          "municipalityCode": "",';
        jTXT += '          "region": "",';
        jTXT += '          "regionCode": "",';
        jTXT += '          "city": "",';
        jTXT += '          "cityCode": "",';
        jTXT += '          "street": "",';
        jTXT += '          "number": "",';
        jTXT += '          "postal": "",';
        jTXT += '          "geographicalCoordinates": ';
        jTXT += '          {';
        jTXT += '            "item1": "",';
        jTXT += '            "item2": ""';

        jTXT += '          },';
        jTXT += '          "gln": ""';

        jTXT += '        },';
        jTXT += '        "branch": "",';
        jTXT += '        "branchCode": 0,';
        jTXT += '        "branchId": "",';
        jTXT += '        "posId": "",';
        jTXT += '        "branchAddress": ';
        jTXT += '        {';
        jTXT += '          "country": "",';
        jTXT += '          "countryCode": "",';
        jTXT += '          "municipality": "",';
        jTXT += '          "municipalityCode": "",';
        jTXT += '          "region": "",';
        jTXT += '          "regionCode": "",';
        jTXT += '          "city": "",';
        jTXT += '          "cityCode": "",';
        jTXT += '          "street": "",';
        jTXT += '          "number": "",';
        jTXT += '          "postal": "",';
        jTXT += '          "geographicalCoordinates": ';
        jTXT += '          {';
        jTXT += '            "item1": "",';
        jTXT += '            "item2": ""';

        jTXT += '          },';
        jTXT += '          "gln": ""';

        jTXT += '        },';
        jTXT += '        "branchPhones": ';
        jTXT += '        [""';

        jTXT += '        ],';
        jTXT += '        "branchFaxes": ';
        jTXT += '        [""';

        jTXT += '        ],';
        jTXT += '        "taxRegime": "",';
        jTXT += '        "category": "",';
        jTXT += '        "type": "",';
        jTXT += '        "code": "",';
        jTXT += '        "externalCode": "",';
        jTXT += '        "otherInfo": "",';
        jTXT += '        "identityType": "",';
        jTXT += '        "identityIdentifier": "",';
        jTXT += '        "taxRepresentativeName": "",';
        jTXT += '        "taxRepresentativeVat": "",';
        jTXT += '        "taxRepresentativeCountry": "",';
        jTXT += '        "taxRepresentativeCountryCode": "",';
        jTXT += '        "vatExemptionNote": "",';
        jTXT += '        "fuelDistributorCode": ""';

        jTXT += '      },';
        jTXT += '      "project": "",';
        jTXT += '      "lotNumber": "",';
        jTXT += '      "serialNumbers": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "relativeDocuments": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "catalogUnitPrice": 0,';
        jTXT += '      "unitPrice": 0,';
        jTXT += '      "catalogNetTotal": 0,';
        jTXT += '      "catalogTotal": 0,';
        jTXT += '      "netTotalAfterInlineALCs": 0,';
        jTXT += '      "netTotal": 0,';
        jTXT += '      "netTotalAC": 0,';
        jTXT += '      "total": 0,';
        jTXT += '      "totalAC": 0,';
        jTXT += '      "allowancesTotal": 0,';
        jTXT += '      "allowancesTotalAC": 0,';
        jTXT += '      "chargesTotal": 0,';
        jTXT += '      "chargesTotalAC": 0,';
        jTXT += '      "vatTotal": 0,';
        jTXT += '      "vatTotalAC": 0,';
        jTXT += '      "exchangeCurrencyValue": 0,';
        jTXT += '      "localCurrencyValue": 0,';
        jTXT += '      "counterpartCurrencyValue": 0,';
        jTXT += '      "reasoning": "",';
        jTXT += '      "beneficiaryAccount": "",';
        jTXT += '      "beneficiary": "",';
        jTXT += '      "exchange": "",';
        jTXT += '      "chrimatikaDiathesima": "",';
        jTXT += '      "securitiesAmount": 0,';
        jTXT += '      "registrationNumber": 0,';
        jTXT += '      "securitiesBank": "",';
        jTXT += '      "dueDate": "",';
        jTXT += '      "localCurrencyExchangeRate": 0,';
        jTXT += '      "securitiesField": "",';
        jTXT += '      "sponsorCode": "",';
        jTXT += '      "sponsorName": "",';
        jTXT += '      "issuerName": "",';
        jTXT += '      "issuerCode": "",';
        jTXT += '      "invoiceDetailType": "",';
        jTXT += '      "invoiceDetailTypeCode": 0,';
        jTXT += '      "vatExcemptionCategory": "",';
        jTXT += '      "vatExemptionCategoryCode": 0,';
        jTXT += '      "shipType": ';
        jTXT += '      {';
        jTXT += '        "applicationId": "",';
        jTXT += '        "applicationDate": "",';
        jTXT += '        "doy": "",';
        jTXT += '        "shipId": ""';

        jTXT += '      },';
        jTXT += '      "discountOption": false,';
        jTXT += '      "vatCategory": "",';
        jTXT += '      "vatCategoryCode": 0,';
        jTXT += '      "withheldAmount": 0,';
        jTXT += '      "withheldAmountAC": 0,';
        jTXT += '      "withheldPercentCategory": "",';
        jTXT += '      "withheldPercentCategoryCode": 0,';
        jTXT += '      "stampDutyAmount": 0,';
        jTXT += '      "stampDutyAmountAC": 0,';
        jTXT += '      "stampDutyPercentCategory": "",';
        jTXT += '      "stampDutyPercentCategoryCode": 0,';
        jTXT += '      "feesAmount": 0,';
        jTXT += '      "feesAmountAC": 0,';
        jTXT += '      "feesPercentCategory": "",';
        jTXT += '      "feesPercentCategoryCode": 0,';
        jTXT += '      "otherTaxesPercentCategory": "",';
        jTXT += '      "otherTaxesPercentCategoryCode": 0,';
        jTXT += '      "otherTaxesAmount": 0,';
        jTXT += '      "otherTaxesAmountAC": 0,';
        jTXT += '      "deductionsAmount": 0,';
        jTXT += '      "deductionsAmountAC": 0,';
        jTXT += '      "isInformative": false,';
        jTXT += '      "isHidden": false,';
        jTXT += '      "recordType": "",';
        jTXT += '      "recordTypeCode": "",';
        jTXT += '      "incomeClassification": ';
        jTXT += '      {';
        jTXT += '        "id": 0,';
        jTXT += '        "classificationType": "",';
        jTXT += '        "classificationTypeCode": "",';
        jTXT += '        "classificationCategory": "",';
        jTXT += '        "classificationCategoryCode": "",';
        jTXT += '        "amount": 0';

        jTXT += '      },';
        jTXT += '      "expensesClassification": ';
        jTXT += '      {';
        jTXT += '        "id": 0,';
        jTXT += '        "classificationType": "",';
        jTXT += '        "classificationTypeCode": "",';
        jTXT += '        "classificationCategory": "",';
        jTXT += '        "classificationCategoryCode": "",';
        jTXT += '        "amount": 0';

        jTXT += '      },';
        jTXT += '      "vatClassification": ';
        jTXT += '      {';
        jTXT += '        "id": 0,';
        jTXT += '        "classificationType": "",';
        jTXT += '        "classificationTypeCode": "",';
        jTXT += '        "classificationCategory": "",';
        jTXT += '        "classificationCategoryCode": "",';
        jTXT += '        "amount": 0';

        jTXT += '      },';
        jTXT += '      "fuelCode": 0,';
        jTXT += '      "specificWeight": 0,';
        jTXT += '      "tags": ';
        jTXT += '      [""';

        jTXT += '      ],';
        jTXT += '      "compartments": "",';
        jTXT += '      "containerName": "",';
        jTXT += '      "conversionFactor": 0,';
        jTXT += '      "density": 0,';
        jTXT += '      "temperature": 0';

        jTXT += '    }';
        jTXT += '  ],';
        jTXT += '  "summaries": ';
        jTXT += '  {';
        jTXT += '    "totalCatalogNetAmount": 0,';
        jTXT += '    "totalCatalogNetAmountAC": 0,';
        jTXT += '    "totalNetAmount": 0,';
        jTXT += '    "totalNetAmountAC": 0,';
        jTXT += '    "totalNetAmountAfterLineDiscounts": 0,';
        jTXT += '    "totalNetAmountAfterLineDiscountsAC": 0,';
        jTXT += '    "totalVATAmount": 0,';
        jTXT += '    "totalVATAmountAC": 0,';
        jTXT += '    "totalWithheldAmount": 0,';
        jTXT += '    "totalWithheldAmountAC": 0,';
        jTXT += '    "totalFeesAmount": 0,';
        jTXT += '    "totalFeesAmountAC": 0,';
        jTXT += '    "totalStampDutyAmount": 0,';
        jTXT += '    "totalStampDutyAmountAC": 0,';
        jTXT += '    "totalOtherTaxesAmount": 0,';
        jTXT += '    "totalOtherTaxesAmountAC": 0,';
        jTXT += '    "totalDeductionsAmount": 0,';
        jTXT += '    "totalDeductionsAmountAC": 0,';
        jTXT += '    "totalGrossValue": 0,';
        jTXT += '    "totalGrossValueAC": 0,';
        jTXT += '    "totalAllowances": 0,';
        jTXT += '    "totalAllowancesAC": 0,';
        jTXT += '    "totalAllowancesWithoutLines": 0,';
        jTXT += '    "totalAllowancesWithoutLinesAC": 0,';
        jTXT += '    "totalCharges": 0,';
        jTXT += '    "totalChargesAC": 0,';
        jTXT += '    "totalSpecialCharges": 0,';
        jTXT += '    "totalSpecialChargesAC": 0,';
        jTXT += '    "totalPayableAmount": 0,';
        jTXT += '    "totalPayableAmountAC": 0,';
        jTXT += '    "incomeClassifications": ';
        jTXT += '    [';
        jTXT += '      {';
        jTXT += '        "id": 0,';
        jTXT += '        "classificationType": "",';
        jTXT += '        "classificationTypeCode": "",';
        jTXT += '        "classificationCategory": "",';
        jTXT += '        "classificationCategoryCode": "",';
        jTXT += '        "amount": 0';

        jTXT += '      }';
        jTXT += '    ],';
        jTXT += '    "expensesClassifications": ';
        jTXT += '    [';
        jTXT += '      {';
        jTXT += '        "id": 0,';
        jTXT += '        "classificationType": "",';
        jTXT += '        "classificationTypeCode": "",';
        jTXT += '        "classificationCategory": "",';
        jTXT += '        "classificationCategoryCode": "",';
        jTXT += '        "amount": 0';

        jTXT += '      }';
        jTXT += '    ]';
        jTXT += '  },';
        jTXT += '  "taxes": ';
        jTXT += '  [';
        jTXT += '    {';
        jTXT += '      "taxType": "",';
        jTXT += '      "taxTypeCode": 0,';
        jTXT += '      "taxCategory": "",';
        jTXT += '      "taxCategoryCode": 0,';
        jTXT += '      "taxAmount": 0,';
        jTXT += '      "taxAmountAC": 0,';
        jTXT += '      "id": 0,';
        jTXT += '      "underlyingValue": 0,';
        jTXT += '      "underlyingValueAC": 0,';
        jTXT += '      "vatPercentage": 0,';
        jTXT += '      "vatPercentageCode": 0,';
        jTXT += '      "vatAmount": 0,';
        jTXT += '      "vatAmountAC": 0';

        jTXT += '    }';
        jTXT += '  ],';
        jTXT += '  "vatAnalysis": ';
        jTXT += '  [';
        jTXT += '    {';
        jTXT += '      "name": "",';
        jTXT += '      "percentage": 0,';
        jTXT += '      "vatAmount": 0,';
        jTXT += '      "vatAmountAC": 0,';
        jTXT += '      "underlyingValue": 0,';
        jTXT += '      "underlyingValueAC": 0,';
        jTXT += '      "vatExemption": "",';
        jTXT += '      "vatExemptionCode": 0,';
        jTXT += '      "initialAmount": 0,';
        jTXT += '      "initialAmountAC": 0,';
        jTXT += '      "discountAmount": 0,';
        jTXT += '      "discountAmountAC": 0,';
        jTXT += '      "grossAmount": 0,';
        jTXT += '      "grossAmountAC": 0';

        jTXT += '    }';
        jTXT += '  ],';
        jTXT += '  "miscellaneousData": ';
        jTXT += '  {';
        jTXT += '    "moreInformation1": "",';
        jTXT += '    "moreInformation2": "",';
        jTXT += '    "moreInformation3": "",';
        jTXT += '    "comments1": "",';
        jTXT += '    "comments2": "",';
        jTXT += '    "accompanyingText": "",';
        jTXT += '    "purchaseOrderNumber": "",';
        jTXT += '    "purchaseDate": "",';
        jTXT += '    "qrCode": "",';
        jTXT += '    "gtin": ""';

        jTXT += '  },';
        jTXT += '  "vatPaymentSuspension": false,';
        jTXT += '  "selfPricing": false,';
        jTXT += '  "isDelayed": false,';
        jTXT += '  "isDelayedCode": "",';
        jTXT += '  "isFuelInvoice": false,';
        jTXT += '  "aadeXml": "",';
        jTXT += '  "iaprResponse": "",';
        jTXT += '  "supportedDocument": ""';

        jTXT += '}';
        if jToken.ReadFrom(jTxt) then begin
            if jToken.IsObject then begin
                jObj := jToken.AsObject();
                jObj.WriteTo(jTxt);
            end else
                message('Error Json File');
        end else
            message('Error Reading Json File');
    End;

}