#!/bin/bash

SCRIPT_PATH="scripts/setup_firewall.sh"

echo "Running tests for $SCRIPT_PATH..."

# 1. Check if file exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "FAIL: $SCRIPT_PATH does not exist."
    exit 1
fi

# 2. Check if executable
if [ ! -x "$SCRIPT_PATH" ]; then
    echo "FAIL: $SCRIPT_PATH is not executable."
    exit 1
fi

# 3. Check for required commands
REQUIRED_COMMANDS=("ufw allow 80/tcp" "ufw allow 443/tcp" "ufw allow 2222/tcp" "ufw --force enable")
MISSING=0

for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! grep -q "$cmd" "$SCRIPT_PATH"; then
        echo "FAIL: Script does not contain '$cmd'"
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    exit 1
fi

echo "PASS: All checks passed."
exit 0
