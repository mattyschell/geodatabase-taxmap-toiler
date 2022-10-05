set WHAT2WHAT=dev2dev
set BASEPATH=C:\xxx
set DTMLOG=%BASEPATH%\geodatabase-scripts\logs\geodatabase-taxmap-toiler\%WHAT2WHAT%.log
echo starting > %DTMLOG%
echo %date%:%time% >> %DTMLOG%
cmd /c migrate_%WHAT2WHAT%.bat
echo completed >> %DTMLOG%
echo %date%:%time% >> %DTMLOG%