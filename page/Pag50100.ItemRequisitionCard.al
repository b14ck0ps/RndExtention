page 50100 "Item Requisition Card"
{
    ApplicationArea = All;
    Caption = 'Item Requisition Card';
    PageType = Card;
    SourceTable = "Item Requisition";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = IsSalesLinesEditable;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    MultiLine = true;
                    Editable = IsSalesLinesEditable;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ShowMandatory = true;
                    Editable = IsSalesLinesEditable;
                }

                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                    ShowMandatory = true;
                    Editable = IsSalesLinesEditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ShowMandatory = true;
                    Editable = IsSalesLinesEditable;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    Editable = IsSalesLinesEditable;

                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            part(ItemReqLine; "Item Requisition Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = IsSalesLinesEditable;
                Enabled = IsSalesLinesEditable;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Action1)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        RecRef: Record "Item Requisition";
                    begin
                        RecRef.Get(Rec."No.");
                        RecRef.Status := RecRef.Status::Released;
                        RecRef.Modify(true);
                    end;


                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction()
                    var
                        RecRef: Record "Item Requisition";
                    begin
                        RecRef.Get(Rec."No.");
                        RecRef.Status := RecRef.Status::Open;
                        RecRef.Modify(true);
                        IsSalesLinesEditable := true;
                    end;
                }
            }
        }

    }

    var
        IsSalesLinesEditable: Boolean;

    trigger OnInit()
    begin
        IsSalesLinesEditable := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if (Rec.Status <> Rec.Status::Open) then
            IsSalesLinesEditable := false;
    end;

}

