###############################################################################
# Dock
###############################################################################

# Set the icon size of Dock items to 35 pixels
defaults write com.apple.dock tilesize -int 90

# Set magnification size
defaults write com.apple.dock largesize -int 125

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilte-stack -bool true

# Animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool true


# Disable Bouncing dock icons
defaults write com.apple.dock no-bouncing -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0.25

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Automatically magnify the Dock
defaults write com.apple.dock magnification -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Prefer tabs when opening documents: 'always', 'fullscreen', 'manual'
defaults write NSGlobalDomain AppleWindowTabbingMode -string 'always'
