tableextension 50100 "Ext Purchases & Payables Setup" extends "Purchases & Payables Setup"
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