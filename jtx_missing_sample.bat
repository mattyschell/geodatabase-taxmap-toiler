REM executes from ArcGIS Pro conda environment
REM SDEFILE env to target test location must be set
set SDEFILE=XX:\gis\yyyyyyyyy\dev\zz-zzzzzz\dof_taxmap.sde
set PYTHONPATH=C:\gis\geodatabase-toiler\src\py;C:\gis\geodatabase-taxmap-toiler\src\py;%PYTHONPATH%
set SRCSDE=C:\xxx\Connections\oracle11g\yyy\zzz_zzzzzz.sde
set TAXTOILREPO=C:\gis\geodatabase-taxmap-toiler\
set TOILER=C:\gis\geodatabase-toiler\
set PY27=C:\Python27\ArcGIS10.6\python.exe
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
CALL %PROPY% %TAXTOILREPO%deleteall.py jtxtables
CALL %PROPY% %TAXTOILREPO%importall.py jtxtables %SRCSDE%