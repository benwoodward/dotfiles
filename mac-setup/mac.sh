#!/bin/sh

# Useful resources:
# https://github.com/joeyhoer/starter/tree/master/system
# https://github.com/thoughtbot/laptop

# Run this with:
# sh mac 2>&1 | tee ~/laptop.log

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

fix_brew_permissions() {
  # Force bash to include dotfiles in glob
  shopt -u dotglob

  # Make /usr/local writable
  sudo chmod -R g+rwx $(brew --prefix)/*
  # sudo chmod -R g+rwx /usr/local/share/zsh

  # Make it usable for multiple users (anyone in custom 'brew' group)
  sudo chgrp -R brew $(brew --prefix)/*
  sudo chown -R root $(brew --prefix)/*
  # sudo chown -R root /usr/local/share/zsh
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\\n" "$text" >> "$zshrc"
    else
      printf "\\n%s\\n" "$text" >> "$zshrc"
    fi
  fi
}

set -eE -o functrace
failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

# shellcheck disable=SC2154
# trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  read -p "Add 'brew' group with homebrew users in 'Users & Groups' in Sys. Prefs. Press enter when complete"
  fix_brew_permissions
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    printf ""
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

update_shell() {
  local shell_path;
  shell_path="$(command -v zsh)"

  fancy_echo "Changing your shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    fancy_echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi
  sudo chsh -s "$shell_path" "$USER"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

case "$SHELL" in
  */zsh)
    if [ "$(command -v zsh)" != '/usr/local/bin/zsh' ] ; then
      update_shell
    fi
    ;;
  *)
    update_shell
    ;;
esac

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    append_to_zshrc '# recommended by brew doctor'

    # shellcheck disable=SC2016
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=- <<EOF
tap "universal-ctags/universal-ctags"
tap "caskroom/cask"
tap "heroku/brew"

# Unix
brew "universal-ctags", args: ["HEAD"]
brew "git"
brew "openssl"
brew "neovim"
brew "zsh"

# Heroku
brew "heroku/brew/heroku"

# GitHub
brew "hub"

# Image manipulation
brew "imagemagick"

# Programming language prerequisites and package managers
brew "libyaml" # should come after openssl
brew "coreutils"
cask "gpg-suite"

# Databases
brew "postgres", restart_service: :changed
EOF

fix_brew_permissions

fancy_echo "Update heroku binary ..."
brew unlink heroku
brew link --force heroku

fancy_echo "Configuring asdf version manager ..."
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0
  append_to_zshrc "source ~/.asdf/asdf.sh" 1
fi

alias install_asdf_plugin=add_or_update_asdf_plugin
add_or_update_asdf_plugin() {
  local name="$1"
  local url="$2"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name" "$url"
  else
    asdf plugin-update "$name"
  fi
}

# shellcheck disable=SC1090
source "$HOME/.asdf/asdf.sh"
add_or_update_asdf_plugin "ruby" "https://github.com/asdf-vm/asdf-ruby.git"
add_or_update_asdf_plugin "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"

install_asdf_language() {
  local language="$1"
  local version
  version="$(asdf list-all "$language" | grep -v "[a-z]" | tail -1)"

  if ! asdf list "$language" | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
}

fancy_echo "Installing latest Ruby ..."
install_asdf_language "ruby"
gem update --system
gem_install_or_update "bundler"

fancy_echo "Installing iOS dev gems ..."
gem_install_or_update "cocoapods"
gem_install_or_update "slather"

number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

fancy_echo "Installing latest Node ..."
bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
install_asdf_language "nodejs"

# Fix zsh permissions
# fancy_echo "Fixing zsh permissions ..."
# /bin/zsh -i -c 'compaudit | xargs sudo chmod g-w'

# TODO: Copy minimal icons to iTerm via command
# https://superuser.com/a/1343756
# https://github.com/jasonlong/iterm2-icons

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

source "modules/trackpad.sh"
source "modules/dock.sh"

fancy_echo "Some configs will not take effect until after logout, e.g. MacOS configs like 3 finger drag"

# TODO: Add notification settings for specific apps via `defaults write`, e.g. hide/silence iMessage notifications
# TODO: Extract the rest of this to modules so sections of this can be run individually for convenience and manual testing
