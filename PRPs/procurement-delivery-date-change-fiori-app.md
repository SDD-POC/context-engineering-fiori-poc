name: "Procurement Delivery Date Change Fiori App PRP"
description: |
  Complete implementation of a SAP CAP-based Fiori Elements application for managing procurement delivery dates with PurchaseContract and PurchaseOrder entities.

---

## Goal
Create a production-ready SAP CAP (Cloud Application Programming Model) based Fiori Elements application that allows users to:
- View Purchase Contracts (read-only)
- View and update Purchase Orders
- Edit only the DeliveryDate field on Purchase Orders
- Navigate from Purchase Orders to related Purchase Contracts via associations

This is a **CAP-based Fiori App**, not a standalone SAPUI5 app. CAP provides full-stack support with integrated backend (CDS models, OData V4 services) and frontend (Fiori Elements UI) in one project.

## Why
- **Business Value**: Enable procurement teams to efficiently manage and update delivery dates for purchase orders without risking changes to other critical fields
- **Integration**: Maintains association between Purchase Orders and Purchase Contracts for complete procurement visibility
- **Compliance**: Enforces read-only constraints on contract data and purchase order fields to maintain data integrity
- **User Impact**: Streamlines the delivery date change process with a modern, responsive Fiori UI following SAP design guidelines

## What
Build a complete SAP CAP project with:
- **Database Layer**: Two entities (PurchaseContract, PurchaseOrder) with proper associations
- **Service Layer**: OData V4 service exposing entities with capability restrictions
- **UI Layer**: Fiori Elements application with List Report and Object Page floorplans
- **Annotations**: Complete UI annotations for field control, read-only constraints, and navigation

### Success Criteria
- [ ] Project initializes successfully with proper CAP structure (db, srv, app folders)
- [ ] CDS schema defines both entities with correct key fields and associations
- [ ] PurchaseContract entity is completely read-only (no create, update, or delete)
- [ ] PurchaseOrder entity allows only update operations (no create or delete)
- [ ] Only DeliveryDate field is editable in PurchaseOrder edit mode
- [ ] Association from PurchaseOrder to PurchaseContract works correctly
- [ ] List pages display for both entities
- [ ] Object page for PurchaseOrder shows all fields with only DeliveryDate editable
- [ ] Application builds without errors: `cds build`
- [ ] Application runs successfully: `cds watch`
- [ ] UI renders correctly following SAP Fiori design guidelines

## All Needed Context

### Documentation & References

```yaml
# MUST READ - Critical documentation for implementation

# CAP Framework Documentation
- url: https://cap.cloud.sap/docs/about/
  why: |
    Core CAP concepts, architecture, and getting started guide.
    Understanding CAP's full-stack approach is critical for this project.

- url: https://cap.cloud.sap/docs/cds/cdl
  why: |
    Complete CDS (Core Data Services) language reference.
    Needed for defining entities, associations, and data types.

- url: https://cap.cloud.sap/docs/guides/domain-modeling
  why: |
    Domain modeling best practices in CAP.
    Covers associations, compositions, and managed vs unmanaged associations.

# Fiori Elements Integration
- url: https://cap.cloud.sap/docs/advanced/fiori
  why: |
    Official guide for serving Fiori UIs from CAP.
    Explains where to place annotations (./app/*/fiori-service.cds pattern).
    Critical for understanding annotation placement strategy.

- url: https://github.com/SAP-samples/fiori-elements-feature-showcase
  why: |
    Comprehensive sample app demonstrating Fiori Elements features with CAP CDS annotations.
    Reference for annotation patterns, List Report, and Object Page implementations.

- url: https://learning.sap.com/learning-journeys/developing-an-sap-fiori-elements-app-based-on-a-cap-odata-v4-service/getting-started-with-sap-fiori-elements-understanding-odata-and-annotations_e936f375-fc74-4ed6-9820-11d3020f424c
  why: |
    SAP Learning journey for Fiori Elements with CAP and OData V4.
    Step-by-step guidance aligned with latest practices.

# OData V4 Annotations
- url: https://github.com/SAP/odata-vocabularies/blob/main/vocabularies/Common.xml
  why: |
    Common vocabulary including FieldControl for read-only fields.
    FieldControl values: 0=Hidden, 1=ReadOnly, 3=Optional, 7=Mandatory

- url: https://github.com/SAP/odata-vocabularies/blob/main/vocabularies/UI.xml
  why: |
    UI vocabulary for annotations like LineItem, HeaderInfo, FieldGroup, Facets.
    Essential for defining List Report and Object Page layouts.

- url: https://github.com/oasis-tcs/odata-vocabularies/blob/main/vocabularies/Org.OData.Capabilities.V1.md
  why: |
    Capabilities vocabulary for UpdateRestrictions, InsertRestrictions, DeleteRestrictions.
    Controls CRUD operations at entity level.

# SAP Fiori Design Guidelines
- url: https://www.sap.com/design-system/digital/components/
  why: |
    Official SAP Fiori design guidelines.
    Must follow "Do" sections and avoid "Don't" sections per CLAUDE.md requirements.

- url: https://experience.sap.com/fiori-design-web/list-report-floorplan-sap-fiori-element/
  why: |
    List Report floorplan design specifications.
    Guidance on table layouts, filters, and navigation.

# CDS CLI and Build Commands
- url: https://cap.cloud.sap/docs/tools/cds-cli
  why: |
    Complete CDS CLI command reference.
    Commands: cds init, cds add, cds build, cds watch, cds deploy

- url: https://cap.cloud.sap/docs/guides/deployment/custom-builds
  why: |
    Build customization and production deployment guidance.
    Understanding gen/srv folder structure and build artifacts.
```

### Current Codebase Tree
```bash
context-engineering-fiori-poc/
├── .claude/                  # Claude Code configuration
│   ├── commands/            # Custom slash commands
│   └── settings.local.json  # Permissions
├── PRPs/                    # Project Requirements Prompts
│   └── templates/
├── examples/                # (empty - no existing patterns)
├── CLAUDE.md               # Project rules (MUST FOLLOW)
├── INITIAL.md              # Feature requirements
└── README.md               # Project documentation
```

### Desired Codebase Tree (Post-Implementation)
```bash
procurement-delivery-app/    # Root CAP project folder
├── .cdsrc.json             # CDS configuration
├── package.json            # Node.js dependencies (@sap/cds, express)
├── README.md               # Project documentation
│
├── db/                     # Database layer
│   ├── schema.cds          # Entity definitions
│   └── data/               # (Optional) Initial test data
│       ├── PurchaseContract.csv
│       └── PurchaseOrder.csv
│
├── srv/                    # Service layer
│   ├── catalog-service.cds # OData service definition with capability annotations
│   └── catalog-service.js  # (Optional) Custom business logic handlers
│
├── app/                    # UI layer
│   ├── purchase-contracts/ # PurchaseContract Fiori app
│   │   ├── annotations.cds # UI annotations for PurchaseContract
│   │   └── webapp/         # (Generated by Fiori tools)
│   │
│   └── purchase-orders/    # PurchaseOrder Fiori app
│       ├── annotations.cds # UI annotations for PurchaseOrder
│       └── webapp/         # (Generated by Fiori tools)
│
└── gen/                    # (Generated) Build artifacts
    └── srv/                # Compiled service with EDMX files
```

**File Responsibilities:**

- **db/schema.cds**: Defines PurchaseContract and PurchaseOrder entities with fields, keys, and associations
- **srv/catalog-service.cds**: Exposes entities as OData V4 service with Capabilities annotations for CRUD restrictions
- **app/purchase-contracts/annotations.cds**: UI.LineItem, UI.HeaderInfo annotations for PurchaseContract list/object pages
- **app/purchase-orders/annotations.cds**: UI annotations + Common.FieldControl for read-only fields except DeliveryDate
- **package.json**: Lists dependencies: @sap/cds (core framework), express (web server), sqlite3 (dev database)

### Known Gotchas & Library Quirks

```javascript
// CRITICAL: CAP and CDS Requirements

// 1. MANAGED ASSOCIATIONS - CAP automatically generates foreign key columns
// When you define: PurchaseOrder { ContractNumber: Association to PurchaseContract; }
// CAP creates: ContractNumber_ContractNumber (FK column) automatically
// DON'T manually create FK fields for managed associations

// 2. ANNOTATION PLACEMENT - Fiori annotations must be in app/ folder, NOT srv/
// CORRECT: app/purchase-orders/annotations.cds
// WRONG: srv/catalog-service.cds (service definition only, no UI annotations)
// Per CAP docs: "SAP recommends putting Fiori annotations in separate .cds files
// in ./app/* folders" - https://cap.cloud.sap/docs/advanced/fiori

// 3. FIELD CONTROL - Use Common.FieldControl, NOT UI.ReadOnly
// Common.FieldControl: #ReadOnly (value 1) - Standard approach
// Apply to all fields EXCEPT DeliveryDate in PurchaseOrder

// 4. UPDATE RESTRICTIONS - Use BOTH Capabilities AND UI annotations
// Capabilities.UpdateRestrictions { Updatable: false } - Controls OData operations
// UI.UpdateHidden: true - Hides Edit button in UI
// Use BOTH for complete read-only enforcement

// 5. CDS BUILD - Requires @sap/cds-dk package
// Must install: npm install -D @sap/cds-dk
// cds.build will be undefined without it
// Production build: npx -p @sap/cds-dk cds build --production

// 6. ENTITY KEYS - Use 'key' keyword, ensure unique identifier
// key ContractNumber: String; (correct)
// ContractNumber: String; (wrong - no primary key)

// 7. ASSOCIATIONS - Always specify cardinality for clarity
// to one: Association to PurchaseContract (1:1 relationship)
// to many: Association to many PurchaseOrders (1:N relationship)

// 8. NAMESPACE - Use consistent namespacing throughout CDS files
// namespace procurement.delivery; (in db/schema.cds)
// using { procurement.delivery as db } from '../db/schema'; (in srv/)

// 9. DATE TYPE - Use 'Date' not 'DateTime' for DeliveryDate
// Date: YYYY-MM-DD format (correct for delivery dates)
// DateTime: Full timestamp with time zone (overkill for delivery dates)

// 10. FIORI ELEMENTS REQUIRES ANNOTATIONS - Without UI annotations, pages are blank
// Minimum required: @UI.LineItem, @UI.HeaderInfo
// Object page: @UI.Facets, @UI.FieldGroup
```

## Implementation Blueprint

### Data Models and Structure

The core data model consists of two entities with a foreign key association:

```cds
// db/schema.cds
namespace procurement.delivery;

// PurchaseContract - Read-only entity for contract master data
entity PurchaseContract {
  key ContractNumber : String(10);  // Unique contract identifier
  BlockNumber        : String(5);   // Contract block reference
  DecadeCode         : String(3);   // Decade classification code
}

// PurchaseOrder - Update-only entity for delivery date management
entity PurchaseOrder {
  key PurchaseOrderNumber   : String(10);  // Unique PO identifier
  PurchasingDocument        : String(10);  // SAP purchasing document number
  PurchasingDocumentItem    : String(5);   // Line item number
  DeliveryDate              : Date;        // Target delivery date (EDITABLE)

  // Managed association - CAP auto-generates FK column
  contract                  : Association to PurchaseContract
                               on contract.ContractNumber = ContractNumber;
  ContractNumber            : String(10);  // Foreign key to PurchaseContract
}
```

**Key Design Decisions:**
- **Managed Association**: CAP handles FK relationship automatically
- **String Lengths**: Based on SAP standard field lengths (PO: 10 chars, Item: 5 chars)
- **Date vs DateTime**: Date type for delivery dates (no time component needed)
- **Naming**: Follow SAP conventions (PurchaseOrderNumber, PurchasingDocument)

### List of Tasks (In Order)

```yaml
Task 1: Initialize CAP Project
  ACTIONS:
    - Create new CAP project: cds init procurement-delivery-app
    - Navigate into project: cd procurement-delivery-app
    - Install dependencies: npm install
    - Verify structure: ls -la (should see db/, srv/, app/, package.json)

  VALIDATION:
    - package.json exists with @sap/cds dependency
    - db/, srv/, app/ folders created
    - cds version runs without error

Task 2: Define Database Schema
  CREATE db/schema.cds:
    - Define namespace: procurement.delivery
    - Create PurchaseContract entity with 3 fields (ContractNumber as key, BlockNumber, DecadeCode)
    - Create PurchaseOrder entity with 5 fields (PurchaseOrderNumber as key, PurchasingDocument,
      PurchasingDocumentItem, DeliveryDate, ContractNumber)
    - Define managed association from PurchaseOrder to PurchaseContract

  PATTERN TO FOLLOW:
    - Use 'key' keyword for primary keys
    - Use appropriate data types: String(length) for text, Date for dates
    - Association syntax: contract : Association to PurchaseContract on contract.ContractNumber = ContractNumber;

  VALIDATION:
    - Run: cds compile db/schema.cds (should compile without errors)
    - Check output for entity definitions and association

Task 3: Define OData Service with Capability Restrictions
  CREATE srv/catalog-service.cds:
    - Import db schema: using { procurement.delivery as db } from '../db/schema';
    - Define service: service CatalogService
    - Expose PurchaseContract as projection
    - Expose PurchaseOrder as projection
    - Annotate PurchaseContract with read-only capabilities
    - Annotate PurchaseOrder with update-only capabilities

  CRITICAL ANNOTATIONS:
    PurchaseContract:
      @readonly (shorthand for no create/update/delete)
      OR explicit:
      @Capabilities.InsertRestrictions.Insertable: false
      @Capabilities.UpdateRestrictions.Updatable: false
      @Capabilities.DeleteRestrictions.Deletable: false

    PurchaseOrder:
      @Capabilities.InsertRestrictions.Insertable: false
      @Capabilities.DeleteRestrictions.Deletable: false
      @Capabilities.UpdateRestrictions.Updatable: true

  VALIDATION:
    - Run: cds compile srv/catalog-service.cds
    - Check for service definition in output
    - Verify associations are preserved in projections

Task 4: Create Fiori App for PurchaseContract
  ACTIONS:
    - Run: cds add fiori
    - When prompted:
      * Choose template: "List Report Object Page"
      * Data source: "Use local CAP project"
      * OData service: "CatalogService"
      * Main entity: "PurchaseContract"
      * Module name: "purchase-contracts"
      * Application title: "Purchase Contracts"

  AUTO-GENERATED FILES:
    - app/purchase-contracts/webapp/ (Fiori app structure)
    - app/purchase-contracts/annotations.cds (empty, to be filled)

  VALIDATION:
    - Check app/purchase-contracts/ folder exists
    - Verify annotations.cds file created

Task 5: Add UI Annotations for PurchaseContract
  MODIFY app/purchase-contracts/annotations.cds:
    - Import service: using CatalogService as service from '../../srv/catalog-service';
    - Add @UI.HeaderInfo for object page title
    - Add @UI.LineItem for list report table columns
    - Add @UI.Facets and @UI.FieldGroup for object page layout

  PATTERN TO FOLLOW:
    annotate service.PurchaseContract with @(
      UI.HeaderInfo: {
        TypeName: 'Purchase Contract',
        TypeNamePlural: 'Purchase Contracts',
        Title: { Value: ContractNumber }
      },
      UI.LineItem: [
        { Value: ContractNumber, Label: 'Contract Number' },
        { Value: BlockNumber, Label: 'Block Number' },
        { Value: DecadeCode, Label: 'Decade Code' }
      ],
      UI.Facets: [
        {
          $Type: 'UI.ReferenceFacet',
          Label: 'Contract Details',
          Target: '@UI.FieldGroup#ContractInfo'
        }
      ],
      UI.FieldGroup #ContractInfo: {
        Data: [
          { Value: ContractNumber },
          { Value: BlockNumber },
          { Value: DecadeCode }
        ]
      }
    );

  VALIDATION:
    - Run: cds compile app/purchase-contracts/annotations.cds
    - No syntax errors should appear

Task 6: Create Fiori App for PurchaseOrder
  ACTIONS:
    - Run: cds add fiori
    - When prompted:
      * Choose template: "List Report Object Page"
      * Data source: "Use local CAP project"
      * OData service: "CatalogService"
      * Main entity: "PurchaseOrder"
      * Module name: "purchase-orders"
      * Application title: "Purchase Orders"

  AUTO-GENERATED FILES:
    - app/purchase-orders/webapp/
    - app/purchase-orders/annotations.cds

  VALIDATION:
    - Check app/purchase-orders/ folder exists

Task 7: Add UI Annotations for PurchaseOrder with Field Control
  MODIFY app/purchase-orders/annotations.cds:
    - Import service
    - Add @UI.HeaderInfo, @UI.LineItem, @UI.Facets, @UI.FieldGroup
    - CRITICAL: Add Common.FieldControl: #ReadOnly to ALL fields EXCEPT DeliveryDate
    - Add UI.UpdateHidden: false to ensure Edit button shows

  PATTERN TO FOLLOW:
    annotate service.PurchaseOrder with @(
      UI.HeaderInfo: {
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title: { Value: PurchaseOrderNumber }
      },
      UI.LineItem: [
        { Value: PurchaseOrderNumber, Label: 'PO Number' },
        { Value: PurchasingDocument, Label: 'Purchasing Document' },
        { Value: PurchasingDocumentItem, Label: 'Item' },
        { Value: DeliveryDate, Label: 'Delivery Date' },
        { Value: ContractNumber, Label: 'Contract Number' }
      ],
      UI.Facets: [
        {
          $Type: 'UI.ReferenceFacet',
          Label: 'Order Details',
          Target: '@UI.FieldGroup#OrderInfo'
        }
      ],
      UI.FieldGroup #OrderInfo: {
        Data: [
          { Value: PurchaseOrderNumber },
          { Value: PurchasingDocument },
          { Value: PurchasingDocumentItem },
          { Value: DeliveryDate },
          { Value: ContractNumber }
        ]
      }
    );

    // CRITICAL: Field-level annotations for read-only control
    annotate service.PurchaseOrder with {
      PurchaseOrderNumber   @Common.FieldControl: #ReadOnly;
      PurchasingDocument    @Common.FieldControl: #ReadOnly;
      PurchasingDocumentItem @Common.FieldControl: #ReadOnly;
      ContractNumber        @Common.FieldControl: #ReadOnly;
      // DeliveryDate - NO annotation = editable (default)
    };

  VALIDATION:
    - Run: cds compile app/purchase-orders/annotations.cds
    - Verify no syntax errors

Task 8: Add Sample Data (Optional but Recommended)
  CREATE db/data/procurement.delivery-PurchaseContract.csv:
    ContractNumber;BlockNumber;DecadeCode
    4500000001;BLK01;D20
    4500000002;BLK02;D21
    4500000003;BLK03;D20

  CREATE db/data/procurement.delivery-PurchaseOrder.csv:
    PurchaseOrderNumber;PurchasingDocument;PurchasingDocumentItem;DeliveryDate;ContractNumber
    4500100001;PD001;00010;2025-11-15;4500000001
    4500100002;PD002;00020;2025-11-20;4500000001
    4500100003;PD003;00010;2025-12-01;4500000002

  GOTCHA:
    - File naming MUST match: {namespace}-{EntityName}.csv
    - Semicolon (;) separated values
    - First row = column headers matching entity field names
    - Date format: YYYY-MM-DD

  VALIDATION:
    - Run: cds deploy --to sqlite
    - Check data loads without errors

Task 9: Build and Test Application
  ACTIONS:
    - Install dev dependencies: npm install -D @sap/cds-dk sqlite3
    - Build: cds build
    - Deploy to local SQLite: cds deploy --to sqlite
    - Start development server: cds watch

  EXPECTED OUTPUT:
    - Server starts on http://localhost:4004
    - Service endpoint: http://localhost:4004/catalog
    - Fiori preview: http://localhost:4004/fiori.html

  MANUAL TEST STEPS:
    1. Open http://localhost:4004/fiori.html in browser
    2. Navigate to "Purchase Contracts" app
       - Verify list displays contracts
       - Click on a contract - should show object page
       - Verify NO Edit button (read-only)
    3. Navigate to "Purchase Orders" app
       - Verify list displays orders
       - Click on an order - should show object page
       - Click Edit button
       - Verify ONLY DeliveryDate field is editable
       - Verify all other fields are display-only/greyed out
       - Change DeliveryDate and Save
       - Verify update succeeds

  VALIDATION:
    - No build errors
    - Server runs without crashes
    - Both Fiori apps render
    - Edit functionality works as specified

Task 10: Update Documentation
  MODIFY README.md:
    - Add project description
    - List entities and their purpose
    - Add setup instructions (npm install, cds watch)
    - Document test URLs
    - Explain delivery date change workflow

  CREATE TASK.md:
    - Add entry: "Create Procurement Delivery Date Change Fiori App - [Date]"
    - Mark as completed with checkmark

  VALIDATION:
    - README.md is clear and comprehensive
    - TASK.md updated per CLAUDE.md requirements
```

## Validation Loop

### Level 1: CDS Compilation
```bash
# Run these FIRST - ensure CDS syntax is valid

# Compile database schema
cds compile db/schema.cds

# Compile service definition
cds compile srv/catalog-service.cds

# Compile UI annotations
cds compile app/purchase-contracts/annotations.cds
cds compile app/purchase-orders/annotations.cds

# Expected: No errors, entities and services display in output
# If errors: READ the error message carefully, check syntax, field names, association definitions
```

### Level 2: Build and Deploy
```bash
# Install dependencies
npm install
npm install -D @sap/cds-dk sqlite3

# Build project
cds build
# Expected: gen/ folder created with compiled artifacts
# If errors: Check package.json for missing dependencies

# Deploy to local database
cds deploy --to sqlite
# Expected: SQLite database file created (sqlite.db)
# If errors: Check CSV file naming and data format

# Verify deployment
ls -la
# Should see: sqlite.db file in root directory
```

### Level 3: Runtime Validation
```bash
# Start development server
cds watch
# Expected output:
#   [cds] - server listening on { url: 'http://localhost:4004' }
#   [cds] - serving CatalogService { path: '/catalog' }
#   [cds] - launched into: http://localhost:4004

# In another terminal or browser, test endpoints:
curl http://localhost:4004/catalog/PurchaseContract
# Expected: JSON array of contracts

curl http://localhost:4004/catalog/PurchaseOrder
# Expected: JSON array of purchase orders with contract association

# Test metadata
curl http://localhost:4004/catalog/$metadata
# Expected: EDMX XML with entity definitions and annotations
```

### Level 4: UI Functional Testing (Manual)
```bash
# With cds watch running, open browser:
# Navigate to: http://localhost:4004/fiori.html

# Test PurchaseContract App:
1. Click "Purchase Contracts" tile
   - ✓ List page displays with columns: Contract Number, Block Number, Decade Code
   - ✓ Click on a contract row
   - ✓ Object page displays contract details
   - ✓ NO Edit button visible (read-only entity)
   - ✓ NO Create or Delete buttons in list page

# Test PurchaseOrder App:
2. Click "Purchase Orders" tile
   - ✓ List page displays with columns: PO Number, Purchasing Document, Item, Delivery Date, Contract Number
   - ✓ NO Create button (insert restricted)
   - ✓ NO Delete button (delete restricted)
   - ✓ Click on a purchase order row
   - ✓ Object page displays all fields
   - ✓ Edit button IS visible (update allowed)

3. Click Edit button on PurchaseOrder object page
   - ✓ Form enters edit mode
   - ✓ PurchaseOrderNumber field is greyed out/read-only
   - ✓ PurchasingDocument field is greyed out/read-only
   - ✓ PurchasingDocumentItem field is greyed out/read-only
   - ✓ ContractNumber field is greyed out/read-only
   - ✓ DeliveryDate field is EDITABLE (input field active)

4. Change DeliveryDate value
   - ✓ Select new date from date picker
   - ✓ Click Save button
   - ✓ Success message displays
   - ✓ Object page returns to display mode
   - ✓ New delivery date is saved and displayed

5. Test association navigation (if configured)
   - ✓ Contract Number field shows link/navigation
   - ✓ Click Contract Number
   - ✓ Navigates to related PurchaseContract object page

# If ANY test fails:
# - Check annotations.cds for missing or incorrect annotations
# - Check Common.FieldControl annotations (must be #ReadOnly for non-editable fields)
# - Check Capabilities annotations in service definition
# - Review browser console for errors
# - Check cds watch terminal for server errors
```

## Final Validation Checklist
- [ ] All CDS files compile: `cds compile db/ srv/ app/`
- [ ] Project builds: `cds build` completes without errors
- [ ] Database deploys: `cds deploy --to sqlite` succeeds
- [ ] Server starts: `cds watch` runs on port 4004
- [ ] Service responds: `curl http://localhost:4004/catalog/PurchaseOrder` returns data
- [ ] Fiori Launchpad loads: http://localhost:4004/fiori.html accessible
- [ ] PurchaseContract app is completely read-only (no Edit button)
- [ ] PurchaseOrder app allows Edit but only DeliveryDate is editable
- [ ] Association navigation from PurchaseOrder to PurchaseContract works
- [ ] README.md updated with setup and testing instructions
- [ ] TASK.md updated per CLAUDE.md requirements
- [ ] Code follows SAP Fiori design guidelines from https://www.sap.com/design-system/digital/components/
- [ ] All entity fields and comments are documented

---

## Anti-Patterns to Avoid

### CDS Anti-Patterns
- ❌ **Don't** manually create foreign key columns for managed associations (CAP does this automatically)
- ❌ **Don't** use `DateTime` when `Date` is sufficient (delivery dates don't need time component)
- ❌ **Don't** forget `key` keyword on primary key fields (entity won't work without it)
- ❌ **Don't** mix namespaces inconsistently across files
- ❌ **Don't** use unmanaged associations unless you have complex custom join logic

### Annotation Anti-Patterns
- ❌ **Don't** put UI annotations in srv/ folder (must be in app/ per CAP best practices)
- ❌ **Don't** use `UI.ReadOnly` annotation (use `Common.FieldControl: #ReadOnly` instead)
- ❌ **Don't** forget both Capabilities AND UI annotations for complete control
- ❌ **Don't** annotate DeliveryDate with FieldControl (leave it unannotated = editable)
- ❌ **Don't** use `@readonly` on PurchaseOrder (it needs update capability)

### Build Anti-Patterns
- ❌ **Don't** forget to install @sap/cds-dk (cds build will fail)
- ❌ **Don't** run `cds build` before `npm install` (dependencies must be installed first)
- ❌ **Don't** ignore compilation warnings (they often indicate real issues)
- ❌ **Don't** skip `cds deploy` step (database must be initialized)

### Testing Anti-Patterns
- ❌ **Don't** assume UI works without manual testing in browser
- ❌ **Don't** test only happy path (try to edit read-only fields to verify they're blocked)
- ❌ **Don't** skip association testing (verify navigation works)
- ❌ **Don't** forget to test with realistic data (CSV files help here)

### Code Quality Anti-Patterns
- ❌ **Don't** skip comments on entity fields (required per CLAUDE.md)
- ❌ **Don't** use abbreviations that aren't SAP standard (PO is OK, PDoc is not)
- ❌ **Don't** hardcode values that should be configuration
- ❌ **Don't** create files without updating documentation

---

## CAP vs Standalone Fiori - Critical Distinction

**This PRP is for a CAP-based application**, not a standalone SAPUI5 app. Understanding the difference is critical:

### CAP-Based Fiori App (THIS PROJECT):
- **Full-Stack**: Backend (CDS models, OData services) + Frontend (Fiori UI) in ONE project
- **Structure**: db/ (schema), srv/ (services), app/ (UI)
- **Data Modeling**: CDS language for entities and associations
- **OData**: Auto-generated from CDS definitions
- **Annotations**: In app/*/annotations.cds files
- **Benefits**:
  - 80% faster development (Fiori Elements generates UI)
  - Enterprise features built-in (auth, drafts, multitenancy)
  - Consistent patterns across full stack
  - Single deployment artifact

### Standalone SAPUI5 Fiori App (NOT THIS PROJECT):
- **Frontend Only**: Requires separately developed backend (ABAP, Java, etc.)
- **Structure**: Just webapp/ folder with controllers, views, models
- **Data Modeling**: Backend-specific (ABAP CDS, Java JPA, etc.)
- **OData**: Consumed from external service, not generated
- **Annotations**: May be in backend or local annotation files
- **Benefits**:
  - More control over UI implementation
  - Can connect to any OData service
  - May be required for complex custom UI logic

**For this project**: We use CAP because it provides the fastest path to a working Fiori app with proper backend, and the requirements (read-only contracts, editable delivery date field) are perfectly suited to Fiori Elements capabilities.

---

## PRP Quality Self-Assessment

**Confidence Score: 9/10**

**Strengths:**
- ✅ Complete, executable implementation path from zero to working app
- ✅ All necessary context provided (CAP docs, OData vocabularies, Fiori guidelines)
- ✅ Specific validation gates at each level (compile, build, runtime, UI)
- ✅ Real-world patterns from SAP feature showcase and learning journeys
- ✅ Comprehensive gotchas and anti-patterns documented
- ✅ Field-level granularity for read-only control (Common.FieldControl pattern)
- ✅ Clear distinction between CAP and standalone approaches
- ✅ Detailed file-by-file breakdown with exact content patterns
- ✅ CSV data samples for realistic testing
- ✅ Manual testing steps for UI validation

**Minor Gaps (reason for 9 vs 10):**
- ⚠️ No existing codebase patterns to reference (examples/ folder is empty)
- ⚠️ Assumes npm and Node.js are installed (may need installation steps)
- ⚠️ No specific version pinning for @sap/cds (should use latest, but could specify)
- ⚠️ Association navigation UI annotations not fully detailed (could expand Task 7)

**Mitigation:**
- All gaps are minor and don't block implementation
- CAP documentation links provide fallback for any missing patterns
- Node.js installation is standard prerequisite for CAP development
- Latest @sap/cds version is appropriate for new projects
- Basic association annotation is sufficient; advanced navigation can be added later

**Expected Outcome:**
With this PRP, an AI agent should be able to implement a fully functional procurement delivery date change Fiori app in a single pass, with all success criteria met, following proper CAP and Fiori Elements patterns.
