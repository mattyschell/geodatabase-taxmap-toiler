REM executes from ArcGIS Pro conda environment
REM SDEFILE env to target test location must be set
REM set SDEFILE=XX:\gis\oracle19c\dev\zz-zzzzzz\dof_taxmap.sde
REM set PYTHONPATH=C:\geodatabase-toiler\src\py;%PYTHONPATH%
set SRCSDE=C:\xxx\Connections\oracle11g\yyy\zzz_zzzzzz.sde
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
CALL %PROPY% deletefeaturedataset.py Cadastral
CALL %PROPY% deleteall.py featureclasses
CALL %PROPY% deleteall.py tables
CALL %PROPY% importfeaturedataset.py Cadastral %SRCSDE%
CALL %PROPY% importall.py featureclasses %SRCSDE%
CALL %PROPY% importall.py tables %SRCSDE%