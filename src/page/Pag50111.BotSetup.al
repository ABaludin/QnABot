page 50111 "Bot Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Demo 3 QnA Bot Setup';
    SourceTable = "QnA Bot Setup";
    DataCaptionExpression = '';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Bot URL"; "Bot URL")
                {
                    ApplicationArea = All;

                }
                field("Knowledgebase ID"; "Knowledgebase ID")
                {
                    ApplicationArea = All;
                }
                field(EndpointKey; EndpointKey)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}