#!/bin/bash

FILE_PATH="traefik/traefik.yml"

echo "Testing $FILE_PATH for Traefik static configuration..."

# 1. Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "FAIL: $FILE_PATH does not exist."
    exit 1
fi

# 2. Check for entrypoints and certificatesresolvers
REQUIRED_PATTERNS=("entryPoints" "web" "websecure" "certificatesResolvers" "letsencrypt" "acme")
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

echo "PASS: Traefik static configuration verified."
exit 0
