using { procurement.delivery as db } from '../db/schema';

// CatalogService - OData V4 service exposing procurement entities
// This service provides controlled access to PurchaseContract and PurchaseOrder data
service CatalogService {

  // PurchaseContract - Completely read-only entity
  // Users can only view contract data, no create/update/delete operations allowed
  @readonly
  entity PurchaseContract as projection on db.PurchaseContract;

  // PurchaseOrder - Update-only entity
  // Users can update existing orders (specifically delivery dates) but cannot create or delete
  @Capabilities.InsertRestrictions.Insertable: false
  @Capabilities.DeleteRestrictions.Deletable: false
  @Capabilities.UpdateRestrictions.Updatable: true
  entity PurchaseOrder as projection on db.PurchaseOrder;
}
