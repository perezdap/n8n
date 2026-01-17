#!/bin/bash

SCRIPT_PATH="scripts/install_docker.sh"

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
    'install -m 0755 -d /etc/apt/keyrings'
    'download.docker.com/linux/ubuntu'
    'apt-get install -y docker-ce docker-ce-cli containerd.io'
    'usermod -aG docker'
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
