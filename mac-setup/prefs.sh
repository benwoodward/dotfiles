fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

###############################################################################
# Application Prefs
###############################################################################
fancy_echo "Adding application preferences ..."
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2"

###############################################################################
# Custom Application Shortcuts
###############################################################################
fancy_echo "Adding application keyboard shortcuts ..."
# Add ⌘⌃W as close window shortcut in iTerm2 to prevent accidentally closing all tabs
defaults write com.googlecode.iterm2 NSUserKeyEquivalents -dict-add "Close" "@^w"

###############################################################################
# MacOS Configs
###############################################################################
fancy_echo "Adding MacOS configs"

# Save to disk, not iCloud
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Disable guest mode
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Siri is useless
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool false

# Show scrollbars only when scrolling
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Turn off the 'Application Downloaded from Internet' quarantine warning
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Set the time using the network time
systemsetup -setusingnetworktime on

# Set the computer sleep time to 10 minutes
sudo systemsetup -setcomputersleep 30

# Set the display sleep time to 10 minutes
sudo systemsetup -setdisplaysleep 10

# Disable smart dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Keyboard
###############################################################################

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write -g AppleKeyboardUIMode -int 3

# Finder
###############################################################################

# Mac App Store: Enable debug menu
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable power button from putting your mac in Stand-by mode
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no

# Stop Photos from opening automatically on your Mac
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Show path (breadcrumb) bar
defaults write com.apple.finder ShowPathbar -bool true

# Show all file extensions
defaults write -g AppleShowAllExtensions -bool true

# Allowing text selection in Quick Look/Preview in Finder by default
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default (the default 'This Mac' is 'SCev')
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv` (icon), `Nlsv` (list), `Flwv` (cover flow)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder SearchRecentsSavedViewStyle -string "clmv"

# Disable creation of Metadata Files on Network Volumes (avoids creation of .DS_Store and AppleDouble files.)
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable creation of Metadata Files on USB Volumes (avoids creation of .DS_Store and AppleDouble files.)
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show app-centric sidebar
defaults write com.apple.finder FK_AppCentricShowSidebar -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show the '~/Library' folder
chflags nohidden ~/Library

# Expand the following File Info panes: 'General', 'Open with', and 'Sharing & Permissions'
defaults write com.apple.finder FXInfoPanesExpanded -dict-add "General" -bool true
defaults write com.apple.finder FXInfoPanesExpanded -dict-add "MetaData" -bool false
defaults write com.apple.finder FXInfoPanesExpanded -dict-add "OpenWith" -bool true
defaults write com.apple.finder FXInfoPanesExpanded -dict-add "Privileges" -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.5

# Show image for notifications
defaults write com.apple.dock notification-always-show-image -bool true

# Enable the 'reopen windows when logging back in' option
# This works, although the checkbox will still appear to be checked.
defaults write com.apple.loginwindow TALLogoutSavesState -bool true
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool true

source "./modules/trackpad.sh"
source "./modules/dock.sh"

fancy_echo "Some configs will not take effect until after logout, e.g. MacOS configs like 3 finger drag"

# TODO: Add notification settings for specific apps via `defaults write`, e.g. hide/silence iMessage notifications
# TODO: Extract the rest of this to modules so sections of this can be run individually for convenience and manual testing
