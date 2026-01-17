#!/bin/bash

# ==============================================================================
# Secure SSH Script
# ==============================================================================
# This script hardens the SSH configuration.
# Actions:
# - Backs up the original sshd_config.
# - Changes default SSH port to 2222.
# - Disables root login.
# - Disables password authentication (enforces key-based auth).
# - Restarts the SSH service.
#
# Usage: sudo ./secure_ssh.sh
# ==============================================================================

set -e

CONFIG_FILE="/etc/ssh/sshd_config"
BACKUP_FILE="/etc/ssh/sshd_config.bak_$(date +%Y%m%d_%H%M%S)"

echo "Securing SSH configuration..."

# 1. Backup Configuration
# Always backup configuration files before modifying them.
if [ -f "$CONFIG_FILE" ]; then
    echo "Backing up $CONFIG_FILE to $BACKUP_FILE..."
    sudo cp "$CONFIG_FILE" "$BACKUP_FILE"
else
    echo "Error: $CONFIG_FILE not found."
    exit 1
fi

# 2. Modify Configuration
# We use 'sed' to edit the file in place.
# We ensure the directives exist or replace them.

echo "Updating SSH port to 2222..."
# If Port is already defined, replace it. If not, append it.
# Simple sed approach: assume standard sshd_config structure or append if missing.
# For robustness in this script, we'll just append/modify using a helper or multiple seds.
# A safer way for automation is to comment out existing lines and append new ones at the end.

# Helper function to ensure a config line exists
ensure_config() {
    local key="$1"
    local value="$2"
    local file="$3"
    
    # Check if the key exists (even commented out)
    if grep -q "^[#]*\s*${key}\b" "$file"; then
        # Replace the line
        sudo sed -i "s|^[#]*\s*${key}\b.*|${key} ${value}|" "$file"
    else
        # Append to end of file
        echo "${key} ${value}" | sudo tee -a "$file" > /dev/null
    fi
}

ensure_config "Port" "2222" "$CONFIG_FILE"
ensure_config "PermitRootLogin" "no" "$CONFIG_FILE"
ensure_config "PasswordAuthentication" "no" "$CONFIG_FILE"
ensure_config "PubkeyAuthentication" "yes" "$CONFIG_FILE"

# 3. Verify Configuration
echo "Verifying SSH configuration syntax..."
sudo sshd -t

# 4. Restart Service
echo "Restarting SSH service..."
sudo service ssh restart

echo "SSH configuration updated successfully."
echo "CRITICAL: Do not close this session yet!"
echo "Open a NEW terminal window and verify you can connect via port 2222:"
echo "ssh -p 2222 user@host"
