# Dev Environment Setup

This project provides a collection of scripts and a `Makefile` to automate the setup of a full-featured development environment on Ubuntu-based systems.

## Prerequisites

- Ubuntu-based OS
- `make`
- `curl`, `git`, `gpg`

## Usage

Clone the repository and run:

```bash
make all
```

You can also run individual setup steps as needed:

```bash
make install_zsh
make install_tools
make install_cpp
```

## Components

### 1. i3 Window Manager
- Installs the latest version of i3 and utilities like `i3status`, `dmenu`, `feh`, etc.
- [Script](./scripts/install_i3.sh)

### 2. Zsh & Oh My Zsh
- Installs `zsh`, sets it as the default shell, and installs [Oh My Zsh](https://ohmyz.sh/).
- Configures the `half-life` theme.
- Enables plugins: `git`, `zsh-syntax-highlighting`, `zsh-autosuggestions`.
- [Install Script](./scripts/install_zsh.sh)
- [Configure Script](./scripts/configure_ohmyzsh.sh)

### 3. Development Tools
- `fzf`, `neovim`, `gh` (GitHub CLI), `net-tools`, `tree`
- Editors: Visual Studio Code
- Utilities: `htop`, `bat`, `ripgrep`, `jq`
- [Script](./scripts/install_tools.sh)

### 4. C/C++ Toolchain
- Compilers: `gcc`, `g++`
- Tools: `cmake`, `gdb`, `clang`, `cppcheck`, `valgrind`
- [Script](./scripts/install_cpp.sh)

### 5. Python
- `python3`, `pip3`, `venv`
- Dev tools: `ipython`, `black`, `flake8`, `mypy`
- [Script](./scripts/install_python.sh)

### 6. Docker
- Installs Docker Engine, CLI, Buildx, Compose plugin
- Adds current user to Docker group
- [Script](./scripts/install_docker.sh)

### 7. i3 Configuration
- No configuration script is necessary; i3 will handle it on first launch.

## File Structure

```
.
|Makefile
├── README.md
└── scripts/
    ├── install_i3.sh
    ├── install_zsh.sh
    ├── configure_ohmyzsh.sh
    ├── install_tools.sh
    ├── install_cpp.sh
    ├── install_python.sh
    ├── install_docker.sh
    └── configure_i3.sh
```

---

Feel free to modify the scripts or `Makefile` to suit your specific preferences or environment.
