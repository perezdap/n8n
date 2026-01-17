#!/bin/bash

FILE_PATH="docker/docker-compose.yml"

echo "Testing $FILE_PATH for n8n service definition..."

# 1. Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "FAIL: $FILE_PATH does not exist."
    exit 1
fi

# 2. Check for required patterns in n8n service
REQUIRED_PATTERNS=(
    "n8n-app:"
    "image: n8nio/n8n:1"
    "DB_TYPE: postgres"
    "N8N_RUNNERS_ENABLED: \"true\""
    "N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS: \"true\""
    "traefik.enable=true"
    "traefik.http.routers.n8n.rule=Host"
    "traefik.http.routers.n8n.tls.certresolver=letsencrypt"
    "n8n_data:/home/node/.n8n"
    "traefik-public"
    "n8n-internal"
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

echo "PASS: n8n service defined in Docker Compose."
exit 0
