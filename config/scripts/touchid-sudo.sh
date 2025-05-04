#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Touch ID for sudo...${NC}"

# Check if the file exists and contains the required line
if ! grep -q "auth       sufficient     pam_tid.so" /etc/pam.d/sudo; then
    # Create a backup of the original file
    sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.bak

    # Add the Touch ID line to the sudo configuration
    sudo sed -i '' '1s/^/auth       sufficient     pam_tid.so\n/' /etc/pam.d/sudo

    echo -e "${GREEN}Touch ID for sudo has been enabled!${NC}"
    echo -e "${BLUE}You can now use your fingerprint for sudo authentication.${NC}"
else
    echo -e "${GREEN}Touch ID for sudo is already enabled.${NC}"
fi
