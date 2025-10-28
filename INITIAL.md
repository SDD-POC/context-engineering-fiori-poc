## FEATURE:

Design a procurement delivery date change SAPUI5-based application in new project with 2 data entities: PurchaseContractand PurchaseOrder.

• PurchaseContractentity should have:

• ContractNumber(string) - set as key field

• BlockNumber(string)

• DecadeCode(string)

• Annotations for PurchaseContract:

• Make this entity read-only (no create, update, or delete operations)

• PurchaseOrderentity should have:

• PurchaseOrderNumber(string) - set as key field

• PurchasingDocument(string)

• PurchasingDocumentItem(string)

• DeliveryDate(date)

• ContractNumber(string)

• Annotations for PurchaseOrder:

• Make this entity read-only for create and delete operations

• Allow update operation only

• Make only the DeliveryDatefield editable in update mode

• All other fields (PurchaseOrderNumber,PurchasingDocument,PurchasingDocumentItem,ContractNumber) should be read-only/display-only

• Association:

• Create an association from PurchaseOrderto PurchaseContractusing ContractNumberas the foreign key

• The association should allow users to navigate from a Purchase Order to its related Purchase Contract

• Display the ContractNumberfield in PurchaseOrderas read-only with associated PurchaseContractinformation

• UI Requirements:

• Generate a list page for PurchaseContract(read-only, display only)

• Generate a list page for PurchaseOrder(display only, no create or delete buttons)

• In the PurchaseOrderobject page, allow editing only the DeliveryDatefield

• Display all other PurchaseOrderfields and associated PurchaseContractinformation as read-only

## EXAMPLES:

## DOCUMENTATION:

[List out any documentation (web pages, sources for an MCP server like Crawl4AI RAG, etc.) that will need to be referenced during development]

[Overview – Components – SAP Digital Design System](https://www.sap.com/design-system/digital/components/)

## OTHER CONSIDERATIONS:

Make sure you understand the difference between generating a CAP based Fiori App and a standalone Fiori App.
