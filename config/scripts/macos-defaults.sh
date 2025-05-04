#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Configuring macOS system preferences...${NC}"

# Close System Preferences to prevent overriding changes
osascript -e 'tell application "System Preferences" to quit'

# Dock
echo -e "${BLUE}Configuring Dock...${NC}"
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true
# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Trackpad
echo -e "${BLUE}Configuring Trackpad...${NC}"
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Finder
echo -e "${BLUE}Configuring Finder...${NC}"
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Security
echo -e "${BLUE}Configuring Security...${NC}"
# Enable firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Screenshots
echo -e "${BLUE}Configuring Screenshots...${NC}"
# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"
# Save screenshots to the Desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Keyboard
echo -e "${BLUE}Configuring Keyboard...${NC}"
# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
# Set a short delay until repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Restart affected applications
echo -e "${BLUE}Restarting affected applications...${NC}"
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" &>/dev/null || true
done

echo -e "${GREEN}macOS system preferences have been configured!${NC}"
echo -e "${BLUE}Note: Some changes may require a logout/restart to take effect.${NC}"
