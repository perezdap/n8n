#!/bin/bash

SCRIPT_PATH="scripts/secure_ssh.sh"

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

# 3. Check for required commands/patterns
REQUIRED_PATTERNS=(
    'sudo cp "$CONFIG_FILE" "$BACKUP_FILE"'
    'ensure_config "Port" "2222"'
    'ensure_config "PermitRootLogin" "no"'
    'ensure_config "PasswordAuthentication" "no"'
    'sudo service ssh restart'
)
MISSING=0

for pattern in "${REQUIRED_PATTERNS[@]}"; do
    if ! grep -Fq "$pattern" "$SCRIPT_PATH"; then
        echo "FAIL: Script does not contain pattern '$pattern'"
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    exit 1
fi

echo "PASS: All checks passed."
exit 0
