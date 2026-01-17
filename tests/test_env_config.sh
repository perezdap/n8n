#!/bin/bash

echo "Testing environment configuration..."

# 1. Check if .env.example exists
if [ ! -f "docker/.env.example" ]; then
    echo "FAIL: docker/.env.example does not exist."
    exit 1
fi

# 2. Check for required variables in .env.example
REQUIRED_VARS=("POSTGRES_USER" "POSTGRES_PASSWORD" "POSTGRES_DB" "DOMAIN_NAME" "SSL_EMAIL")
MISSING=0

for var in "${REQUIRED_VARS[@]}"; do
    if ! grep -q "$var" "docker/.env.example"; then
        echo "FAIL: Variable '$var' not found in docker/.env.example."
        MISSING=1
    fi
done

# 3. Check if .env is gitignored (Using a simpler check if git command fails in some bash environments)
if ! git check-ignore -q "docker/.env"; then
    # Fallback: check if it's in .gitignore file explicitly
    if ! grep -q "docker/.env" ".gitignore"; then
        echo "FAIL: docker/.env is not gitignored."
        MISSING=1
    fi
fi

if [ $MISSING -eq 1 ]; then
    exit 1
fi

echo "PASS: Environment configuration verified."
exit 0