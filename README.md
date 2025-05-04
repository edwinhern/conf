# macOS Configuration

A centralized repository for my macOS development environment setup and configuration.

## Project Structure

```txt
.
├── config/
│   ├── brew/          # Homebrew configuration
│   │   └── Brewfile   # List of Homebrew packages and casks
│   ├── zsh/           # Zsh configuration
│   │   └── .zshrc     # Zsh configuration file
│   ├── fonts/         # Font configurations and installation scripts
│   ├── vscode/        # VS Code settings and extensions
│   └── scripts/       # Installation and setup scripts
└── README.md          # This file
```

## Setup Instructions

### 1. Prerequisites

- macOS (tested on macOS Ventura and later)
- Git
- Xcode Command Line Tools

### 2. Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/macos-conf.git
   cd macos-conf
   ```

2. Run the setup script:

   ```bash
   ./config/scripts/setup.sh
   ```

### 3. Manual Setup Steps

#### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=config/brew/Brewfile
```

#### Zsh and Oh My Zsh

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Powerlevel10K theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Link zsh configuration
ln -s "$(pwd)/config/zsh/.zshrc" ~/.zshrc
source ~/.zshrc
```
