# Procurement Delivery Date Change Fiori App

A SAP CAP (Cloud Application Programming Model) based Fiori Elements application for managing procurement delivery dates with controlled access to Purchase Contracts and Purchase Orders.

## Overview

This application enables procurement teams to efficiently update delivery dates for purchase orders while maintaining data integrity through field-level access controls. The app provides:

- **Read-only access** to Purchase Contracts
- **Controlled update access** to Purchase Orders (only the Delivery Date field is editable)
- **Association navigation** from Purchase Orders to related Purchase Contracts

## Entities

### PurchaseContract (Read-Only)
Contract master data entity with the following fields:
- **ContractNumber** (String, 10) - Unique contract identifier (Key)
- **BlockNumber** (String, 5) - Contract block reference
- **DecadeCode** (String, 3) - Decade classification code

**Access**: Read-only (no create, update, or delete operations)

### PurchaseOrder (Update-Only)
Purchase order entity for delivery date management:
- **PurchaseOrderNumber** (String, 10) - Unique PO identifier (Key)
- **PurchasingDocument** (String, 10) - SAP purchasing document number
- **PurchasingDocumentItem** (String, 5) - Line item number
- **DeliveryDate** (Date) - Target delivery date (**EDITABLE**)
- **ContractNumber** (String, 10) - Foreign key to PurchaseContract
- **contract** (Association) - Navigation to related PurchaseContract

**Access**: Update-only (no create or delete operations)
**Editable Field**: Only the DeliveryDate field can be modified; all other fields are read-only

## Project Structure

```
procurement-delivery-app/
├── db/                          # Database layer
│   ├── schema.cds              # Entity definitions with associations
│   └── data/                   # Initial test data (CSV files)
│       ├── procurement.delivery-PurchaseContract.csv
│       └── procurement.delivery-PurchaseOrder.csv
│
├── srv/                        # Service layer
│   └── catalog-service.cds    # OData V4 service with capability annotations
│
├── app/                        # UI layer
│   ├── purchase-contracts/    # PurchaseContract Fiori app
│   │   └── annotations.cds    # UI annotations for List Report & Object Page
│   │
│   └── purchase-orders/       # PurchaseOrder Fiori app
│       └── annotations.cds    # UI annotations with field control
│
├── gen/                        # Generated build artifacts
│   └── srv/                   # Compiled service with EDMX files
│
├── db.sqlite                   # Local SQLite database
├── package.json               # Node.js dependencies
└── README.md                  # This file
```

## Setup Instructions

### Prerequisites
- Node.js (v18 or higher recommended)
- npm (comes with Node.js)

### Installation

1. Install dependencies:
   ```bash
   npm install
   ```

2. Install development dependencies (if not already installed):
   ```bash
   npm install -D @sap/cds-dk sqlite3
   ```

3. Deploy the database:
   ```bash
   npx cds deploy --to sqlite
   ```

### Running the Application

Start the development server:
```bash
npx cds watch
```

The server will start on `http://localhost:4004` with the following endpoints:
- **Fiori Launchpad**: http://localhost:4004/fiori.html
- **OData Service**: http://localhost:4004/catalog
- **Service Metadata**: http://localhost:4004/catalog/$metadata

## Testing the Application

### Test URLs

1. **Fiori Launchpad**: http://localhost:4004/fiori.html
   - Access both Purchase Contracts and Purchase Orders apps

2. **OData Endpoints**:
   - Purchase Contracts: http://localhost:4004/catalog/PurchaseContract
   - Purchase Orders: http://localhost:4004/catalog/PurchaseOrder

### Manual Test Workflow

#### Testing Purchase Contracts (Read-Only)
1. Open the Fiori Launchpad
2. Navigate to "Purchase Contracts" app
3. Verify the list displays all contracts
4. Click on a contract to view details
5. **Confirm**: No Edit, Create, or Delete buttons are visible

#### Testing Purchase Orders (Update Delivery Date Only)
1. Open the Fiori Launchpad
2. Navigate to "Purchase Orders" app
3. Verify the list displays all orders
4. **Confirm**: No Create or Delete buttons are visible
5. Click on a purchase order to view details
6. Click the **Edit** button
7. **Verify**:
   - PurchaseOrderNumber field is greyed out (read-only)
   - PurchasingDocument field is greyed out (read-only)
   - PurchasingDocumentItem field is greyed out (read-only)
   - ContractNumber field is greyed out (read-only)
   - **DeliveryDate field is editable** (active input field)
8. Change the DeliveryDate value
9. Click **Save**
10. **Confirm**: Update succeeds and new date is displayed

## Delivery Date Change Workflow

### User Workflow
1. User navigates to Purchase Orders app
2. Searches/filters for the target purchase order
3. Opens the purchase order object page
4. Clicks Edit button
5. Updates the Delivery Date field
6. Saves the changes
7. System validates and persists the new delivery date

### Technical Implementation
- **Field Control**: Uses `@Common.FieldControl: #ReadOnly` annotations on all fields except DeliveryDate
- **Capability Restrictions**: Service-level annotations prevent create and delete operations
- **Data Validation**: Date field validation handled by Fiori Elements framework
- **Association**: Maintains link to related Purchase Contract for reference

## Build and Deployment

### Development Build
```bash
npx cds build
```

### Production Build
```bash
npx -p @sap/cds-dk cds build --production
```

### Deploy to SQLite (Local Development)
```bash
npx cds deploy --to sqlite
```

### Deploy to SAP HANA Cloud (Production)
```bash
npx cds deploy --to hana
```

## Technology Stack

- **SAP Cloud Application Programming Model (CAP)** - Full-stack framework
- **CDS (Core Data Services)** - Data modeling language
- **OData V4** - RESTful protocol for data services
- **SAP Fiori Elements** - Metadata-driven UI generation
- **Node.js** - Runtime environment
- **SQLite** - Local development database
- **Express** - Web server framework

## Key Features

### Field-Level Access Control
- Leverages `@Common.FieldControl` annotations for granular field-level security
- Only DeliveryDate field is editable; all other fields are read-only in edit mode
- Prevents accidental modification of critical order data

### Entity-Level Capability Restrictions
- `@readonly` annotation on PurchaseContract prevents all modifications
- `@Capabilities` annotations on PurchaseOrder allow only update operations
- No create or delete operations permitted on purchase orders

### Association Navigation
- Managed association from PurchaseOrder to PurchaseContract
- Enables users to view related contract information
- CAP automatically handles foreign key relationships

### Fiori Elements UI
- Automatically generated List Report and Object Page floorplans
- Responsive design following SAP Fiori guidelines
- Standard Fiori UX patterns (search, filter, sort)

## Development Commands

```bash
# Start development server with live reload
npx cds watch

# Compile CDS files
npx cds compile db/
npx cds compile srv/
npx cds compile app/

# Build project
npx cds build

# Deploy database
npx cds deploy --to sqlite

# Check CDS version
npx cds version

# Serve with specific port
npx cds serve --port 8080
```

## Troubleshooting

### Issue: Server won't start
**Solution**: Ensure all dependencies are installed: `npm install`

### Issue: Database not found
**Solution**: Run deployment: `npx cds deploy --to sqlite`

### Issue: UI doesn't show data
**Solution**:
1. Check that CSV files are in `db/data/` folder
2. Verify file naming: `{namespace}-{EntityName}.csv`
3. Redeploy database: `npx cds deploy --to sqlite`

### Issue: Edit button not showing on PurchaseOrder
**Solution**: Check `@Capabilities.UpdateRestrictions.Updatable: true` in service definition

### Issue: All fields are editable (not just DeliveryDate)
**Solution**: Verify `@Common.FieldControl: #ReadOnly` annotations on non-editable fields

## SAP Fiori Design Guidelines

This application follows SAP Fiori design guidelines:
- **List Report floorplan** for displaying entity collections
- **Object Page floorplan** for entity details
- **Standard action buttons** (Edit, Save, Cancel)
- **Field validation** and error handling
- **Responsive layout** for desktop and mobile

See: https://www.sap.com/design-system/digital/components/

## Learn More

- [SAP CAP Documentation](https://cap.cloud.sap/docs/)
- [CDS Language Reference](https://cap.cloud.sap/docs/cds/cdl)
- [Fiori Elements for OData V4](https://cap.cloud.sap/docs/advanced/fiori)
- [SAP Fiori Design Guidelines](https://experience.sap.com/fiori-design-web/)
- [OData Annotations](https://github.com/SAP/odata-vocabularies)

## License

This project is provided as-is for demonstration and development purposes.
