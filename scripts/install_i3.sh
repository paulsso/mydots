#!/bin/bash

set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install dependencies for i3
sudo apt install -y software-properties-common

# Install i3 window manager
echo "Installing i3 window manager..."
sudo apt install -y i3 dmenu xbacklight feh conky

echo "i3 installation complete."

