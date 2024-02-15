# Check if required variables are provided
ifndef GITHUB_USER
$(error GITHUB_USER is not set)
endif

ifndef REPO_NAME
$(error REPO_NAME is not set)
endif

# Project directories
DIRS=cmd pkg docs tests

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
	mkdir $(HOME)/$(REPO_NAME); cd $(HOME)/$(REPO_NAME)
	@for dir in $(DIRS); do \
		mkdir -p $$dir; \
		echo "Created $$dir directory"; \
	done
	@echo "package main\n\nimport \"fmt\"\n\nfunc main() {\n\tfmt.Println(\"Hello, world!\")\n}" > cmd/main.go

# Initialize Go module
init:
	cd $(HOME)/$(REPO_NAME)
	go mod init $(REPO_NAME)
	@echo "Go module initialized."

# Initialize Git repository
git-init:
	cd $(HOME)/$(REPO_NAME)
	git init
	touch .gitignore
	echo "vendor/" >> .gitignore
	echo ".vscode/" >> .gitignore
	echo "bin/" >> .gitignore
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
	git commit -m "Initial Go project setup"

# Push to GitHub
push:
	git push -u origin master

.PHONY: all check-gh install-gh dirs init git-init github-repo git-remote add-commit push
