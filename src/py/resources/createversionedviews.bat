REM this is a resource because it is a list of feature classes
REM we call this manually as a workaround to an ESRI bug
REM https://support.esri.com/en/technical-article/000023226
REM these three should be set in the calling batch file
REM set SDEFILE=XX:\gis\yyyyyyyyy\dev\zz-zzzzzz\dof_taxmap.sde
REM set TOILER=C:\gis\geodatabase-toiler\
REM set PYTHONPATH=%TOILER%;C:\gis\geodatabase-taxmap-toiler\src\py;%PYTHONPATH%
REM set PY27=C:\Python27\ArcGIS10.6\python.exe
set TARGETFC=Air_Rights_Condos
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Air_Rights_Holders
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Air_Rights_Lots
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Condo
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Condo_Units
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Conversion_Exceptions
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Conversion_Log
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=REUC_Lots
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Subterranean_Lots
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Boundary
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Lot_Face_Possession_Hooks
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Misc_Text
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Possession_Hooks
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Tax_Block_Polygon
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Tax_Lot_Centroid
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Tax_Lot_Face
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
set TARGETFC=Cadastral/Tax_Lot_Polygon
%PY27% %TOILER%src\py27\create_versionedviews.py %TARGETFC%
