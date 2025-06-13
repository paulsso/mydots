#!/bin/bash

set -e

# Uninstall old versions if any
echo "Removing old versions of Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# Update package index
sudo apt update

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update and install Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
echo "Adding $USER to docker group (you may need to log out and back in)..."
sudo usermod -aG docker $USER

# Verify installation
docker --version && echo "Docker installed successfully."

echo "Docker setup complete."

