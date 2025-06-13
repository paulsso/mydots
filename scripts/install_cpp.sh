#!/bin/bash

set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install C/C++ compilers and build tools
echo "Installing build-essential (GCC, G++, make)..."
sudo apt install -y build-essential

# Install CMake
echo "Installing CMake..."
sudo apt install -y cmake

# Install GDB (GNU Debugger)
echo "Installing GDB..."
sudo apt install -y gdb

# Optional: Install clang and clang-format
echo "Installing Clang and Clang-Format..."
sudo apt install -y clang clang-format

# Optional: Install cppcheck (static analysis)
echo "Installing Cppcheck..."
sudo apt install -y cppcheck

# Optional: Install Valgrind (memory checking)
echo "Installing Valgrind..."
sudo apt install -y valgrind

echo "C/C++ development tools installation complete."

