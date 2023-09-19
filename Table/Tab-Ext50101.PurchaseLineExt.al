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
                ItemrequisitionSubform: Page "Item Requisition Subform";
            begin
                ItemRequisitionLine.SetRange(Status, ItemRequisitionLine.Status::Released);
                ItemrequisitionSubform.SetTableView(ItemRequisitionLine);
                ItemrequisitionSubform.LookupMode := true;
                if Action::LookupOK = ItemrequisitionSubform.RunModal() then begin
                    Rec."Requisition No." := ItemRequisitionLine."Document No.";
                    Rec."Type" := ItemRequisitionLine."Item Type";
                    Rec.Validate("No.", ItemRequisitionLine."Item No.");
                    Rec.Validate(Quantity, ItemRequisitionLine."Request Quantity");
                end;
            end;
            // trigger OnValidate()
            // begin
            //     begin
            //         ItemRequisitionLine.Get(Rec."Requisition No.", Rec."Line No.");
            //         Rec.Type := ItemRequisitionLine."Item Type";
            //     end;
            // end;
        }
    }

    trigger OnInsert()

    begin
        ItemRequisitionLine.Get(Rec."Requisition No.", Rec."Line No.");
        ItemRequisitionLine."Purchase Order No." := Rec."Document No.";
        ItemRequisitionLine.Modify(true);

        // TODO : Change Delivery Status to "Processing"
    end;

    var
        ItemRequisitionLine: Record "Item Requisition Line";
}
