#!/bin/bash

FILE_PATH="docker/docker-compose.yml"

echo "Testing $FILE_PATH for network definitions..."

# 1. Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "FAIL: $FILE_PATH does not exist."
    exit 1
fi

# 2. Check for required networks
REQUIRED_NETWORKS=("traefik-public" "n8n-internal")
MISSING=0

for net in "${REQUIRED_NETWORKS[@]}"; do
    if ! grep -q "$net" "$FILE_PATH"; then
        echo "FAIL: Network '$net' not defined in $FILE_PATH."
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    exit 1
fi

echo "PASS: Docker networks defined."
exit 0
