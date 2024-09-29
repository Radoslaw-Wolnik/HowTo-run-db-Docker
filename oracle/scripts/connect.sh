#!/bin/bash

# Get the directory of the script and the root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Source the .env file
if [ -f "$ROOT_DIR/.env" ]; then
    source "$ROOT_DIR/.env"
else
    echo ".env file not found in the root directory"
    exit 1
fi

# Check if the container is running
if [ -z "$(docker-compose ps -q oracle-xe)" ]; then
    echo "Oracle XE container is not running. Starting it now..."
    docker-compose up -d oracle-xe
    echo "Waiting for Oracle to start up..."
    sleep 30  # Adjust this if needed
fi

# Connect to SQL*Plus
docker-compose exec oracle-xe sqlplus "${APP_USER}@XEPDB1"