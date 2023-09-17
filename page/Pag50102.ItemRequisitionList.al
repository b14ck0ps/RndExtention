page 50102 "Item Requisition List"
{
    ApplicationArea = All;
    Caption = 'Item Requisition List';
    PageType = List;
    SourceTable = "Item Requisition";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Item Requisition Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Description; Rec.Description)
                {

                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
