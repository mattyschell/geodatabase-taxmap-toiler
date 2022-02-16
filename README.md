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
> set SDEFILE=X:\yyy\zzz.sde
> set PYTHONPATH=C:\xxx\geodatabase-taxmap-toiler\src\py;C:\xxx\geodatabase-toiler\src\py;%PYTHONPATH%
> sample_import.bat 
```

## Schema Inventory

* DOF_EDITOR
* DOF_TAXMAP (see Data Inventory)
* JTX (full schema)
    * Does this need to be brought or can it be created new?
    * What about jtx_% tables in DOF_TAXMAP?


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
        Polygon_Face_Relationship
    * Topology
        * Possession_Hook_Topology
        * Tax_Lot_Topology

### Tables: Editable

* AIR_LABEL
* Air_Rights_Condos
* Air_Rights_Holders
* Air_Rights_Lots
* Condo
* Condo_Units
* CONDO_LABEL
* Conversion_Exceptions
* Conversion_Log (empty)
* DAB_ACTION_DEFINITION
* DAB_AIR_RIGHTS
* DAB_AIR_RIGHTS_DEFINITION
* DAB_BOUNDARY_LINE
* DAB_CONDO_CONVERSION
* DAB_CONDO_UNITS
* DAB_DOMAINS
* DAB_REUC
* DAB_SUBTERRANEAN_RIGHTS
* DAB_TAX_LOTS
* DAB_WIZARD_TRANSACTION
* DTM_USER_MAINT
* DTM_WORK_IN_PROGRESS
* FINAL_ASMT
* GWC_CUSTOM
* HAB
* MAP_INSET_LIBRARY
* MAP_LIBRARY
* REUC_Lots
* SUB_LABEL
* Subterranean_Lots

### Relationship Classes

* Air_Rights_Lots_Holders_Relationship
* Condo_Air_Rights_Relationship
* Condo_Condo_Unit_Relationship
* Tax_Lot_Air_Rights_Holders_Relationship
* Tax_Lot_Air_Rights_Relationship
* Tax_Lot_REUC_Relationship
* Tax_Lot_Subterranean_Relationship

### Spatial Data: Reference 

* "DCP" feature dataset
    * Boro_Boundary
    * Community_Districts
    * Non_Tax_Block_polygon
    * Non_Tax_Lot_Polygon
    * Shoreline_Polygon
* BOROUGH_POINT
* BUILDING
* CSCL_CENTERLINE
* HYDRO
* HYDRO_SDE (duplicate?)
* LAND
* LION_SUBSET_SDE
* OPEN_SPACE_SDE
* SHORELINE
* TRANSPORTATION_LINE_SDE
* TRANSPORTATION_STRUCTURE


## ESRI Workflow Manager

Workflow manager data is spread across both schemas,
every table duplicated with some data in each schema.

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


