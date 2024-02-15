# Check if required variables are provided
ifndef GITHUB_USER
$(error GITHUB_USER is not set)
endif

ifndef REPO_NAME
$(error REPO_NAME is not set)
endi

# Directory where the repo shall be located locally
WORKDIR=$(HOME)/$(REPO_NAME)

# Ensure you have GITHUB_TOKEN set in your environment variables for security
# export GITHUB_TOKEN=your_github_token_here

# Directories to create
DIRS=docs src tests

# Default target
all: check-gh dirs init git-init github-repo git-remote add-commit push

# Check for gh installation and install if not present
check-gh:
    @which gh > /dev/null || (echo "GitHub CLI not found. Installing..." && $(MAKE) install-gh)

# Install GitHub CLI
install-gh:
    @uname | grep Darwin > /dev/null && (brew install gh || echo "Please install Homebrew and run this command again.") || true
    @uname | grep Linux > /dev/null && (sudo apt update && sudo apt install gh || echo "Installation failed. If you are not on an Ubuntu-based distro, please install gh manually.") || true

# Create project directories
dirs:
    @mkdir $(WORKDIR); cd $(WORKDIR)
    for dir in $(DIRS); do \
        mkdir -p $$dir; \
        echo "Created $$dir directory"; \
    done

# Initialize Python project (e.g., virtual environment, requirements.txt)
init:
    python3 -m venv venv
    @echo "Virtual environment created."
    touch requirements.txt
    @echo "requirements.txt file created."

# Initialize Git repository
git-init:
    git init
    touch .gitignore
    echo "venv/" >> .gitignore
    echo "__pycache__/" >> .gitignore
    echo ".DS_Store" >> .gitignore
    @echo ".gitignore file created."
    git add .
    git commit -m "Initial commit: project structure setup"

# Create GitHub repository
github-repo:
    @gh auth status || (echo "GitHub CLI not authenticated. Run 'gh auth login'." && exit 1)
    @gh repo create $(REPO_NAME) --public --confirm

# Add remote origin
git-remote:
    git remote add origin https://github.com/$(GITHUB_USER)/$(REPO_NAME).git

# Add files and make an initial commit
add-commit:
    git add .
    git commit -m "Initial project setup"

# Push to GitHub
push:
    git push -u origin master

.PHONY: all check-gh install-gh dirs init git-init github-repo git-remote add-commit push
