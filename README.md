# geodatabase-taxmap-toiler

The New York City Department of Finance Digital Tax Map is a system of editing and publishing components that is the tax map of record.  The Department of Finance has historically used customized ArcGIS Desktop Software, aka "The Wizards," to edit an ESRI Enterprise Geodatabase hosted at the NYC Office of Technology and Innovation (formerly DoITT).

![wizards](wizards.png)

The goal of this repository is to help migrate the database components supporting Department of Finance editing from a legacy 10.2 ESRI User-Schema Enterprise Geodatabase on Oracle 11g to a supported ESRI Enterprise Geodatabase on Oracle 19c.  We will pay no mind to requirements like publishing to the web application or NYC Open Data.

The code is mostly opinionated wrappers to [geodatabase-toiler](https://github.com/mattyschell/geodatabase-toiler).  Friends, this our taxmap toiling in an ESRI Enterprise Geodatabase, our rules, the trick is never to be afraid.


# Tests

Basic stuff here. Requires a scratch Oracle database schema.

```bat
> set SDEFILE=X:\yyy\zzz.sde
> set PYTHONPATH=X:\geodatabase-toiler\src\py;%PYTHONPATH%
> testall.bat
```

# Migrate DOF_TAXMAP 

The sample will delete everything on the destination, then import all. Edit the sample and rename it for any migration.

Edit the inventories under src/resources.  

* Cadastral
* featureclasses
* tables

```bat
> sample_import.bat 
```

## Schema Inventory

* DOF_EDITOR
    * Will be empty unless ESRI writes out keyset and log tables
* DOF_TAXMAP 
    * See Data Inventory below
* JTX_ADMIN 
    * 5 GB, migration TBD

## Role Inventory

* DOF_TAXMAP_EDITOR
* TAXMAP_VIEWER

## Versions

* DEFAULT
    * DOF_PRODUCTION
        * DOF_EDITOR.*

## Data Inventory

Mixed case ESRI feature classes exist where indicated.

### Spatial Data: Editable

* "Cadastral" feature dataset
    * Boundary
    * Lot_Face_Possession_Hooks
    * Misc_Text
    * Possession_Hooks
    * Tax_Block_Polygon
    * Tax_Lot_Centroid
    * Tax_Lot_Face
    * Tax_Lot_Polygon
    * Relationship Classes
        * Polygon_Face_Relationship
    * Topology
        * Possession_Hook_Topology
        * Tax_Lot_Topology

### Tables: Editable

Some of these tables store Portable Document Formatted maps as Binary Large Objects and are large.  To keep the migration process simple we migrate them with arcpy but this is not ideal. 

1. AIR_LABEL
2. Air_Rights_Condos
3. Air_Rights_Holders
4. Air_Rights_Lots
5. Condo
6. Condo_Units
7. CONDO_LABEL
8. Conversion_Exceptions
9. Conversion_Log (empty)
10. DAB_ACTION_DEFINITION
11. DAB_AIR_RIGHTS
12. DAB_AIR_RIGHTS_DEFINITION
13. DAB_BOUNDARY_LINE
14. DAB_CONDO_CONVERSION
15. DAB_CONDO_UNITS
16. DAB_DOMAINS
17. DAB_REUC
18. DAB_SUBTERRANEAN_RIGHTS
19. DAB_TAX_LOTS
20. DAB_WIZARD_TRANSACTION
21. DTM_USER_MAINT
22. DTM_WORK_IN_PROGRESS
23. FINAL_ASMT
24. GWC_CUSTOM
25. HAB
26. MAP_INSET_LIBRARY
27. MAP_LIBRARY
28. REUC_Lots
29. SUB_LABEL
30. Subterranean_Lots

### Views

The editing wizards use no views.  

Use caution if examining views on the source environments.  One view (condo_unit) is so poorly defined that previewing it in ESRI software will fire off automated database alerts!

### Relationship Classes

One relationship class lives under the Cadastral feature dataset, so we should see 12 total. See above.

Relationship classes listed in resources\relationshipclasses will be deleted (11 listed, the other goes with Cadastral deletion).  Creation requires individual calls in sample_import.bat to createrelationshipclass.py.  Not great I know.

1. Air_Rights_Lots_Holders_Relationship
2. Condo_Air_Rights_Relationship
3. Condo_Condo_Unit_Relationship
4. Tax_Lot_Air_Rights_Holders_Relationship
5. Tax_Lot_Air_Rights_Relationship
6. Tax_Lot_Condo_Relationship
7. Tax_Lot_Condo_Unit_Relationship
8. Tax_Lot_Conversion_Exceptions_Relationship
9. Tax_Lot_Conversion_Log_Relationship
10. Tax_Lot_REUC_Relationship
11. Tax_Lot_Subterranean_Relationship

### Spatial Data: Reference 

1. "DCP" feature dataset
    * Boro_Boundary
    * Community_Districts
    * Non_Tax_Block_polygon
    * Non_Tax_Lot_Polygon
    * Shoreline_Polygon
2. BOROUGH_POINT
3. BUILDING
4. CSCL_CENTERLINE
5. HYDRO
6. HYDRO_SDE (duplicate?)
7. LAND
8. LION_SUBSET_SDE
9. OPEN_SPACE_SDE
10. SHORELINE
11. TRANSPORTATION_LINE_SDE
12. TRANSPORTATION_STRUCTURE


## ESRI Workflow Manager

Workflow manager data is in the JTX schema.

* JTX_ACTIVITY_TYPES
* JTX_AUX_PROPS
* JTX_CONN_INFO
* JTX_DATABASES
* JTX_DATABASE_SCHEMA
* JTX_DELETED_OBJECTS
* JTX_HISTORY
* JTX_HISTORY_DATASETS
* JTX_HISTORY_SESSIONS
* JTX_HOLD_TYPES
* JTX_JOBS
* JTX_JOBS_AOI - spatial
* JTX_ADMIN.JTX_JOBS_AOI - spatial
* JTX_JOBS_DB
* JTX_JOBS_POI
* JTX_JOB_ATTACHMENTS
* JTX_JOB_BLOB
* JTX_JOB_DATA
* JTX_JOB_DEPENDENCIES
* JTX_JOB_FILTERS
* JTX_JOB_FILTER_XREF
* JTX_JOB_HOLDS
* JTX_JOB_QUERIES
* JTX_JOB_STEP
* JTX_JOB_STEP_XREF
* JTX_JOB_TYPES
* JTX_JOB_TYPE_BLOB
* JTX_JOB_TYPE_MAP_DOC
* JTX_JOB_TYPE_PROPERTIES
* JTX_JOB_TYPE_REL_CLASSES
* JTX_JOB_TYPE_STEP
* JTX_JOB_TYPE_STEP_XREF
* JTX_LAYERS
* JTX_LOGIN_INFO
* JTX_MAP_STORE
* JTX_NOTIFICATIONS
* JTX_NOTIFICATION_SUBSCRIBERS
* JTX_OBJECT_PERMISSIONS
* JTX_PRIORITY
* JTX_PRIVILEGES
* JTX_PRIV_XREF
* JTX_PROPERTIES
* JTX_PROP_RELATIONSHIPS
* JTX_QUERY_CONTAINERS
* JTX_QUERY_OWNERS
* JTX_REPLICATION_INFO
* JTX_REPORTS
* JTX_REPORT_QUERIES
* JTX_REV_SESSION_XREF
* JTX_SPAT_NOTIF_LAYERS
* JTX_SPAT_NOTIF_MATCHES
* JTX_SPAT_NOTIF_RULES
* JTX_SPAT_NOTIF_RULE_CONDITION
* JTX_STATUS
* JTX_STATUS_HIST
* JTX_STEP_COMMENTS
* JTX_STEP_STATUS
* JTX_STEP_TYPE
* JTX_TASK_ASSISTANT_WORKFLOWS
* JTX_TOKEN_PARSERS
* JTX_TRANSACTIONS
* JTX_TRANSACTIONS_TEMP
* JTX_TRANSACTION_SESSIONS
* JTX_USERS
* JTX_USER_GROUPS
* JTX_USER_GROUP_JOB_FILTERS
* JTX_USER_GROUP_XREF
* JTX_WORKFLOW_STORE


