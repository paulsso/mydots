#!/bin/bash

set -e

FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="FiraCode Nerd Font"
FONT_REPO="https://github.com/ryanoasis/nerd-fonts"

# Create font directory if not exists
mkdir -p "$FONT_DIR"

# Download and install FiraCode Nerd Font
echo "Installing $FONT_NAME..."
git clone --depth 1 --filter=blob:none --sparse $FONT_REPO temp-nerd-fonts
cd temp-nerd-fonts

# Only checkout FiraCode
git sparse-checkout set patched-fonts/FiraCode
./install.sh FiraCode

# Cleanup
cd ..
rm -rf temp-nerd-fonts

# Refresh font cache
fc-cache -fv

echo "$FONT_NAME installed successfully."
