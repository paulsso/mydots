#!/bin/bash

set -e

SOURCE_DIR="$(dirname "$0")/settings/i3"
TARGET_DIR="$HOME/.config/i3"

# Update package list
echo "Updating package list..."
sudo apt update

# Install dependencies for i3
sudo apt install -y software-properties-common

# Install i3 window manager
echo "Installing i3 window manager..."
sudo apt install -y i3 dmenu xbacklight feh conky

echo "Copy i3 config file"
cp "$SOURCE_DIR/config" "$TARGET_DIR/config"

echo "i3 installation complete."

