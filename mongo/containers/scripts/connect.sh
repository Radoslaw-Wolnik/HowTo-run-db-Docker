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

# MongoDB connection details
CONTAINER_NAME=$(docker-compose -f "$ROOT_DIR/docker-compose.yml" ps -q mongo)
DB_NAME=${DB_NAME:-mydatabase}
DB_USER=${DB_USER:-myuser}
DB_PASSWORD=${DB_PASSWORD}

if [ -z "$CONTAINER_NAME" ]; then
    echo "MongoDB container is not running. Please start it first."
    exit 1
fi

if [ -z "$DB_PASSWORD" ]; then
    echo "DB_PASSWORD is not set in .env file"
    exit 1
fi

# Connect to MongoDB
docker exec -it $CONTAINER_NAME mongosh -u $DB_USER -p $DB_PASSWORD --authenticationDatabase $DB_NAME