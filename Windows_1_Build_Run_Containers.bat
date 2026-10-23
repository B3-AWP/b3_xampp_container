@echo off
REM This batch file will start Docker Desktop if necessary, then build and run the containers.

REM Change to the directory of this script (otherwise e.g. C:\Windows\System32 when started as administrator)
cd /d "%~dp0"

echo Starting Docker...
docker info >nul 2>&1
if not errorlevel 1 (
    echo Docker is already running.
    goto build
)

if not exist "%ProgramFiles%\Docker\Docker\Docker Desktop.exe" (
    echo Docker Desktop not found. Please ensure Docker is installed.
    pause
    exit /b 1
)
start "" "%ProgramFiles%\Docker\Docker\Docker Desktop.exe"

REM Wait up to 120 seconds until the Docker daemon is running
set /a tries=0
:waitdocker
timeout /t 5 /nobreak >nul
docker info >nul 2>&1
if not errorlevel 1 goto dockerstarted
set /a tries+=1
if %tries% lss 24 goto waitdocker
echo Docker daemon is not running. Please start Docker Desktop and ensure the daemon is running.
pause
exit /b 1

:dockerstarted
echo Docker started successfully.

:build
echo Building and running Docker containers...
docker compose build
if errorlevel 1 (
    echo Failed to build Docker containers.
    pause
    exit /b 1
)
docker compose up -d
if errorlevel 1 (
    echo Failed to start Docker containers.
    pause
    exit /b 1
)
echo Docker containers are up and running.

echo Process completed.
pause
