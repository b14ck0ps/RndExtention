tableextension 50101 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50100; "Requisition No."; Code[10])
        {
            Caption = 'Requisition No.';
            DataClassification = ToBeClassified;
            TableRelation = "Item Requisition Line"."Document No.";
            ValidateTableRelation = true;

            trigger OnLookup()
            var
                ItemRequisitionLine: Record "Item Requisition Line";
                ItemrequisitionLookUp: Page "Item Requisition Look Up";
            begin
                ItemRequisitionLine.SetRange(Status, ItemRequisitionLine.Status::Released);
                ItemRequisitionLine.SetRange("Delivery Status", ItemRequisitionLine."Delivery Status"::" ");
                ItemrequisitionLookUp.SetTableView(ItemRequisitionLine);
                ItemrequisitionLookUp.LookupMode := true;

                if ItemrequisitionLookUp.RunModal() = Action::LookupOK then begin
                    ItemrequisitionLookUp.GetRecord(ItemRequisitionLine);
                    Rec."Type" := ItemRequisitionLine."Item Type";
                    Rec.Validate("No.", ItemRequisitionLine."Item No.");
                    Rec.Validate(Quantity, ItemRequisitionLine."Request Quantity");
                    Rec."Requisition No." := ItemRequisitionLine."Document No.";
                    ItemRequisitionLine."Purchase Order No." := Rec."Document No.";
                    ItemRequisitionLine."Delivery Status" := ItemRequisitionLine."Delivery Status"::Processing;
                    Rec."Requsition Item Line No" := ItemRequisitionLine."Line No.";
                    ItemRequisitionLine.Modify(true);
                end;
            end;
        }
        field(50101; "Requsition Item Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    trigger OnDelete()
    var
        ItemRequisitionLine: Record "Item Requisition Line";
    begin
        ItemRequisitionLine.Get(Rec."Requisition No.", Rec."Requsition Item Line No");
        ItemRequisitionLine."Delivery Status" := ItemRequisitionLine."Delivery Status"::" ";
        ItemRequisitionLine.Modify(true);
    end;

    var
        ItemRequisitionLine: Record "Item Requisition Line";
}
