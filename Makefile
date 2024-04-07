# Define targets as phony
.PHONY: init install finder terminal brew vscode git

# Do everything.
all: init install finder terminal brew vscode git

# Set initial preference.
init:
	@echo "\033[0;34mRun init/setup.sh\033[0m"
	@init/setup.sh
	@echo "\033[0;34mDone.\033[0m"

# Set dotfiles.
install:
	@echo "\033[0;34mRun home/setup.sh\033[0m"
	@home/setup.sh
	@echo "\033[0;32mDone.\033[0m"

# Set Finder.app.
finder:
	@echo "\033[0;34mRun finder/setup.sh\033[0m"
	@finder/setup.sh
	@echo "\033[0;32mDone.\033[0m"

# Set Terminal.app.
terminal:
	@echo "\033[0;34mRun terminal/setup.sh\033[0m"
	@terminal/setup.sh
	@echo "\033[0;32mDone.\033[0m"

# Install macOS applications.
brew:
	@echo "\033[0;34mRun brew/setup.sh\033[0m"
	@brew/setup.sh
	@echo "\033[0;32mDone.\033[0m"

# Setup vscode
vscode:
	@echo "\033[0;34mRun vscode/setup.sh\033[0m"
	@vscode/setup.sh
	@echo "\033[0;32mDone.\033[0m"

# Setup git
git:
	@echo "\033[0;34mRun git/setup.sh\033[0m"
	@git/setup.sh
	@echo "\033[0;32mDone.\033[0m"
