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
                    Editable = false;
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
                        ItemRequisition: Record "Item Requisition";
                    begin
                        ItemRequisition.Get(Rec."No.");
                        ItemRequisition.Validate(Status, Rec.Status::Released);
                        ItemRequisition.Modify(true);
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
                        ItemRequisition: Record "Item Requisition";
                    begin
                        ItemRequisition.Get(Rec."No.");
                        ItemRequisition.Validate(Status, Rec.Status::Open);
                        ItemRequisition.Modify(true);
                        IsSalesLinesEditable := true;
                    end;
                }

            }
            group(Functions)
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;
                    ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        ItemRequisition: Record "Item Requisition";
                    begin
                        ItemRequisition.Reset();
                        ItemRequisition.SetRange("No.", Rec."No.");
                        if ItemRequisition.FindFirst() then
                            Report.Run(Report::"Requisition Report", true, false, ItemRequisition);
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

