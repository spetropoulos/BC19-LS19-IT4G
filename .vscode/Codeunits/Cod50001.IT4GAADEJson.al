codeunit 50001 "IT4G-AADE Json"
{

    procedure CreateAADEJson(xStore: Code[20]; xPOS: Code[20]; xTransNo: Integer): JsonObject
    var
        rTTS: Record "LSC Tender Type Setup";
        rTIE: Record "LSC Trans. Infocode Entry";
        rNS: Record "No. Series";
        rDoc: Record "IT4G-LS Document";
        rDocS: Record "IT4G-LS Document";
        rTH: Record "LSC Transaction Header";
        rTSE: Record "LSC Trans. Sales Entry";
        rTPE: Record "LSC Trans. payment Entry";
        rTIEE: Record "LSC Trans. Inc./Exp. Entry";
        rI: Record Item;

        jInvoice: JsonObject;
        jTxt: Text;
    begin
        rTH.GET(xStore, xPOS, xTransNo);
        rDoc.Get(rTH."Document Code");
        rDocS.get(rDoc."Series Document");
        rNS.Get(rTH."Post Series");

        rTSE.SETRANGE("Store No.", xStore);
        rTSE.SETRANGE("POS Terminal No.", xPOS);
        rTSE.SETRANGE("Transaction No.", xTransNo);
        iF rTSE.findset then begin
            repeat
            until rTSE.Next() = 0;
        end;
        rTPE.SETRANGE("Store No.", xStore);
        rTPE.SETRANGE("POS Terminal No.", xPOS);
        rTPE.SETRANGE("Transaction No.", xTransNo);
        iF rTPE.findset then begin
            repeat
            until rTPE.Next() = 0;
        end;

        rTIEE.SETRANGE("Store No.", xStore);
        rTIEE.SETRANGE("POS Terminal No.", xPOS);
        rTIEE.SETRANGE("Transaction No.", xTransNo);



        /*
        {
          "publicSalt": "string",
          "publicSignature": "string",
          "privateSignature": "string",
          "mark": 0,
          "uid": "string",
          "iaprSignPolicy": "DEFAULT",
          "uniqueId": "string",
          "cancellationMark": 0,
          "classificationMark": 0,
          "version": "string",
          "authenticationCode": "string",
          "languageCode": "el,de",
          "currency": "Euro",
          "currencyCode": "string",
          */
        //"invoiceType": "Πιστωτικό Τιμολόγιο Παροχής Υπηρεσιών",
        jInvoice.Add('invoiceType', rDocS.Description);
        //"invoiceTypeCode": "string",
        jInvoice.Add('invoiceTypeCode', rDocS.Code);
        //"documentType": "INVOICE",
        jInvoice.Add('documentType', rDocS.Description);
        //"documentTypeCode": "INVOICE",
        jInvoice.Add('documentTypeCode', 'INVOICE');

        //"copyTypeNamePurpose": "string",
        //"series": "string",
        jInvoice.Add('series', rNS.Code);
        //"number": "string",
        jInvoice.Add('number', rTH."Document No.");
        //"issuerFormatedInvoiceSeriesNumber": "string",
        jInvoice.Add('issuerFormatedInvoiceSeriesNumber', rTH."Document No.");
        //"dateIssued": "2022-04-14T13:55:00.439Z",
        jInvoice.Add('dateIssued', CreateDateTime(rTh.Date, rTH.Time));
        /*


       */


    end;
}
