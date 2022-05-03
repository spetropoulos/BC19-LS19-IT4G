codeunit 50041 "IT4G-WEB Service Utils"
{
    trigger OnRun()
    var
    begin

        Case WEBServiceType of
            'Test':
                Run_Test();
            'Pobuca_RetrieveAccount':
                Pobuca_RetrieveAccount();
            'Pobuca_CreateAccount':
                Pobuca_RetrieveAccount();
            'Pobuca_SubmitInvoice':
                Pobuca_SubmitInvoice();
            'Pobuca_SendProduct':
                Pobuca_SendProduct();
            'AADE_SoftOne_SendInvoice':
                AADE_SoftOne_SendInvoice();
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
        cWF: Codeunit "IT4G-WEB Service Functions";
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
                        case rGWSS.Code of
                            'POBUCA':
                                txtErr := getJsonValueErr('message') + '\' + getJsonValueErr('modelState');
                            'AADE-SOFTONE':
                                txtErr := getJsonValueErr('title') + '\' + getJsonValueErr('message') + '\TraceID:' + getJsonValueErr('traceId');
                        end;
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

    procedure Pobuca_RetrieveAccount();
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
                                JObject2.get('code', jToken2);
                                gParams[1] := jToken2.AsValue().AsText();
                                error(jToken2.AsValue().AsText());
                                JObject2.get('description', jToken2);
                                gParams[2] := jToken2.AsValue().AsText();
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
        gParams[7] := getJsonValue('email');
    end;

    procedure Pobuca_SubmitInvoice();
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
        jCustomAttributes: JsonObject;
        rI: Record Item;
        rTTS: Record "LSC Tender Type Setup";
        rTIE: Record "LSC Trans. Infocode Entry";
    begin
        gURL := StrSubstNo(gURL, rGWSS."URL var 1", rGWSS."Authentication Key");
        xStore := gParams[1];
        xPOS := gParams[2];
        evaluate(xTransNo, gParams[3]);

        rTH.GET(xStore, xPOS, xTransNo);

        jInvoice.Add('transactionId', rTH."Store No." + '-' + rTH."POS Terminal No." + '-' + format(rTH."Transaction No."));

        jInvoice.Add('orderId', rTH."WEB Order No.");   //no Value for guest Orders

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
                Clear(jCustomAttributes);
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

                jCustomAttributes.Add('pb_fullproductcode', rTSE."Item No." + rTSE."Variant Code");
                jLine.Add('customEntityAttributes', jCustomAttributes);
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

        clear(jCustomAttributes);
        jCustomAttributes.Add('pb_documentnumber', rTH."Document No.");
        jCustomAttributes.Add('pb_order', rTH."WEB Order No.");  //Only for Guest WEB orders
        jInvoice.Add('customEntityAttributes', jCustomAttributes);

        JObject.Add('invoice', jInvoice);
        JObject.WriteTo(JsonText);

        if rGWSS.Debug and (rGWSS."Debug Path" <> '') then ExportFile(JsonText, '_request.json');

        CreateJsonCall;

        Clear(gParams);

        gParams[1] := getJsonValue('points');

        clear(rTIE);
        rTIE."Store No." := xStore;
        rTIE."POS Terminal No." := xPOS;
        rTIE."Transaction No." := xTransNo;
        rTIE.Infocode := 'LOY_MEMB_TR_POINTS';
        rTIE.Information := gParams[1];
        rTIE."Transaction Type" := rTIE."Transaction Type"::Header;
        rTIE.Date := Today;
        rTIE.Time := Time;
        rTIE."Type of Input" := rTIE."Type of Input"::Numeric;
        if not rTIE.Insert(TRUE) then rTIE.Modify(TRUE);
        rTIE.Infocode := 'LOY_MEMB_TR_SEND';
        rTIE."Type of Input" := rTIE."Type of Input"::Numeric;
        rTIE.Information := 'true';
        if not rTIE.Insert(TRUE) then rTIE.Modify(TRUE);
    end;

    procedure Pobuca_SendProduct();
    var
        jItem: JsonObject;
        rI: Record Item;
        i: Integer;
        t: Integer;
        cF: Codeunit "IT4G-Functions";
        maxRecs: Integer;
        rSeason: Record "LSC Season";
    begin
        maxRecs := cF.GRV_I('IT4G_Pobuca_MaxItemsExport', 0, 1);
        if maxRecs = 0 then maxRecs := 100;
        gURL := StrSubstNo(gURL, rGWSS."URL var 1", rGWSS."Authentication Key");

        If gParams[1] <> '' then rI.SetRange("No.", gParams[1]);

        if rI.findset then begin
            t := rI.Count;
            i := 0;
            repeat
                i += 1;
                jItem.Add('productNo', rI."No.");

                jItem.Add('shortDescription', rI.Description);   //no Value for guest Orders
                jItem.Add('longDescription', rI."Description 2");

                jItem.Add('fedas', '');
                jItem.Add('category', '');
                jItem.Add('activity', '');
                jItem.Add('mainGroup', '');
                jItem.Add('subGroup', '');
                jItem.Add('seasonCode', rI."LSC Season Code");
                if rSeason.Get(rI."LSC Season Code") then jItem.Add('seasonDescription', rSeason.Description);
                jItem.Add('brandCode', '');
                jItem.Add('brandDescription', '');
            until (rI.Next = 0) or (i >= maxRecs);
        end;

        //        JObject.Add('invoice', jInvoice);
        //        JObject.WriteTo(JsonText);

        if rGWSS.Debug and (rGWSS."Debug Path" <> '') then ExportFile(JsonText, '_request.json');

        CreateJsonCall;

        Clear(gParams);


    end;

    local procedure getJsonValue(xVal: text): Text
    begin
        if not JObject.Get(xVal, Jtoken2) then Error('Value for key name not found.');
        if not Jtoken2.IsValue then Error('Expected a JSON value.');
        exit(jtoken2.AsValue().AsText());

    end;

    local procedure getJsonValueErr(xVal: text): Text
    begin
        if JObject.Get(xVal, Jtoken2) then
            if Jtoken2.IsValue then
                exit(jtoken2.AsValue().AsText());

    end;

    local procedure AADE_SoftOne_SendInvoice();
    var
        xStore: Code[20];
        xPOS: Code[20];
        xTransNo: Integer;

        cC: Codeunit "AADE Json";

        jInvoice: JsonObject;

    begin
        gURL := StrSubstNo(gURL, rGWSS."Authentication Key");
        xStore := gParams[1];
        xPOS := gParams[2];
        evaluate(xTransNo, gParams[3]);
        JsonText := cC.GenerateJsonLS(xStore, xPOS, xTransNo);
        if rGWSS.Debug and (rGWSS."Debug Path" <> '') then ExportFile(JsonText, '_request.json');

        CreateJsonCall;

        Clear(gParams);
        //todo: Validate Response

    end;

}

