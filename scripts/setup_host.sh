#!/bin/bash

# ==============================================================================
# Setup Host Script
# ==============================================================================
# This script performs the initial setup for the Ubuntu host.
# It updates the package lists, upgrades existing packages, and installs
# essential dependencies required for the project.
#
# Usage: sudo ./setup_host.sh
# ==============================================================================

# Exit immediately if a command exits with a non-zero status.
# This ensures that if any part of the setup fails, the script stops execution
# to prevent the system from ending up in an inconsistent state.
set -e

echo "Starting host setup..."

# 1. Update Package Lists
# We run 'apt-get update' to ensure we have the latest information about
# available packages and their versions from the repositories.
echo "Updating package lists..."
sudo apt-get update

# 2. Upgrade Existing Packages
# 'apt-get upgrade -y' installs the newest versions of all packages currently
# installed on the system. The '-y' flag automatically answers "yes" to prompts.
echo "Upgrading installed packages..."
sudo apt-get upgrade -y

# 3. Install Dependencies
# We install the following required tools:
# - curl: Used for transferring data with URLs (needed for Docker installation).
# - git: Used for version control and cloning repositories.
# - ufw: Uncomplicated Firewall, used to secure the host network.
echo "Installing dependencies (curl, git, ufw)..."
sudo apt-get install -y curl git ufw

echo "Host setup completed successfully."
