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
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    MultiLine = true;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ShowMandatory = true;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';

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

    var
        IsSalesLinesEditable: Boolean;

    trigger OnInit()
    begin
        IsSalesLinesEditable := true;
    end;
}

