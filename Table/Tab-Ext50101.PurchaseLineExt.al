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

    trigger OnInsert()
    var
        ItemRequisitionLine: Record "Item Requisition Line";
    begin
        ItemRequisitionLine.Get(Rec."Requisition No.", Rec."Line No.");
        ItemRequisitionLine."Purchase Order No." := Rec."Document No.";
        ItemRequisitionLine.Modify(true);

        // TODO : Change Delivery Status to "Processing"
    end;
}
