REM executes from ArcGIS Pro conda environment
REM SDEFILE env to target test location must be set
set SDEFILE=C:\xxx\Yyyyyyyyyyy\zzzzzzzzz\aaa\bbb-bbbbbbbb\dof_taxmap.sde
set PYTHONPATH=C:\xxx\geodatabase-toiler\src\py;C:\xxx\geodatabase-taxmap-toiler\src\py%PYTHONPATH%
CALL c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat .\src\py\test_importer.py 