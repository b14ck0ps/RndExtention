pageextension 50101 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
                ToolTip = 'Requisition No.';
            }
        }
    }
}
