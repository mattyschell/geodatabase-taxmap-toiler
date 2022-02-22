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
CALL %PROPY% createrelationshipclass.py Air_Rights_Lots Air_Rights_Holders Air_Rights_Lots_Holders_Relationship SIMPLE Air_Rights_Holders Air_Rights_Lots NONE ONE_TO_MANY NONE AIR_RIGHTS_BBL AIR_RIGHTS_BBL  
CALL %PROPY% createrelationshipclass.py "Cadastral/Tax_Lot_Polygon" "Cadastral/Tax_Lot_Face" "Cadastral/Polygon_Face_Relationship" COMPOSITE "FINAL.Tax_Lot_Face" "FINAL.TAX_LOT_POLYGON" FORWARD ONE_TO_MANY NONE BBL BBL  
