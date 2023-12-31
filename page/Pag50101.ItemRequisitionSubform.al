page 50101 "Item Requisition Subform"
{
    ApplicationArea = All;
    Caption = 'Item Requisition Subform';
    PageType = ListPart;
    SourceTable = "Item Requisition Line";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'Specifies the value of the Item Type field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Request Quantity"; Rec."Request Quantity")
                {
                    ToolTip = 'Specifies the value of the Request Quantity field.';
                }
                field("Available Quantity (Inventory)"; Rec."Available Quantity (Inventory)")
                {
                    ToolTip = 'Specifies the value of the Available Quantity (Inventory) field.';
                }
                field("Delivery Status"; Rec."Delivery Status")
                {
                    ToolTip = 'Specifies the value of the Delivery Status field.';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    Editable = false;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
            }
        }
    }
}
