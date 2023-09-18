report 50100 "Requisition Report"
{
    ApplicationArea = All;
    Caption = 'Requisition Report';
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './Report/layout/Requisition Report.docx';
    DefaultLayout = Word;
    dataset
    {
        dataitem(ItemRequisition; "Item Requisition")
        {
            column(No; "No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            dataitem(DimensionValue; "Dimension Value")
            {
                DataItemLink = "Code" = field("Global Dimension 1 Code");

                column(Name_DimensionValue; Name)
                {
                }
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Date; ReqDate)
            {
            }
            column(RequestedBy; "Requested By")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "No." = field("Requested By");
                column(Name_Employee; FullName())
                {
                }
            }
            column(Status; Status)
            {
            }
            dataitem("Item Requisition Line"; "Item Requisition Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemDescription_ItemRequisitionLine; "Item Description")
                {
                }

                column(ItemNo_ItemRequisitionLine;
                "Item No.")
                {
                }
                column(ItemType_ItemRequisitionLine; "Item Type")
                {
                }
                column(PurchaseOrderNo_ItemRequisitionLine; "Purchase Order No.")
                {
                }
                column(RequestQuantity_ItemRequisitionLine; "Request Quantity")
                {
                }
                column(Status_ItemRequisitionLine; Status)
                {
                }
                // dataitem(Item; Item)
                // {
                //     DataItemLink = "No." = field("Item No.");

                // }

            }
            trigger OnAfterGetRecord()
            begin
                ReqDate := Format(ItemRequisition.Date, 0, '<Standard Format,4>');
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        ReqDate: Text[20];
}
