table 50100 "Item Requisition"
{
    Caption = 'Item Requisition';
    DataClassification = EndUserIdentifiableInformation;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchasesSetup.Get();
                    NoSeriesMgt.TestManual(PurchasesSetup."Requisition Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            var
                ItemRequisitionLine: Record "Item Requisition Line";
            begin
                ItemRequisitionLine.SetRange("Document No.", "No.");
                ItemRequisitionLine.FindFirst();
                repeat begin
                    ItemRequisitionLine.Date := Date;
                    ItemRequisitionLine.Modify();
                end until ItemRequisitionLine.Next() = 0;
            end;
        }
        field(3; "Requested By"; Code[20])
        {
            TableRelation = Employee where(Status = filter(Active));
            Caption = 'Requested By';
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Requested By") then begin
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
            end;
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

            trigger OnValidate()
            var
                ItemRequisitionLine: Record "Item Requisition Line";
            begin
                ItemRequisitionLine.SetRange("Document No.", "No.");
                ItemRequisitionLine.FindFirst();
                repeat begin
                    ItemRequisitionLine.Status := Status;
                    ItemRequisitionLine.Modify();
                end until ItemRequisitionLine.Next() = 0;
            end;
        }
        field(7; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[10])
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

    var
        PurchasesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
    begin
        if "No." = '' then begin
            PurchasesSetup.Get();
            PurchasesSetup.TestField("Requisition Nos");
            NoSeriesMgt.InitSeries(PurchasesSetup."Requisition Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date := WORKDATE;
    end;

    trigger OnDelete()
    var
        ItemRequisitionLine: Record "Item Requisition Line";
    begin
        ItemRequisitionLine.SetRange("Document No.", "No.");
        ItemRequisitionLine.DeleteAll();
    end;
}
