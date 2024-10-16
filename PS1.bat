@echo off
set /p "USER_ID=Enter ID: "
set /p "PW=Enter Password: "

echo Signing on with: %USER_ID%

sqlplus -S %USER_ID%/%PW%@FREEPDB1 @PS1_RUN.SQL

PAUSE