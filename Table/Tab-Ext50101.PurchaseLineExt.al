tableextension 50101 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50100; "Requisition No."; Code[10])
        {
            Caption = 'Requisition No.';
            DataClassification = ToBeClassified;
            TableRelation = "Item Requisition Line" WHERE(Status = CONST(Released));
        }
    }
}
