#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

fancy_echo "Executing modules/dock.sh"

###############################################################################
# Dock
###############################################################################

# Remove all apps from Dock
defaults write com.apple.dock persistent-apps -array

# Set the icon size of Dock items to 90 pixels
defaults write com.apple.dock tilesize -int 40

# Set magnification size
defaults write com.apple.dock largesize -int 55

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilte-stack -bool true

# Animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool true

# Disable Bouncing dock icons
defaults write com.apple.dock no-bouncing -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0.2

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Automatically magnify the Dock
defaults write com.apple.dock magnification -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Prefer tabs when opening documents: 'always', 'fullscreen', 'manual'
defaults write NSGlobalDomain AppleWindowTabbingMode -string 'always'
