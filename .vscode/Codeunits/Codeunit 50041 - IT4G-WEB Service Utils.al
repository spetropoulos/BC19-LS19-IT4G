codeunit 50041 "IT4G - WEB Service Utils"
{
    trigger OnRun()
    var
    begin

        Case WEBServiceType of
            'Test':
                Run_Test();
            'Pobuca_RetrieveAccount':
                PobucaRetrieveAccount();
            'Pobuca_SubmitInvoice':
                PobucaSubmitInvoice();
        End;
    end;

    var
        WEBServiceType: Text;
        jClient: HttpClient;
        jContent: HttpContent;
        jRequestMessage: HttpRequestMessage;
        jResponseMessage: HttpResponseMessage;
        jheaders: HttpHeaders;
        jResponseString: Text;
        jToken: JsonToken;
        jToken2: JsonToken;
        JObject: JsonObject;
        JObject2: JsonObject;
        jArray: JsonArray;
        JsonText: Text;
        rGWSS: Record "IT4G-WEb Service Setup";
        rGWSSL: Record "IT4G-WEb Service Setup Line";
        cWF: Codeunit "IT4G - WEB Service Functions";
        gURL: text;
        gWhat: text;
        gParams: Array[20] of Text;
        gStatus: Code[20];
        GlobalWSCode: code[20];
        GlobalWSSubCode: code[20];
        GlobalKey: Text;

    procedure Init()
    begin
        gURL := '';
        gWhat := '';
        gStatus := '';
        WEBServiceType := '';
    end;

    procedure SetService(xWhat: text; xCode: code[20]; xSubCode: code[20]; xKey: Text; var xParams: Array[20] of Text)
    begin
        Init();
        GlobalWSCode := xCode;
        GlobalWSSubCode := xSubCode;
        CopyArray(gParams, xParams, 1);
        WEBServiceType := xWhat;
        globalKey := xkey;
        clear(rGWSS);
        rGWSS.setrange(Code, GlobalWSCode);
        rGWSS.SetRange(Active, true);
        rGWSS.FindFirst();
        rGWSSL.get(GlobalWSCode, GlobalWSSubCode);

        gURL := rGWSSL.GetURL();
    end;

    procedure getRetvalues(var xParams: Array[20] of Text)
    begin
        CopyArray(xParams, gParams, 1);
    end;

    local procedure CreateJsonCall()
    var
        lblClientError: Label 'The call to the web service failed.';
        txtErr: Text;
    begin
        txtErr := '';
        jContent.WriteFrom(JsonText);
        jContent.GetHeaders(jheaders);
        jheaders.Clear();
        jheaders.add('Content-Type', 'application/json');
        jheaders.add('charset', 'UTF-8');

        jRequestMessage.Content := jContent;
        jRequestMessage.Method := format(rGWSSL.Method);
        jRequestMessage.SetRequestUri(gURL);

        jClient.Send(jRequestMessage, jResponseMessage);
        gStatus := format(jResponseMessage.HttpStatusCode);

        jResponseMessage.Content.ReadAs(JsonText);
        if rGWSS.Debug and (rGWSS."Debug Path" <> '') then ExportFile(JsonText, '_response.json');

        If JsonText <> '' then
            if not jResponseMessage.IsSuccessStatusCode then begin

                if Jtoken.ReadFrom(JsonText) then begin
                    if Jtoken.IsObject() then begin
                        JObject := Jtoken.AsObject();
                        txtErr := getJsonValue('message') + '\' + getJsonValue('modelState');
                    end;

                    JObject := Jtoken.AsObject();
                    Error('The web service returned an error message:\' +
                             'Status code: %1\' +
                             'Description: %2' +
                             'Reason: %3',
                             jResponseMessage.HttpStatusCode,
                             jResponseMessage.ReasonPhrase,
                             txtErr);
                end;
            end;

        if not Jtoken.ReadFrom(JsonText) then Error('Invalid response, expected a JSON object');
        if not Jtoken.IsObject() then Error('Invalid response, expected a JSON object');

        JObject := Jtoken.AsObject();
    end;

    procedure ExportFile(xFileContent: text; xsuffix: text)
    var
        FileMgmt: Codeunit "File Management";
        FileName: Text;
        ServerFileName: Text;
        DotFile: File;
        LogOutStream: OutStream;
        LogInStream: InStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        ServerFileName := FileMgmt.ServerTempFileName('json');
        TempBlob.CreateOutStream(LogOutStream);
        LogOutStream.WriteText(xFileContent);
        TempBlob.CreateInStream(LogInStream);
        Serverfilename := FileMgmt.InstreamExportToServerFile(LogInStream, 'json');
        FileName := rGWSS."Debug Path" + GlobalKey + xsuffix;
        FileMgmt.CopyServerFile(ServerFileName, FileName, true);
        FileMgmt.DeleteServerFile(ServerFileName);

    end;

    procedure GetURL(): Text
    begin
        exit(gURL);
    end;

    procedure GetStatus(): code[20]
    begin
        exit(gStatus);
    end;

    procedure Run_Test()
    begin

    end;

    procedure PobucaRetrieveAccount();
    var
        xInput: Text;
    begin
        gURL := StrSubstNo(gURL, rGWSS."URL var 1", rGWSS."Authentication Key");
        xInput := gParams[2];
        case gParams[1] of
            'CRD':
                JObject.Add('sfmCard', xInput);
            'OTP':
                JObject.Add('orderOTP', xInput);
            'MOB':
                JObject.Add('mobilePhone', xInput);
            else
                JObject.Add('contactId', xInput);
        end;

        JObject.Add('searchOnlyLoyalty', true);
        JObject.WriteTo(JsonText);

        if rGWSS.Debug and (rGWSS."Debug Path" <> '') then ExportFile(JsonText, '_request.json');
        CreateJsonCall;

        if JObject.Get('identityResult', jToken2) then
            if jToken2.IsObject then begin
                jObject2 := jToken2.AsObject();
                if JObject2.get('succeeded', jToken2) then
                    If not jToken2.AsValue().AsBoolean() then begin
                        if JObject2.get('errors', jToken2) then
                            if jToken2.IsArray then begin
                                jArray := jToken2.AsArray();

                                jArray.get(0, jToken2);
                                JObject2 := jToken2.AsObject();
                                JObject2.get('description', jToken2);
                                error(jToken2.AsValue().AsText());

                            end;
                    end;
            end;


        Clear(gParams);

        gParams[1] := getJsonValue('contactId');
        gParams[2] := getJsonValue('firstName');
        gParams[3] := getJsonValue('lastName');
        gParams[4] := getJsonValue('mobilePhone');
        gParams[5] := getJsonValue('sfmCard');
        gParams[6] := getJsonValue('points');
    end;

    procedure PobucaSubmitInvoice();
    var
        xStore: Code[20];
        xPOS: Code[20];
        xTransNo: Integer;
        rTH: Record "LSC Transaction Header";
        rTSE: Record "LSC Trans. Sales Entry";
        rTPE: Record "LSC Trans. payment Entry";
        rTIEE: Record "LSC Trans. Inc./Exp. Entry";
        jInvoice: JsonObject;
        jLine: JsonObject;
        jItems: JsonArray;
        jPayments: JsonArray;
        jCoupons: JsonArray;
        rI: Record Item;
        rTTS: Record "LSC Tender Type Setup";
    begin
        gURL := StrSubstNo(gURL, rGWSS."URL var 1", rGWSS."Authentication Key");
        xStore := gParams[1];
        xPOS := gParams[2];
        evaluate(xTransNo, gParams[3]);

        rTH.GET(xStore, xPOS, xTransNo);

        jInvoice.Add('transactionId', rTH."Store No." + '-' + rTH."POS Terminal No." + '-' + format(rTH."Transaction No."));
        jInvoice.Add('customerId', rTH."IT4G-Loyalty ID");
        jInvoice.Add('customerType', 'Contact');
        jInvoice.Add('storeIdOrCode', rTH."Store No.");
        jInvoice.Add('isReturn', rTh."Sale Is Return Sale");
        jInvoice.Add('submittedOnUtc', CurrentDateTime);

        rTSE.SETRANGE("Store No.", xStore);
        rTSE.SETRANGE("POS Terminal No.", xPOS);
        rTSE.SETRANGE("Transaction No.", xTransNo);
        iF rTSE.findset then begin
            repeat
                clear(jLine);
                rI.GET(rTSE."Item No.");
                jLine.Add('invoiceLineNumber', rTSE."Line No.");
                jLine.Add('productIdOrSku', rTSE."Item No.");
                jLine.Add('productName', rI.Description);
                jLine.Add('quantity', -rTSE.Quantity);
                jLine.Add('isPriceOverriden', rTSE."Price Change");
                jLine.Add('unitPrice', rTSE.Price);
                jLine.Add('isDiscount', true);
                //				jLine.Add('discount', rTSE.disc
                jLine.Add('valueForPoints', -(rTSE."Net Amount" + rTSE."VAT Amount"));
                //				jLine.Add('customEntityAttributes': {
                //					"pb_fullproductcode": "2100000003002"
                jItems.Add(jLine);
            until rTSE.Next() = 0;
            jInvoice.add('items', jItems);
        end;
        rTPE.SETRANGE("Store No.", xStore);
        rTPE.SETRANGE("POS Terminal No.", xPOS);
        rTPE.SETRANGE("Transaction No.", xTransNo);
        iF rTPE.findset then begin
            repeat
                clear(jLine);
                rTTS.GET(rTPE."Tender Type");
                jLine.Add('paymentMethodCode', rTTS.Code);
                jLine.Add('description', rTTS.Description);
                jLine.Add('value', rTPE."Amount Tendered");
                jLine.Add('givesPoints', rTTS."Loyalty Points");
                jPayments.Add(jLine);
            until rTPE.Next() = 0;
            jInvoice.add('paymentMethods', jPayments);
        end;

        rTIEE.SETRANGE("Store No.", xStore);
        rTIEE.SETRANGE("POS Terminal No.", xPOS);
        rTIEE.SETRANGE("Transaction No.", xTransNo);


        jInvoice.Add('searchOnlyLoyalty', true);
        JObject.Add('invoice', jInvoice);
        JObject.WriteTo(JsonText);

        if rGWSS.Debug and (rGWSS."Debug Path" <> '') then ExportFile(JsonText, '_request.json');

        CreateJsonCall;

        Clear(gParams);

        gParams[1] := getJsonValue('points');
    end;

    local procedure getJsonValue(xVal: text): Text
    begin
        if not JObject.Get(xVal, Jtoken2) then Error('Value for key name not found.');
        if not Jtoken2.IsValue then Error('Expected a JSON value.');
        exit(jtoken2.AsValue().AsText());

    end;
}
