table 50101 "Item Requisition Line"
{
    Caption = 'Item Requisition Line';
    DataClassification = EndUserIdentifiableInformation;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item Type"; Enum "Req. Item Type")
        {
            Caption = 'Item Type';
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = IF ("Item Type" = CONST(" ")) "Standard Text"
            ELSE
            IF ("Item Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Item Type" = const(Item)) Item;

            trigger OnValidate()
            var
                Item: Record Item;
                ItemRequtition: Record "Item Requisition";
            begin
                if Item.Get("Item No.") then
                    Rec."Item Description" := Item.Description
                else
                    Rec."Item Description" := '';

                Rec."Unit Of Measure" := Item."Base Unit of Measure";
                ItemRequtition.Get(Rec."Document No.");
                Rec.Date := ItemRequtition.Date;
            end;
        }
        field(5; "Item Description"; Text[50])
        {
            Caption = 'Item Description';
        }
        field(6; "Request Quantity"; Decimal)
        {
            Caption = 'Request Quantity';
        }
        field(7; "Available Quantity (Inventory)"; Decimal)
        {
            Caption = 'Available Quantity (Inventory)';
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No.")));
            Editable = false;
        }
        field(8; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
        }
        field(9; "Issued Quantity"; Decimal)
        {
            Caption = 'Issued Quantity';
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Open","Released","Pending Approval";

        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(13; "Delivery Status"; Option)
        {
            Caption = 'Delivery Status';
            OptionMembers = " ","Processing","Delivered";
        }
        field(14; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Unit Of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}