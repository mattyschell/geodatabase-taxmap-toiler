REM executes from ArcGIS Pro conda environment
REM SDEFILE env to target test location must be set
set SDEFILE=XX:\gis\yyyyyyyyy\dev\zz-zzzzzz\dof_taxmap.sde
set PYTHONPATH=C:\gis\geodatabase-toiler\src\py;C:\gis\geodatabase-taxmap-toiler\src\py;%PYTHONPATH%
set SRCSDE=C:\xxx\Connections\oracle11g\yyy\zzz_zzzzzz.sde
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
CALL %PROPY% deletefeaturedataset.py Cadastral
CALL %PROPY% deleteall.py relationshipclasses
CALL %PROPY% deleteall.py featureclasses
CALL %PROPY% deleteall.py tables
CALL %PROPY% importfeaturedataset.py Cadastral %SRCSDE%
CALL %PROPY% importall.py featureclasses %SRCSDE%
CALL %PROPY% importall.py tables %SRCSDE%
CALL %PROPY% buildpossessionhooktopology.py Cadastral
CALL %PROPY% buildtaxlottopology.py Cadastral
CALL %PROPY% createrelationshipclass.py "Air_Rights_Lots" "Air_Rights_Holders" "Air_Rights_Lots_Holders_Relationship" SIMPLE "Air_Rights_Holders" "Air_Rights_Lots" NONE ONE_TO_MANY NONE AIR_RIGHTS_BBL AIR_RIGHTS_BBL  
CALL %PROPY% createrelationshipclass.py "Cadastral/Tax_Lot_Polygon" "Cadastral/Tax_Lot_Face" "Cadastral/Polygon_Face_Relationship" COMPOSITE "FINAL.Tax_Lot_Face" "FINAL.TAX_LOT_POLYGON" FORWARD ONE_TO_MANY NONE BBL BBL  
CALL %PROPY% createrelationshipclass.py "Condo" "Air_Rights_Condos" "Condo_Air_Rights_Relationship" SIMPLE "Air_Rights_Condos" "Condo" NONE ONE_TO_MANY NONE CONDO_BASE_BBL_KEY CONDO_BASE_BBL_KEY  
CALL %PROPY% createrelationshipclass.py "Condo" "Condo_Units" "Condo_Condo_Unit_Relationship" SIMPLE "Condo_Units" "Condo" NONE ONE_TO_MANY NONE CONDO_BASE_BBL_KEY CONDO_BASE_BBL_KEY  
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Air_Rights_Holders" "Tax_Lot_Air_Rights_Holders_Relationship" SIMPLE "Air_Rights_Holders" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL HOLDING_BBL
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Air_Rights_Lots" "Tax_Lot_Air_Rights_Relationship" SIMPLE "Air_Rights_Lots" "Tax_Lot_Polygon" NONE ONE_TO_ONE NONE BBL DONATING_BBL
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Condo" "Tax_Lot_Condo_Relationship" SIMPLE "Condo" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL CONDO_BASE_BBL  
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Condo_Units" "Tax_Lot_Condo_Unit_Relationship" SIMPLE "Condo_Units" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL CONDO_BASE_BBL
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Conversion_Exceptions" "Tax_Lot_Conversion_Exceptions_Relationship" SIMPLE "FINAL.Conversion_Exceptions" "FINAL.Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL BBL
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Conversion_Log" "Tax_Lot_Conversion_Log_Relationship" SIMPLE "Conversion_Log" "Tax_Lot_Polygon" NONE ONE_TO_ONE NONE BBL BBL
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "REUC_Lots" "Tax_Lot_REUC_Relationship" SIMPLE "REUC_Lots" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL APPURTENANT_BBL
CALL %PROPY% createrelationshipclass.py "Tax_Lot_Polygon" "Subterranean_Lots" "Tax_Lot_Subterranean_Relationship" SIMPLE "Subterranean_Lots" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL APPURTENANT_BBL
CALL %PROPY% versionall.py versionedtables
CALL %PROPY% versionall.py featuredatasets
CALL %PROPY% grantall.py tables view MAP_VIEWER 
CALL %PROPY% grantall.py featuredatasets view MAP_VIEWER 
CALL %PROPY% grantall.py tables view MAP_VIEWER 
REM DOF_TAXMAP_EDITOR role will not exist on POC database
REM CALL %PROPY% grantall.py featuredatasets edit DOF_TAXMAP_EDITOR
REM CALL %PROPY% grantall.py versionedtables edit DOF_TAXMAP_EDITOR
REM grant direct to the editor as a workaround 
CALL %PROPY% grantall.py featuredatasets edit DOF_EDITOR 
CALL %PROPY% grantall.py versionedtables edit DOF_EDITOR