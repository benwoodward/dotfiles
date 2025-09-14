#!/usr/bin/env bash
# mac-setup/mac.sh
# Run with:
#   sh mac-setup/mac.sh 2>&1 | tee ~/laptop.log

set -euo pipefail

fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if [ ! -f "$zshrc" ]; then
    touch "$zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

failure() {
  local lineno=$1
  local cmd=$2
  echo "Failed at ${lineno}: ${cmd}"
}
trap 'failure ${LINENO} "${BASH_COMMAND}"' ERR

# --- Homebrew -----------------------------------------------------------------

if ! command -v brew >/dev/null 2>&1; then
  fancy_echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ensure brew is on PATH for both Apple Silicon and Intel
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    append_to_zshrc 'eval "$(/opt/homebrew/bin/brew shellenv)"' 1
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
    append_to_zshrc 'eval "$(/usr/local/bin/brew shellenv)"' 1
  fi
else
  # If brew exists, still ensure shellenv is set in current shell & future shells
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    append_to_zshrc 'eval "$(/opt/homebrew/bin/brew shellenv)"' 1
  else
    eval "$(brew shellenv)"
    append_to_zshrc 'eval "$(brew shellenv)"' 1
  fi
fi

fancy_echo "Updating Homebrew formulae ..."
brew update

# --- Brew Bundle --------------------------------------------------------------

# Notes:
# - Removed 'tap "homebrew/cask"' (no longer necessary).
# - Replaced exa -> eza (exa is deprecated in Homebrew).
# - Removed cask "ksdiff" (discontinued upstream).
brew bundle --file=- <<'EOF'
tap "universal-ctags/universal-ctags"

# Unix
brew "universal-ctags", args: ["HEAD"]
brew "git"
brew "openssl"
brew "neovim"
brew "zsh"
brew "eza"
brew "ripgrep"
brew "ranger"
brew "fzf"
brew "bat"
brew "diff-so-fancy"
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
brew "pyenv"

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
cask "qlcolorcode"
EOF

# --- asdf setup ---------------------------------------------------------------

fancy_echo "Configuring asdf version manager ..."

# Ensure asdf is sourced in future shells (handles both Intel & Apple Silicon)
append_to_zshrc '[[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]] && source "$(brew --prefix asdf)/libexec/asdf.sh"' 1

# Source for current shell if present
if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
  # shellcheck disable=SC1090
  source "$(brew --prefix asdf)/libexec/asdf.sh"
fi

add_or_update_asdf_plugin() {
  local name="$1"
  local url="$2"
  if ! asdf plugin-list 2>/dev/null | grep -Fq "$name"; then
    asdf plugin add "$name" "$url"
  else
    asdf plugin update "$name"
  fi
}

add_or_update_asdf_plugin "ruby"  "https://github.com/asdf-vm/asdf-ruby.git"
add_or_update_asdf_plugin "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"

install_asdf_language() {
  local language="$1"
  local version
  version="$(asdf list-all "$language" | grep -E '^[0-9]|\.[0-9]' | grep -v '[a-zA-Z-]' | tail -1 || true)"
  if [ -n "${version:-}" ] && ! asdf list "$language" 2>/dev/null | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
}

# Parallelise Bundler installs sensibly if Bundler is present
if command -v bundle >/dev/null 2>&1; then
  number_of_cores="$(sysctl -n hw.ncpu || echo 2)"
  bundle config --global jobs "$(( number_of_cores > 1 ? number_of_cores - 1 : 1 ))"
fi

fancy_echo "Installing latest Node via asdf ..."
if command -v asdf >/dev/null 2>&1; then
  install_asdf_language "nodejs"
fi

fancy_echo "Done."

