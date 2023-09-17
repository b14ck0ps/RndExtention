table 50100 "Item Requisition"
{
    Caption = 'Item Requisition';
    DataClassification = EndUserIdentifiableInformation;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Requested By"; Code[20])
        {
            TableRelation = Employee where(Status = filter(Active));
            Caption = 'Requested By';
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Released","Pending Approval";
        }
        field(7; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
