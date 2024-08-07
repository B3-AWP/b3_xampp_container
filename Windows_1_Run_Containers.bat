REM This batch file will start Docker software, build and run containers, and import a SQL dump.

echo Starting Docker...
net start docker

if %ERRORLEVEL% == 0 (
    echo Docker service started successfully.
) else (
    echo Failed to start Docker service. Please check if Docker is installed and you have sufficient permissions.
)

echo Building and running Docker containers...

docker-compose up -d

echo Process completed.