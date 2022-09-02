REM If for some reason you want to pull over some jtx_tables
REM This doesnt work for tables with BLOB columns
set SRCSCHEMA=JTX_ADMIN
set DESTSCHEMA=%SRCSCHEMA%
set SRCPASS=xxx
set DESTPASS=yyy
set SRCDB=xxx.xxx.xxx
set DESTDB=xxxxxxx
set TABLES=JTX_CONN_INFO,JTX_JOB_TYPE_MAP_DOC,JTX_LAYERS,JTX_STEP_COMMENTS,JTX_TRANSACTIONS,JTX_TRANSACTIONS_TEMP,JTX_TRANSACTION_SESSIONS
set EXPFILE=C:\temp\jtx_admin.dmp
echo starting export to %EXPFILE%
exp %SRCSCHEMA%/%SRCPASS%@%SRCDB% FILE=%EXPFILE% TABLES=(%TABLES%)
echo starting import from %EXPFILE%
imp %DESTSCHEMA%/%DESTPASS%@%DESTDB% FILE=%EXPFILE% TABLES=(%TABLES%) IGNORE=y