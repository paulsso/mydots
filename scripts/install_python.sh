#!/bin/bash

set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install Python 3 and pip
echo "Installing Python 3 and pip..."
sudo apt install -y python3 python3-pip

# Install venv module
echo "Installing python3-venv for virtual environments..."
sudo apt install -y python3-venv

# Create default venv for VSCode and Neovim
VENV_DIR="$HOME/.venvs/default"
echo "Creating default Python virtual environment at $VENV_DIR..."
mkdir -p "$HOME/.venvs"
python3 -m venv "$VENV_DIR"

# Activate venv and install packages
source "$VENV_DIR/bin/activate"
echo "Upgrading pip and installing development packages..."
pip install --upgrade pip
pip install \
  ipython \
  black \
  flake8 \
  mypy \
  pylint \
  virtualenv \
  requests \
  numpy \
  matplotlib \
  pyright

deactivate

echo "Python development environment and default venv setup complete."

