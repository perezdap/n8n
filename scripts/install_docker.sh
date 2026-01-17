#!/bin/bash

# ==============================================================================
# Install Docker Script
# ==============================================================================
# This script installs Docker Engine and Docker Compose on the Ubuntu host.
# It sets up the official Docker repository, installs the packages, and
# configures the current user to run Docker commands without sudo.
#
# Usage: sudo ./install_docker.sh
# ==============================================================================

set -e

echo "Installing Docker..."

# 1. Set up Docker's apt repository
# Add Docker's official GPG key:
echo "Setting up Docker repository..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# 2. Install Docker packages
echo "Installing Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 3. Configure Non-Root Access
# Add the current user (or the user executing sudo via SUDO_USER) to the docker group.
echo "Configuring non-root access..."
TARGET_USER=${SUDO_USER:-$USER}

if [ -z "$TARGET_USER" ]; then
    echo "Warning: Could not determine target user. Skipping group add."
else
    echo "Adding user '$TARGET_USER' to docker group..."
    sudo usermod -aG docker "$TARGET_USER"
fi

echo "Docker installed successfully."
echo "You may need to log out and back in for group changes to take effect."
