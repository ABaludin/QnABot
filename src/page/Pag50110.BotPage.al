page 50110 "QnA BotPage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Demo 3 QnA Bot Page';
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Question; Question)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        BotMgt: Codeunit "QnA BotMgt";
                    begin
                        Answer := BotMgt.SendQuestion(Question);
                        Question := '';
                        CurrPage.Update(false);
                    end;

                }

                field(Answer; Answer)
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }

    var
        Question: Text;
        Answer: Text;
}