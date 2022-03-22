REM executes from ArcGIS Pro conda environment
REM SDEFILE env to target test location must be set
set SDEFILE=XX:\gis\yyyyyyyyy\dev\zz-zzzzzz\dof_taxmap.sde
set PYTHONPATH=C:\gis\geodatabase-toiler\src\py;C:\gis\geodatabase-taxmap-toiler\src\py;%PYTHONPATH%
set SRCSDE=C:\xxx\Connections\oracle11g\yyy\zzz_zzzzzz.sde
set TAXTOILREPO=C:\gis\geodatabase-taxmap-toiler\
set TOILER=C:\gis\geodatabase-toiler\
set PY27=C:\Python27\ArcGIS10.6\python.exe
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
CALL %PROPY% %TAXTOILREPO%deletefeaturedataset.py Cadastral
CALL %PROPY% %TAXTOILREPO%deletefeaturedataset.py DCP
CALL %PROPY% %TAXTOILREPO%deleteall.py relationshipclasses
CALL %PROPY% %TAXTOILREPO%deleteall.py featureclasses
CALL %PROPY% %TAXTOILREPO%deleteall.py tables
CALL %PROPY% %TAXTOILREPO%importfeaturedataset.py Cadastral %SRCSDE%
CALL %PROPY% %TAXTOILREPO%importfeaturedataset.py DCP %SRCSDE%
REM featureclasses are all reference data? ignore most for now
CALL %PROPY% %TAXTOILREPO%importall.py featureclasses %SRCSDE%
CALL %PROPY% %TAXTOILREPO%importall.py tables %SRCSDE%
CALL %PROPY% %TAXTOILREPO%buildpossessionhooktopology.py Cadastral
CALL %PROPY% %TAXTOILREPO%buildtaxlottopology.py Cadastral
CALL %PROPY% %TAXTOILREPO%decurvifyall.py Cadastral
CALL %PROPY% %TAXTOILREPO%decurvifyall.py DCP
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Air_Rights_Lots" "Air_Rights_Holders" "Air_Rights_Lots_Holders_Relationship" SIMPLE "Air_Rights_Holders" "Air_Rights_Lots" NONE ONE_TO_MANY NONE AIR_RIGHTS_BBL AIR_RIGHTS_BBL  
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Cadastral/Tax_Lot_Polygon" "Cadastral/Tax_Lot_Face" "Cadastral/Polygon_Face_Relationship" COMPOSITE "FINAL.Tax_Lot_Face" "FINAL.TAX_LOT_POLYGON" FORWARD ONE_TO_MANY NONE BBL BBL  
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Condo" "Air_Rights_Condos" "Condo_Air_Rights_Relationship" SIMPLE "Air_Rights_Condos" "Condo" NONE ONE_TO_MANY NONE CONDO_BASE_BBL_KEY CONDO_BASE_BBL_KEY  
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Condo" "Condo_Units" "Condo_Condo_Unit_Relationship" SIMPLE "Condo_Units" "Condo" NONE ONE_TO_MANY NONE CONDO_BASE_BBL_KEY CONDO_BASE_BBL_KEY  
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Air_Rights_Holders" "Tax_Lot_Air_Rights_Holders_Relationship" SIMPLE "Air_Rights_Holders" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL HOLDING_BBL
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Air_Rights_Lots" "Tax_Lot_Air_Rights_Relationship" SIMPLE "Air_Rights_Lots" "Tax_Lot_Polygon" NONE ONE_TO_ONE NONE BBL DONATING_BBL
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Condo" "Tax_Lot_Condo_Relationship" SIMPLE "Condo" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL CONDO_BASE_BBL  
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Condo_Units" "Tax_Lot_Condo_Unit_Relationship" SIMPLE "Condo_Units" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL CONDO_BASE_BBL
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Conversion_Exceptions" "Tax_Lot_Conversion_Exceptions_Relationship" SIMPLE "FINAL.Conversion_Exceptions" "FINAL.Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL BBL
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Conversion_Log" "Tax_Lot_Conversion_Log_Relationship" SIMPLE "Conversion_Log" "Tax_Lot_Polygon" NONE ONE_TO_ONE NONE BBL BBL
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "REUC_Lots" "Tax_Lot_REUC_Relationship" SIMPLE "REUC_Lots" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL APPURTENANT_BBL
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py "Tax_Lot_Polygon" "Subterranean_Lots" "Tax_Lot_Subterranean_Relationship" SIMPLE "Subterranean_Lots" "Tax_Lot_Polygon" NONE ONE_TO_MANY NONE BBL APPURTENANT_BBL
CALL %PROPY% %TAXTOILREPO%versionall.py versionedtables
CALL %PROPY% %TAXTOILREPO%versionall.py versionedfeaturedatasets
CALL %PROPY% %TAXTOILREPO%grantall.py tables view MAP_VIEWER 
CALL %PROPY% %TAXTOILREPO%grantall.py featuredatasets view MAP_VIEWER 
CALL %PROPY% %TAXTOILREPO%grantall.py tables view MAP_VIEWER 
REM DOF_TAXMAP_EDITOR role will not exist on POC database
REM CALL %PROPY% grantall.py featuredatasets edit DOF_TAXMAP_EDITOR
REM CALL %PROPY% grantall.py versionedtables edit DOF_TAXMAP_EDITOR
REM grant direct to the editor as a workaround 
CALL %PROPY% %TAXTOILREPO%grantall.py featuredatasets edit DOF_EDITOR 
CALL %PROPY% %TAXTOILREPO%grantall.py versionedtables edit DOF_EDITOR
CALL %PROPY% %TAXTOILREPO%analyzeall.py tables business
CALL %PROPY% %TAXTOILREPO%analyzeall.py versionedtables delta
CALL %PROPY% %TAXTOILREPO%analyzeall.py Cadastral delta
CALL %TAXTOILREPO%src\py\resources\createversionedviews.bat
CALL %PROPY% %TAXTOILREPO%qaall.py listoflists