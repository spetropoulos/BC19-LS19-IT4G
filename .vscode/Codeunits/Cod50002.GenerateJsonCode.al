codeunit 50002 "IT4G-Generate Json Code"
{
    var
        rjB: Record "JSON Buffer" temporary;
        rjB1: Record "JSON Buffer" temporary;
        retVars: Text;
        retRoot: Text;
        retFunc: Text;
        chrCR: Char;
        QT: Label '''';
        jObj: JsonObject;

    Procedure GenerateJsonCode1(jTXT: Text) retCode: Text
    begin
        chrCR := 13;
        rjB.ReadFromText(jTXT);
        rjB1.Copy(rjB, true);
        page.run(50002, rjB);

        retVars := 'var' + chrCR;
        retVars += 'jRoot_Obj: jSonObject;' + chrCR;
        retVars += 'jTXT: Text;' + chrCR;
        retVars += 'cC: Codeunit "IT4G-Functions";' + chrCR;

        retVars += 'trigger OnRun()' + chrCR;
        retVars += 'begin' + chrCR;
        retVars += '    GenerateJson();' + chrCR;
        retVars += '    jRoot_Obj.WriteTo(jTXT);' + chrCR;
        retVars += '    cC.ExportFile(jTXT,' + QT + 'c:\kouvas\lala' + QT + ',' + QT + 'json' + QT + ');' + chrCR;
        retVars += 'end;' + chrCR;

        rjB.setrange(Depth, 1);

        retRoot := 'Procedure GenerateJson()' + chrCR + 'begin ' + chrCR;

        If rjB.Findset then begin
            repeat
                if rjB1.get(rJB."Entry No." + 1) then
                    if rjB1.Depth = rjB.Depth then
                        If rjB1."Token type" in [rjB1."Token type"::String, rjB1."Token type"::Decimal, rjB1."Token type"::Integer, rjB1."Token type"::Boolean, rjB1."Token type"::Date] then begin
                            retRoot += 'jRoot_Obj.add(' + QT + rjB.Value + QT + ',';
                            case rjB1."Token type" of
                                rjB1."Token type"::Decimal, rjB1."Token type"::Integer:
                                    retRoot += '0);' + chrCR;
                                rjB1."Token type"::String:
                                    retRoot += QT + QT + ');' + chrCR;
                                rjB1."Token type"::Boolean:
                                    retRoot += 'false);' + chrCR;
                                rjB1."Token type"::Date:
                                    retRoot += '0D);' + chrCR;
                            end;
                        end else begin
                            case rjB1."Token type" of
                                rjB1."Token type"::"Start Array":
                                    begin
                                        retRoot += rjB.Value + '_Array();' + chrCR;
                                        CreateArrayProcedure(rjB.Value, 'jRoot_Obj');
                                    end;
                                rjB1."Token type"::"Start Object":
                                    begin
                                        retRoot += rjB.Value + '_Obj();' + chrCR;
                                        CreateObjProcedure(rjB.Value, 'jRoot_Obj');
                                    end;
                            end;
                        end;
            until rjB.Next() = 0;
        end;
        retRoot += 'End;';

        retCode := 'codeunit 50003 "lala"' + ChrCR + '{' + chrCR + retVars + chrCR + retRoot + chrCR + retFunc + chrCR + '}';

    end;

    procedure CreateArrayProcedure(prdName: Text; whereToAdd: Text)
    begin
        retFunc += 'Procedure ' + prdName + '_Array()' + chrCR;
        retFunc += 'var ' + chrCR;
        retFunc += 'jArray: JsonArray; ' + chrCR;
        retFunc += 'Begin ' + chrCR;
        retFunc += whereToAdd + '.add(' + QT + prdName + QT + ',jArray);' + chrCR;

        retFunc += 'End;' + chrCR;
    end;

    procedure CreateObjProcedure(prdName: Text; whereToAdd: Text)
    begin
        retFunc += 'Procedure ' + prdName + '_Obj()' + chrCR;
        retFunc += 'var ' + chrCR;
        retFunc += 'jObj: JsonObject; ' + chrCR;
        retFunc += 'Begin ' + chrCR;

        retFunc += whereToAdd + '.add(' + QT + prdName + QT + ',jObj);' + chrCR;
        retFunc += 'End;' + chrCR;
    end;



    Procedure GenerateJsonCode(jTXT: Text) retCode: Text
    var
        x1: Text;
    begin
        chrCR := 13;
        rjB.ReadFromText(jTXT);
        rjB1.Copy(rjB, true);
        page.run(50002, rjB);

        retVars := 'var' + chrCR;
        retVars += 'jTxt: Text;' + chrCR;
        retVars += 'cC: Codeunit "IT4G-Functions";' + chrCR;
        retVars += 'jObj: jSonObject;' + chrCR;
        retVars += 'jToken: jSonToken;' + chrCR;

        retVars += 'trigger OnRun()' + chrCR;
        retVars += 'begin' + chrCR;
        retVars += '    GenerateJson();' + chrCR;
        retVars += '    cC.ExportFile(jTXT,' + QT + 'c:\kouvas\lala.json' + QT + ',' + QT + 'json' + QT + ');' + chrCR;
        retVars += 'end;' + chrCR;

        retRoot := 'Procedure GenerateJson(): Text' + chrCR + 'begin ' + chrCR;

        If rjB.Findset then begin
            repeat
                if not (rjB."Token type" in [rjB."Token type"::"Property Name", rjB."Token type"::"Start Object"]) then retRoot += chrCR;
                x1 := 'jTXT += ' + QT + padstr('', rjB.Depth * 2, ' ');

                case rjB."Token type" of
                    rjB."Token type"::"Start Object":
                        retRoot += x1 + '{' + QT + ';';
                    rjB."Token type"::"End Object":
                        begin
                            retRoot += x1 + '}';
                            SetComma(rjB."Entry No.", retRoot);
                            retRoot += QT + ';';
                        end;
                    rjB."Token type"::"Start Array":
                        begin
                            retRoot += x1 + '[';
                            if rjB1.get(rjB."Entry No." + 1) then
                                if rjB1.Value <> '' then begin
                                    case rjB1."Token type" of
                                        rjB1."Token type"::Decimal, rjB1."Token type"::Integer:
                                            retRoot += '0';
                                        rjB1."Token type"::String:
                                            retRoot += '""';
                                        rjB1."Token type"::Boolean:
                                            retRoot += 'false';
                                        rjB1."Token type"::Date:
                                            retRoot += '""';
                                    end;
                                end;
                            retRoot += QT + ';';
                        end;
                    rjB."Token type"::"End Array":
                        begin
                            retRoot += x1 + ']';
                            SetComma(rjB."Entry No.", retRoot);
                            retRoot += QT + ';';
                        end;
                    rjB."Token type"::"Property Name":
                        begin
                            retRoot += x1 + '"' + rjB.Value + '": ';
                            if rjB1.get(rjB."Entry No." + 1) then
                                if rjB1."Value Type" <> '' then begin
                                    case rjB1."Token type" of
                                        rjB1."Token type"::Decimal, rjB1."Token type"::Integer:
                                            retRoot += '0';
                                        rjB1."Token type"::String:
                                            retRoot += '""';
                                        rjB1."Token type"::Boolean:
                                            retRoot += 'false';
                                        rjB1."Token type"::Date:
                                            retRoot += '""';
                                    end;
                                    SetComma(rjB1."Entry No.", retRoot);
                                end;

                            retRoot += QT + ';';
                        end;
                end;

            until rjB.next = 0;


            retRoot += 'if jToken.ReadFrom(jTxt) then begin' + chrCR;
            retRoot += 'if jToken.IsObject then begin' + chrCR;
            retRoot += 'jObj := jToken.AsObject();' + chrCR;
            retRoot += 'jObj.WriteTo(jTxt);' + chrCR;
            retRoot += 'end else message(' + QT + 'Error Json File' + QT + ');' + chrCR;

            retRoot += 'end else message(' + QT + 'Error Reading Json File' + QT + ');' + chrCR;
            retRoot += 'End;';

        end;
        retCode := 'codeunit 50003 "lala"' + ChrCR + '{' + chrCR + retVars + chrCR + retRoot + chrCR + retFunc + chrCR + '}';
    end;

    procedure SetComma(EntryNo: Integer; var inTxt: Text)
    begin
        if rjB1.get(EntryNo + 1) then begin
            if rjB1."Token type" in [rjB1."Token type"::"Property Name"] then Intxt += ',';
        end;
    end;
}
