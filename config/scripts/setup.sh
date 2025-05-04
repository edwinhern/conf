#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting macOS configuration setup...${NC}"

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="$(dirname "$CONFIG_DIR")"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for Xcode Command Line Tools
if ! command_exists xcode-select; then
    echo -e "${BLUE}Installing Xcode Command Line Tools...${NC}"
    xcode-select --install
else
    echo -e "${GREEN}Xcode Command Line Tools already installed${NC}"
fi

# Check for Homebrew
if ! command_exists brew; then
    echo -e "${BLUE}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo -e "${GREEN}Homebrew already installed${NC}"
fi

# Install Homebrew packages
echo -e "${BLUE}Installing Homebrew packages...${NC}"
brew bundle --file="$CONFIG_DIR/brew/Brewfile"

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${GREEN}Oh My Zsh already installed${NC}"
fi

# Install Zsh plugins
echo -e "${BLUE}Installing Zsh plugins...${NC}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Install Powerlevel10K theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Link zsh configuration
echo -e "${BLUE}Setting up Zsh configuration...${NC}"
ln -sf "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Setup Touch ID for sudo
echo -e "${BLUE}Setting up Touch ID for sudo...${NC}"
"$SCRIPT_DIR/touchid-sudo.sh"

# Configure macOS system preferences
echo -e "${BLUE}Configuring macOS system preferences...${NC}"
"$SCRIPT_DIR/macos-defaults.sh"

# Source the new configuration
echo -e "${BLUE}Reloading Zsh configuration...${NC}"
source "$HOME/.zshrc"

echo -e "${GREEN}Setup completed successfully!${NC}"
echo -e "${BLUE}Please restart your terminal or run 'source ~/.zshrc' to apply all changes.${NC}"
echo -e "${BLUE}Note: Some macOS settings may require a logout/restart to take effect.${NC}"
