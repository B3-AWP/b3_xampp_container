@echo off
REM This batch file will start Docker software, build and run containers, and import a SQL dump.

REM Check for Administrator rights
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo This script requires administrator rights. Please run it as an administrator.
    pause
    exit /b 1
)

echo Starting Docker...
sc query type= service state= all | findstr /I /C:"docker"
if %ERRORLEVEL% == 0 (
    net start com.docker.service
    if %ERRORLEVEL% == 0 (
        echo Docker service started successfully.
    ) else (
        echo Failed to start Docker service. Please check if Docker is installed and you have sufficient permissions.
        pause
        exit /b 1
    )
) else (
    echo Docker service not found. Please ensure Docker is installed.
    pause
    exit /b 1
)

REM Check if Docker daemon is running
docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Docker daemon is not running. Please start Docker Desktop and ensure the daemon is running.
    pause
    exit /b 1
)

echo Building and running Docker containers...
docker-compose build
if %ERRORLEVEL% == 0 (
    docker-compose up -d
    if %ERRORLEVEL% == 0 (
        echo Docker containers are up and running.
    ) else (
        echo Failed to start Docker containers.
    )
) else (
    echo Failed to build Docker containers.
)

echo Process completed.
pause