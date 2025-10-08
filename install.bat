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

call :InstallCertificates "root" "Root"

echo.
echo ==================[ INTERMEDIATE CA ]================
echo.

call :InstallCertificates "intermediate" "CA"

echo.
echo =================[ PROCESS COMPLETE ]=================
echo.

Pause
goto :eof

:InstallCertificates
for %%f in ("%~dp0%1\*.der") do (
    <nul set /p=Installing: %%~nxf... 
    certutil -f -addstore "%2" "%%f" > "%~dp0temp_output.txt" 2>&1
    
    if errorlevel 1 (
        echo.
        echo [ERROR] CertMgr Failed:
        type "%~dp0temp_output.txt"
        REM non cancellare il file log per debug
    ) else (
        echo OK
        del "%~dp0temp_output.txt"
    )
)
echo.
echo Completed
echo.
goto :eof
