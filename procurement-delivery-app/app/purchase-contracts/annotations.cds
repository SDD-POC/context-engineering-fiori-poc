using CatalogService as service from '../../srv/catalog-service';

// UI Annotations for PurchaseContract
// This entity is read-only and displays contract information in a List Report and Object Page

annotate service.PurchaseContract with @(
  // Header information for Object Page
  UI.HeaderInfo: {
    TypeName: 'Purchase Contract',
    TypeNamePlural: 'Purchase Contracts',
    Title: { Value: ContractNumber }
  },

  // List Report table columns
  UI.LineItem: [
    {
      Value: ContractNumber,
      Label: 'Contract Number',
      ![@UI.Importance]: #High
    },
    {
      Value: BlockNumber,
      Label: 'Block Number',
      ![@UI.Importance]: #Medium
    },
    {
      Value: DecadeCode,
      Label: 'Decade Code',
      ![@UI.Importance]: #Medium
    }
  ],

  // Object Page facets (sections)
  UI.Facets: [
    {
      $Type: 'UI.ReferenceFacet',
      Label: 'Contract Details',
      Target: '@UI.FieldGroup#ContractInfo'
    }
  ],

  // Field group for Object Page content
  UI.FieldGroup #ContractInfo: {
    Data: [
      {
        Value: ContractNumber,
        Label: 'Contract Number'
      },
      {
        Value: BlockNumber,
        Label: 'Block Number'
      },
      {
        Value: DecadeCode,
        Label: 'Decade Code'
      }
    ]
  }
);

// Field-level annotations for better UX
annotate service.PurchaseContract with {
  ContractNumber @title: 'Contract Number';
  BlockNumber    @title: 'Block Number';
  DecadeCode     @title: 'Decade Code';
}
