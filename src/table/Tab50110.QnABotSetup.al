table 50110 "QnA Bot Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Entry; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; "Bot URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Bot URL';
        }
        field(3; "Knowledgebase ID"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Knowledgebase ID';
        }
        field(4; "EndpointKey"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Endpoint Key';
        }
    }

    keys
    {
        key(PK; Entry)
        {
            Clustered = true;
        }
    }
}