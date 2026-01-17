#!/bin/bash

FILE_PATH="docker/docker-compose.yml"

echo "Testing $FILE_PATH for PostgreSQL service definition..."

# 1. Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "FAIL: $FILE_PATH does not exist."
    exit 1
fi

# 2. Check for required patterns in postgres service
REQUIRED_PATTERNS=(
    "postgres-db:"
    "image: postgres:16"
    "POSTGRES_USER:"
    "POSTGRES_PASSWORD:"
    "POSTGRES_DB:"
    "n8n-internal"
    "postgres_data:"
)
MISSING=0

for pattern in "${REQUIRED_PATTERNS[@]}"; do
    if ! grep -q "$pattern" "$FILE_PATH"; then
        echo "FAIL: Required pattern '$pattern' not found in $FILE_PATH."
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    exit 1
fi

echo "PASS: PostgreSQL service defined in Docker Compose."
exit 0
