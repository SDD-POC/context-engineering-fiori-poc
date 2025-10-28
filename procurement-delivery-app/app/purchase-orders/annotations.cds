using CatalogService as service from '../../srv/catalog-service';

// UI Annotations for PurchaseOrder
// This entity allows updates, but only the DeliveryDate field is editable
// All other fields are read-only via Common.FieldControl

annotate service.PurchaseOrder with @(
  // Header information for Object Page
  UI.HeaderInfo: {
    TypeName: 'Purchase Order',
    TypeNamePlural: 'Purchase Orders',
    Title: { Value: PurchaseOrderNumber },
    Description: { Value: PurchasingDocument }
  },

  // List Report table columns
  UI.LineItem: [
    {
      Value: PurchaseOrderNumber,
      Label: 'PO Number',
      ![@UI.Importance]: #High
    },
    {
      Value: PurchasingDocument,
      Label: 'Purchasing Document',
      ![@UI.Importance]: #High
    },
    {
      Value: PurchasingDocumentItem,
      Label: 'Item',
      ![@UI.Importance]: #Medium
    },
    {
      Value: DeliveryDate,
      Label: 'Delivery Date',
      ![@UI.Importance]: #High
    },
    {
      Value: ContractNumber,
      Label: 'Contract Number',
      ![@UI.Importance]: #Medium
    }
  ],

  // Object Page facets (sections)
  UI.Facets: [
    {
      $Type: 'UI.ReferenceFacet',
      Label: 'Order Details',
      Target: '@UI.FieldGroup#OrderInfo'
    },
    {
      $Type: 'UI.ReferenceFacet',
      Label: 'Delivery Information',
      Target: '@UI.FieldGroup#DeliveryInfo'
    }
  ],

  // Field group for order information
  UI.FieldGroup #OrderInfo: {
    Data: [
      {
        Value: PurchaseOrderNumber,
        Label: 'PO Number'
      },
      {
        Value: PurchasingDocument,
        Label: 'Purchasing Document'
      },
      {
        Value: PurchasingDocumentItem,
        Label: 'Document Item'
      },
      {
        Value: ContractNumber,
        Label: 'Contract Number'
      }
    ]
  },

  // Field group for delivery information (editable field)
  UI.FieldGroup #DeliveryInfo: {
    Data: [
      {
        Value: DeliveryDate,
        Label: 'Delivery Date'
      }
    ]
  }
);

// CRITICAL: Field-level annotations for read-only control
// All fields except DeliveryDate are marked as read-only using Common.FieldControl
// This ensures that in edit mode, only the DeliveryDate field is editable
annotate service.PurchaseOrder with {
  PurchaseOrderNumber   @Common.FieldControl: #ReadOnly  @title: 'PO Number';
  PurchasingDocument    @Common.FieldControl: #ReadOnly  @title: 'Purchasing Document';
  PurchasingDocumentItem @Common.FieldControl: #ReadOnly  @title: 'Document Item';
  ContractNumber        @Common.FieldControl: #ReadOnly  @title: 'Contract Number';
  // DeliveryDate - NO FieldControl annotation = editable (default)
  DeliveryDate          @title: 'Delivery Date';
}
