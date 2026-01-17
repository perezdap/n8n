#!/bin/bash

# ==============================================================================
# Setup Firewall Script
# ==============================================================================
# This script configures the Uncomplicated Firewall (UFW) to secure the host.
# It sets default policies, allows essential traffic (Web, SSH), and enables UFW.
#
# Usage: sudo ./setup_firewall.sh
# ==============================================================================

set -e

echo "Configuring UFW firewall..."

# 1. Set Default Policies
# Deny all incoming connections by default to ensure a secure baseline.
# Allow all outgoing connections so the server can reach the internet (updates, APIs).
echo "Setting default policies..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. Allow SSH (Custom Port)
# We allow traffic on TCP port 2222 for SSH access.
# CRITICAL: Ensure your SSH config is listening on this port before rebooting
# or closing your current session, otherwise you may lock yourself out.
echo "Allowing SSH on port 2222..."
sudo ufw allow 2222/tcp

# 3. Allow HTTP and HTTPS
# We allow traffic on port 80 (HTTP) and 443 (HTTPS) for the web server/proxy.
echo "Allowing HTTP (80) and HTTPS (443)..."
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# 4. Enable UFW
# We use '--force' to enable the firewall without prompting for confirmation.
# This is necessary for automated setups.
echo "Enabling UFW..."
sudo ufw --force enable

echo "Firewall configured successfully."
sudo ufw status verbose
