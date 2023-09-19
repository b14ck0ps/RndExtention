page 50104 "Item Requisition Look Up"
{
    ApplicationArea = All;
    Caption = 'Item Requisition Subform';
    PageType = List;
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
            }
        }
    }
}
