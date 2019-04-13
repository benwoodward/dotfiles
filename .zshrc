# TODO:
# - Comment plugins with descriptions
# - Remove unused zsh options once I know what they do

TERM=xterm-256color

# Read the API token from the macOS Keychain
# To add: security add-generic-password -a "$USER" -s 'hub github token' -w 'TOKEN GOES HERE'
# Use lowercase name to avoid issues with `find-generic-password` not finding it
export GITHUB_TOKEN=$(security find-generic-password -s 'hub github token' -w)

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/Users/ben/bin

# rbenv initialisation
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  # export EDITOR='nvim -f --nomru -c "au VimLeave * !open -a iTerm-nightly"'
fi
# export EDITOR='sublime -w'
# export VISUAL='sublime -w'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Personal aliases, overriding those provided by oh-my-zsh libs,
alias zshconfig="nvim ~/.zshrc"
alias reload="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias g='git'
alias ll='ls -al'

# list recent directories
alias lsr='ls -td -- */ | head -n 5'

# list recently modified files recursively
alias recent-files-recursive="find . -exec stat -f '%m%t%Sm %N' {} + | sort -n | cut -f2- | head -n 50"

# go to repo root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'

alias b='bundle'
alias bi='bundle install'
alias be='b exec'

# TODO This should show hidden directories also
alias recent="mdls -name kMDItemFSName -name kMDItemDateAdded -raw * | \
xargs -0 -I {} echo {} | \
sed 'N;s/\n/ /' | \
sort"

alias tag-gems='ctags --recurse . `bundle show --paths`'
alias ssh='TERM=xterm-256color ssh'
alias nvimconfig='nvim ~/.config/nvim/init.vim'
alias add-vim-tip='nvim ~/.config/nvim/init.vim +554' # Add a vim-tip as Startify header quote

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "lukechilds/zsh-nvm"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug 'zsh-users/zsh-autosuggestions'
# zplug 'wfxr/forgit'

zplug load

# https://github.com/sindresorhus/pure#install
autoload -U promptinit; promptinit
prompt pure

# activate vi modes and display mode indicator in prompt
source ~/.zshrc.vimode

movtogif () {
    ffmpeg -i "$1" -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - |\
    convert -delay 5 -layers Optimize -loop 0 - "$2"
}

# Prepare Ghost theme for upload
zi() {
  ghost_theme=${PWD##*/}
  cd ..
  cp -R $ghost_theme $ghost_theme-nogit
  rm -rf $ghost_theme-nogit/.git
  rm $ghost_theme.zip
  zip -r -X $ghost_theme.zip $ghost_theme-nogit
  rm -rf $ghost_theme-nogit
  zip_dir=${PWD}
  cd $ghost_theme
  open https://$ghost_theme/ghost/\#/settings/design/uploadtheme
  open $zip_dir
}

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# zplugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"


setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

setopt auto_cd # cd by typing directory name if it's not a command

# setopt correct_all # autocorrect commands

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# History completion
zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history

# Display message when no matches are found
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# fh - fuzzy search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fd - fuzzy search recursive directories, and cd to into selected
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# ch - browse chrome history
ch() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Profile\ 4/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

# https://github.com/zsh-users/zsh-autosuggestions autocomplete word by word
bindkey '^e' forward-word
bindkey '^ ' autosuggest-accept                   # ctrl+space (or right arrow)

# completion
bindkey "^[[Z" reverse-menu-complete                        # shift-tab - move through the completion menu backwards
bindkey -M menuselect '^n' accept-and-infer-next-history    # completion - accept and try next mach i.e subdirectory


# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tree-better() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
tree-better-dirs() {
  tree -dC -a -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
    # -a show hidden dirs
}

rm-symlink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

path-print() {
  echo -e ${PATH//:/\\n}
}

# List the names of passwords saved to Keychain with `security add-generic-password`
list-keychain-passwords() {
  security dump-keychain | grep 0x00000007 | awk -F= '{print $2}'
}
