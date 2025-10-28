namespace procurement.delivery;

// PurchaseContract - Read-only entity for contract master data
// This entity stores contract information and is exposed as read-only
entity PurchaseContract {
  key ContractNumber : String(10);  // Unique contract identifier
  BlockNumber        : String(5);   // Contract block reference
  DecadeCode         : String(3);   // Decade classification code
}

// PurchaseOrder - Update-only entity for delivery date management
// This entity allows users to update delivery dates while keeping other fields read-only
entity PurchaseOrder {
  key PurchaseOrderNumber   : String(10);  // Unique PO identifier
  PurchasingDocument        : String(10);  // SAP purchasing document number
  PurchasingDocumentItem    : String(5);   // Line item number
  DeliveryDate              : Date;        // Target delivery date (EDITABLE FIELD)
  ContractNumber            : String(10);  // Foreign key to PurchaseContract

  // Managed association - CAP auto-generates FK relationship
  // This allows navigation from PurchaseOrder to related PurchaseContract
  contract                  : Association to PurchaseContract
                               on contract.ContractNumber = ContractNumber;
}
