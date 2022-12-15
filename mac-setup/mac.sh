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
  # sudo chgrp -R brew $(brew --prefix)/*
  # sudo chown -R root $(brew --prefix)/*
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

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
tap "homebrew/cask"

# Unix
brew "universal-ctags", args: ["HEAD"]
brew "git"
brew "openssl"
brew "neovim"
brew "zsh"
brew "exa"
brew "ripgrep"
brew "ranger"
brew "fzf"
brew "bat"
brew "diff-so-fancy"
cask "ksdiff"
brew "tree"
brew "gh"
brew "patchutils"
brew "colordiff"
brew "tmux"
brew "lf"
brew "wget"
brew "ffmpeg"
brew "git-imerge"
brew "ag"

# Image manipulation
brew "imagemagick"

# Programming language prerequisites and package managers
brew "libyaml" # should come after openssl
brew "coreutils"

# Databases
brew "postgresql", restart_service: :changed
brew "asdf"

# UI enhancements
brew "koekeishiya/formulae/yabai"
brew "koekeishiya/formulae/skhd"
cask "karabiner-elements"
brew "blueutil"
cask "hammerspoon"
EOF

# fix_brew_permissions

fancy_echo "Configuring asdf version manager ..."
if [ ! -d "$HOME/.asdf" ]; then
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
source "$(brew --prefix asdf)/libexec/asdf.sh"
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

number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

fancy_echo "Installing latest Node ..."
install_asdf_language "nodejs"

# TODO: Copy minimal icons to iTerm via command
# https://superuser.com/a/1343756
# https://github.com/jasonlong/iterm2-icons

