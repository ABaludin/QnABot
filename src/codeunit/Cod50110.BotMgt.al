codeunit 50110 "QnA BotMgt"
{
    procedure SendQuestion(Question: Text): Text
    var
        QnASetup: Record "QnA Bot Setup";
        Content: HttpContent;
        Headers: HttpHeaders;
        Client: HttpClient;
        URL: text;
        ResponseMessage: HttpResponseMessage;
        ResponseText: text;
        JsonObj: JsonObject;
        JsonTok: JsonToken;
        JsonArr: JsonArray;
    begin
        QnASetup.Get();

        JsonObj.Add('question', Question);
        JsonObj.WriteTo(Question);
        Content.WriteFrom(Question);

        Content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/json');

        Client.DefaultRequestHeaders().Add('Authorization', 'EndpointKey ' + QnASetup.EndpointKey);
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');
        URL := QnASetup."Bot URL" + '/qnamaker/knowledgebases/' + QnASetup."Knowledgebase ID" + '/generateAnswer';
        //URL := 'https://<app_service>.azurewebsites.net/qnamaker/knowledgebases/<knowledgebase_id>/generateAnswer';

        if not Client.Post(URL, Content, ResponseMessage)
        then
            Error('The call to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(ResponseText);

            error('The web service returned an error message:\' +
                  'Status code: %1' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode(),
                   ResponseText);
        end;

        ResponseMessage.Content().ReadAs(ResponseText);
        JsonTok.ReadFrom(ResponseText);

        JsonObj := JsonTok.AsObject();
        JsonObj.SelectToken('answers', JsonTok);
        Jsonarr := JsonTok.AsArray();
        JsonArr.Get(0, JsonTok);

        Exit(ReadAnswer(JsonTok));

    end;

    procedure ReadAnswer(JsonTok: JsonToken): Text;
    var
        JsonObj: JsonObject;
    begin
        JsonObj := JsonTok.AsObject();

        Exit(SelectJsonToken(JsonObj, '$.answer'));
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text): text;
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            exit('');
        if JsonToken.AsValue().IsNull() then
            exit('');
        exit(jsontoken.asvalue().astext());
    end;
}