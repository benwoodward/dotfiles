# TODO:
# - Comment plugins with descriptions
# - Remove unused zsh options once I know what they do

# This doesn't really work, alternative solution is maybe to edit
# the postgres brew file with `brew edit postgres`, change the
# path for the directories stored in /usr/local/share/zsh so
# Homebrew stops complaining about their status
# https://github.com/robbyrussell/oh-my-zsh/issues/6939#issuecomment-484750107
ZSH_DISABLE_COMPFIX=true

TERM=xterm-256color

# Read the API token from the macOS Keychain
# To add: security add-generic-password -a "$USER" -s 'hub github token' -w 'TOKEN GOES HERE'
# Use lowercase name to avoid issues with `find-generic-password` not finding it
export GITHUB_TOKEN=$(security find-generic-password -s 'hub github token' -w)
export POSTGRES_DATABASE=$(security find-generic-password -s 'postgres database' -w)
export POSTGRES_USERNAME=$(security find-generic-password -s 'postgres username' -w)
export POSTGRES_PASSWORD=$(security find-generic-password -s 'postgres password' -w)
export REALM_ADMIN_USERNAME=$(security find-generic-password -s 'realm admin username' -w)
export REALM_ADMIN_PASSWORD=$(security find-generic-password -s 'realm admin password' -w)
export BENW_DEMO_GMAIL_PASSWORD=$(security find-generic-password -s 'benw.demo password' -w)

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/Users/$(whoami)/bin

# rbenv initialisation
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# https://blog.jez.io/cli-code-review/
export REVIEW_BASE='master'

# Load completions, must happen before loading oh-my-zsh.sh because
# it calls compinit
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  # export EDITOR='nvim -f --nomru -c "au VimLeave * !open -a iTerm-nightly"'
fi

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


# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "lukechilds/zsh-nvm"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug 'zsh-users/zsh-autosuggestions'
# zplug 'wfxr/forgit'
zplug "changyuheng/fz", defer:2
zplug "rupa/z", use:z.sh
zplug "djui/alias-tips"
zplug "kiurchv/asdf.plugin.zsh", defer:2
zplug "supercrabtree/k"
zplug "MichaelAquilina/zsh-you-should-use"

# zplug "hschne/fzf-git"

zplug load

# https://github.com/sindresorhus/pure#install
autoload -U promptinit; promptinit
prompt pure

# activate vi modes and display mode indicator in prompt
source ~/.zshrc.vimode

# Load asdf version manager
source /Users/$(whoami)/.asdf/asdf.sh

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

export FZ_CMD=z


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

# fhc - fuzzy search in your command history and copy selected command
fhc() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//' | pbcopy
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

# From https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Select file from git status
gfi() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf --height 40% --reverse -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# Select commit from git history
gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --height 50% --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# A helper function to join multi-line output from fzf
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-gfi-widget() { local result=$(gfi | join-lines); zle reset-prompt; LBUFFER+=$result }
fzf-gh-widget()  { local result=$(gh  | join-lines); zle reset-prompt; LBUFFER+=$result }
zle -N fzf-gfi-widget
zle -N fzf-gh-widget
bindkey '^gf' fzf-gfi-widget
bindkey '^gh' fzf-gh-widget

# https://github.com/zsh-users/zsh-autosuggestions autocomplete word by word
bindkey '^e' forward-word
bindkey '^r' autosuggest-accept # ctrl+r

# completion
bindkey "^[[Z" reverse-menu-complete                        # shift-tab - move through the completion menu backwards
bindkey -M menuselect '^n' accept-and-infer-next-history    # completion - accept and try next mach i.e subdirectory

# Fn-Up/Down arrow (PgUp/PgDown)
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

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

# https://superuser.com/a/451519/1021429
# Look up bundle id for app (app name isn't always what's displayed in Menu Bar
# bundle-id iTerm
# returns: com.googlecode.iterm2
bundle-id() {
  a="$1";
  a="${a//\'/\'}.app";
  a=${a//"/\\"};
  a=${a//\\/\\\\};
  mdls -name kMDItemCFBundleIdentifier -raw "$(mdfind 'kMDItemContentType==com.apple.application-bundle&&kMDItemFSName=="'"$a"'"c' | head -n1)"
}

fix_brew_permissions() {
  # Make /usr/local writable
  sudo chmod -R g+rwx $(brew --prefix)/*(D)
  # sudo chmod -R g+rwx /usr/local/share/zsh

  # Make it usable for multiple users (anyone in custom 'brew' group)
  # sudo chgrp -R brew $(brew --prefix)/*(D)
  # sudo chown -R root $(brew --prefix)/*(D)
  # sudo chown -R root /usr/local/share/zsh
}


