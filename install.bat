@echo off

REM Verifica se lo script è eseguito con privilegi di amministratore
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Questo script deve essere eseguito con privilegi di amministratore.
    echo Fare clic con il tasto destro sul file e selezionare "Esegui come amministratore".
    pause
    exit /b
)

echo.
echo =====================[ ROOT CA ]=====================
echo.

call :InstallCertificates root root

echo.
echo ==================[ INTERMEDIATE CA ]================
echo.

call :InstallCertificates intermediate CA

echo.
echo =================[ PROCESS COMPLETE ]=================
echo.

Pause
goto :eof

:InstallCertificates
for %%f in (%~dp0%1\*.der) do (
    <nul set /p=Installing: %%~nxf... 
    certmgr.exe -add %%f -s -r localMachine %2 >temp_output.txt 2>&1
    if errorlevel 0 (
        echo OK
        del temp_output.txt
    ) else (
        echo.
        echo [ERROR] CertMgr Failed:
        type temp_output.txt
    )
)
echo.
echo Completed
echo.
goto :eof
