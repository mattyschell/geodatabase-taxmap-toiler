REM Update basepath and source, destination SDE files
set BASEPATH=A:\xxx
set SRCSDE=%BASEPATH%\Connections\oracle11g\yyy\zzz_zzzzzz.sde
set SDEFILE=%BASEPATH%\Connections\oracle19c\yyy\GEO-zzzZZzzz\aaa_aaaaaa.sde
REM Next section is ancient oracle exp imp for non-gdb tables
set ORACLE_PATH=C:\oracle\product\instantclient_19_5
set SRCPASS=***************
set DESTPASS=**************
set SRCDB=xxxxxxx.xxxxx.xxxxxx
set DESTDB=xxxxxxxx
REM review the rest
set PY27=C:\Python27\ArcGIS10.7\python.exe
set TAXTOILREPO=%BASEPATH%\geodatabase-taxmap-toiler\
set TOILER=%BASEPATH%\geodatabase-toiler\
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PYTHON3PATH=%BASEPATH%\geodatabase-toiler\src\py;%BASEPATH%\geodatabase-taxmap-toiler\src\py
set PYTHON2PATH=%TAXTOILREPO%\src\py27
set PYTHONPATH=%PYTHON3PATH%
set TABLES=DAB_ACTION_DEFINITION,DAB_AIR_RIGHTS,DAB_AIR_RIGHTS_DEFINITION,DAB_BOUNDARY_LINE,DAB_CONDO_CONVERSION,DAB_CONDO_UNITS,DAB_DOMAINS,DAB_REUC,DAB_SUBTERRANEAN_RIGHTS,DAB_TAX_LOTS,DAB_WIZARD_TRANSACTION,DTM_USER_MAINT,DTM_WORK_IN_PROGRESS,FINAL_ASMT
set EXPFILE=%TEMP%\dof_taxmap.dmp
REM migration starts here
CALL %PROPY% %TAXTOILREPO%deletefeaturedataset.py Cadastral
CALL %PROPY% %TAXTOILREPO%deletefeaturedataset.py DCP
CALL %PROPY% %TAXTOILREPO%deleteall.py relationshipclasses
CALL %PROPY% %TAXTOILREPO%deleteall.py featureclasses
CALL %PROPY% %TAXTOILREPO%deleteall.py tables
set PYTHONPATH=%PYTHON2PATH%
CALL %PY27% %TAXTOILREPO%src\py27\importfeaturedataset27.py Cadastral %SRCSDE%
CALL %PY27% %TAXTOILREPO%src\py27\importfeaturedataset27.py DCP %SRCSDE%
CALL %PY27% %TAXTOILREPO%src\py27\importall27.py featureclasses %SRCSDE%
set PYTHONPATH=%PYTHON3PATH%
CALL %PROPY% %TAXTOILREPO%importall.py tables %SRCSDE%
CALL %PROPY% %TAXTOILREPO%buildpossessionhooktopology.py Cadastral
CALL %PROPY% %TAXTOILREPO%buildtaxlottopology.py Cadastral
CALL %PROPY% %TAXTOILREPO%createrelationshipclass.py Air_Rights_Lots Air_Rights_Holders Air_Rights_Lots_Holders_Relationship SIMPLE Air_Rights_Holders Air_Rights_Lots NONE ONE_TO_MANY NONE AIR_RIGHTS_BBL AIR_RIGHTS_BBL  
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
CALL %PROPY% %TAXTOILREPO%grantall.py versionedfeaturedatasets edit DOF_TAXMAP_EDITOR 
CALL %PROPY% %TAXTOILREPO%grantall.py featuredatasets view DOF_TAXMAP_EDITOR
CALL %PROPY% %TAXTOILREPO%grantall.py featureclasses view DOF_TAXMAP_EDITOR
CALL %PROPY% %TAXTOILREPO%grantall.py versionedtables edit DOF_TAXMAP_EDITOR
CALL %PROPY% %TAXTOILREPO%grantall.py versionedfeaturedatasets edit ESRIUSER 
CALL %PROPY% %TAXTOILREPO%grantall.py featuredatasets view ESRIUSER
CALL %PROPY% %TAXTOILREPO%grantall.py featureclasses view ESRIUSER
CALL %PROPY% %TAXTOILREPO%grantall.py versionedtables edit ESRIUSER
CALL %PROPY% %TAXTOILREPO%analyzeall.py tables business
CALL %PROPY% %TAXTOILREPO%analyzeall.py versionedtables delta
CALL %PROPY% %TAXTOILREPO%analyzeall.py Cadastral delta
CALL %TAXTOILREPO%src\py\resources\createversionedviews.bat
CALL %ORACLE_PATH%\exp.exe DOF_TAXMAP/%SRCPASS%@%SRCDB% FILE=%EXPFILE% TABLES=(%TABLES%)
CALL %ORACLE_PATH%\sqlplus.exe DOF_TAXMAP/%DESTPASS%@%DESTDB% @%TAXTOILREPO%\src\sql_oracle\droptables.sql
CALL %ORACLE_PATH%\imp.exe DOF_TAXMAP/%DESTPASS%@%DESTDB% FILE=%EXPFILE% TABLES=(%TABLES%) IGNORE=y
CALL %PROPY% %TAXTOILREPO%importall.py cleantables %SRCSDE%
CALL %ORACLE_PATH%\sqlplus.exe DOF_TAXMAP/%DESTPASS%@%DESTDB% @%TAXTOILREPO%src\sql_oracle\cleantables1.sql
CALL %PROPY% %TAXTOILREPO%deleteall.py cleantables
CALL %ORACLE_PATH%\sqlplus.exe DOF_TAXMAP/%DESTPASS%@%DESTDB% @%TAXTOILREPO%src\sql_oracle\cleantables2.sql
CALL %ORACLE_PATH%\sqlplus.exe DOF_TAXMAP/%DESTPASS%@%DESTDB% @%TAXTOILREPO%src\sql_oracle\grantdatabasetables.sql
CALL %ORACLE_PATH%\sqlplus.exe DOF_TAXMAP/%DESTPASS%@%DESTDB% @%TAXTOILREPO%src\sql_oracle\dab_transaction_sequence.sql
CALL %PROPY% %TAXTOILREPO%qaall.py listoflists

