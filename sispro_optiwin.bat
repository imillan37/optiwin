@echo off
:: Script de optimización para Windows 10 + instalación de programas y drivers
:: Requiere ejecución como Administrador

title Optimizador Windows 10 - By %Israel Millan Sispro%
color 0A
echo.
echo [*] Iniciando optimización de Windows 10 y instalación de programas...
echo.

:: --- 1. Acelerar rendimiento del sistema ---
echo [1/3] Aplicando ajustes de rendimiento...
:: Desactivar servicios innecesarios
sc config "SysMain" start= disabled >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1
:: Optimizar uso de memoria
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
:: Desactivar efectos visuales
powercfg -SETACTIVE SCHEME_MIN >nul
:: Liberar espacio en disco
cleanmgr /sagerun:1 >nul

:: --- 2. Instalar programas automáticamente ---
echo [2/3] Instalando programas esenciales...
:: Descargar e instalar WinRAR
curl -L -o winrar.exe https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-624.exe >nul
start /wait winrar.exe /s
del winrar.exe >nul
:: Descargar e instalar Adobe Reader
curl -L -o adobereader.exe https://get.adobe.com/reader/enterprise/ >nul
start /wait adobereader.exe /sAll /rs /rps /msi EULA_ACCEPT=YES >nul
del adobereader.exe >nul
:: Descargar e instalar Firefox
curl -L -o firefox.exe https://download.mozilla.org/?product=firefox-latest&os=win64&lang=es-MX >nul
start /wait firefox.exe /S >nul
del firefox.exe >nul
:: Instalar Office (requiere descarga previa o ISO)
echo [*] Office: Descarga manual o inserta ISO (ejecutar setup.exe manualmente).

:: --- 3. Actualizar controladores ---
echo [3/3] Actualizando controladores...
:: Usar Windows Update para drivers
wuauclt /detectnow /updatenow >nul
:: Alternativa con PowerShell (requiere conexión a internet)
powershell -command "Start-Process -Verb RunAs -FilePath 'mshta.exe' -ArgumentList 'vbscript:CreateObject(\"Shell.Application\").ShellExecute(\"powershell.exe\", \"-Command Install-Module -Name PSWindowsUpdate -Force; Install-WindowsUpdate -AcceptAll -AutoReboot\", \"\", \"runas\", 1)(window.close)'" >nul

:: --- Finalización ---
echo.
echo [*] ¡Optimización completada! Reinicie el sistema para aplicar cambios.
echo.
pause