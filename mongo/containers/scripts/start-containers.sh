#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the directory of the script and the root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Build Docker images
echo "Building mongo image..."
docker build -t mongo-image:6.0 "$ROOT_DIR" 2>&1 | tee "$SCRIPT_DIR/logs/mongo_build.log"
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "mongo build failed. Check mongo_build.log for details."
    exit 1
fi



# Start the containers
echo "Starting containers..."
docker-compose -f "$ROOT_DIR/docker-compose.yml" up -d
# --build --no-cache

echo "Containers started successfully."