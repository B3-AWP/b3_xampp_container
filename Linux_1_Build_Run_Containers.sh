#!/bin/bash

# Dieses Skript startet die Docker-Software, baut und startet Container und importiert einen SQL-Dump.

echo "Starting Docker..."

# Überprüfen, ob Docker-Daemon läuft, wenn nicht, starten
if ! sudo systemctl is-active --quiet docker; then
    echo "Docker service is not running. Starting Docker..."
    sudo systemctl start docker

    # Überprüfen, ob Docker erfolgreich gestartet wurde
    if [ $? -eq 0 ]; then
        echo "Docker service started successfully."
    else
        echo "Failed to start Docker service. Please check if Docker is installed and you have sufficient permissions."
        exit 1
    fi
else
    echo "Docker service is already running."
fi

echo "Building and running Docker containers..."
docker-compose build
docker-compose up -d

echo "Process completed."
