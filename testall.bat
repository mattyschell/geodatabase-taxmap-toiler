REM executes from ArcGIS Pro conda environment
REM SDEFILE env to target test location must be set
REM set SDEFILE=XX:\gis\oracle19c\dev\zz-zzzzzz\dof_taxmap.sde
REM set PYTHONPATH=C:\geodatabase-toiler\src\py;%PYTHONPATH%
CALL c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat .\src\py\test_importer.py 