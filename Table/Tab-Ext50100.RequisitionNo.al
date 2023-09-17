tableextension 50100 "Requisition No" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "Requisition Nos"; Code[10])
        {
            Caption = 'Requisition Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }
}