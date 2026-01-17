#!/bin/bash

FILE_PATH="docker/docker-compose.yml"

echo "Testing $FILE_PATH for Traefik service definition..."

# 1. Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "FAIL: $FILE_PATH does not exist."
    exit 1
fi

# 2. Check for required patterns in traefik service
REQUIRED_PATTERNS=(
    "traefik:"
    "image: traefik:v3"
    "80:80"
    "443:443"
    "/var/run/docker.sock:/var/run/docker.sock:ro"
    "./../traefik/traefik.yml:/etc/traefik/traefik.yml:ro"
    "traefik-public"
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

echo "PASS: Traefik service defined in Docker Compose."
exit 0
