#!/bin/bash

echo "Verifying directory structure..."

DIRS=("docker" "traefik" "scripts")
MISSING=0

for dir in "${DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "FAIL: Directory $dir does not exist."
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    exit 1
fi

echo "PASS: Directory structure verified."
exit 0
