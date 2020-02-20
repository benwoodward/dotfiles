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
export VIMIFY_SPOTIFY_TOKEN=$(security find-generic-password -s 'vimify spotify token' -w)
export GIST_ID=$(security find-generic-password -s 'things-gist-id' -w)
export GITHUB_THINGS_TOKEN=$(security find-generic-password -s 'github-things-token' -w)
export SECRET_KEY_BASE=$(security find-generic-password -s 'secret-key-base')

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/Users/$(whoami)/bin


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
alias n="nvim"
alias nn="nvim ."
alias ne="nvim '+call FzfFilePreview()' ."
alias nnc='nvim ~/.config/nvim/init.vim'
alias zc="nvim ~/.zshrc"
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


# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "lukechilds/zsh-nvm"
zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, at:indestructible-pure, as:theme
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug 'zsh-users/zsh-autosuggestions', from:github, at:fixes/partial-accept-duplicate-word
# zplug 'wfxr/forgit'
zplug "changyuheng/fz", defer:2
zplug "rupa/z", use:z.sh
zplug "kiurchv/asdf.plugin.zsh", defer:2
zplug "supercrabtree/k"
zplug "zpm-zsh/ls"
zplug "zpm-zsh/dircolors-material"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh
zplug "jimhester/per-directory-history", defer:1
if zplug check "jimhester/per-directory-history"; then
    HISTORY_BASE="${HOME}/.zsh_histories"
    SAVEHIST=65535
fi
ENHANCD_FILTER=fzf

# Disabled until I figure out these errors:
#
# _zsh_prioritize_cwd_history_cwd_hist_entries:9: command not found: #
# _zsh_prioritize_cwd_history_cwd_hist_entries:12: command not found: #
# _zsh_prioritize_cwd_history_cwd_hist_entries:15: command not found: #
#
# zplug "ericfreese/zsh-prioritize-cwd-history"

# zplug "hschne/fzf-git"

zplug load

# activate vi modes and display mode indicator in prompt
source ~/.zshrc.vimode

# Load asdf version manager
source /Users/$(whoami)/.asdf/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Include git information in FZF preview
export FZF_PREVIEW_COMMAND='(bat --style=numbers,changes,header --color=always --wrap=never {})'


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff"
ZSH_AUTOSUGGEST_STRATEGY=(history)

export FZ_CMD=z


setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

setopt ignore_eof # don't kill session on ctrl-d

no-op() {
}
zle -N no-op no-op
bindkey "^d" no-op

setopt auto_cd # cd by typing directory name if it's not a command

# setopt correct_all # autocorrect commands

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


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

# bh - browse brave history
bh() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  cp -f ~/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/History /tmp/h

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

# https://github.com/zsh-users/zsh-autosuggestions autocomplete word by word
bindkey '^e' forward-word
bindkey '^l' autosuggest-accept

# completion
bindkey "^[[Z" reverse-menu-complete                        # shift-tab - move through the completion menu backwards

bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

bindkey -r "^j"

HISTORY_START_WITH_GLOBAL=false

per-directory-history-edit() {
    ${EDITOR} ${HISTORY_BASE}/$(realpath ${PWD})/history
}
zle -N per-directory-history-edit

pick-from-other-history() {
    per-directory-history-toggle-history
    fzf-history-widget
    per-directory-history-toggle-history
}
zle -N pick-from-other-history

bindkey "]e" per-directory-history-edit
bindkey "^r" pick-from-other-history

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

# https://gist.github.com/igrigorik/6666860
# git browse
gb() {
  open $(git config remote.origin.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")/$1$2$3
}

# Open current branch
alias gbb='gb tree/$(git symbolic-ref --quiet --short HEAD )'

# Open current directory/file in current branch
alias gbbf='gb tree/$(git symbolic-ref --quiet --short HEAD )/$(git rev-parse --show-prefix)'

# Open current directory/file in master branch
alias gbmf='gb tree/master/$(git rev-parse --show-prefix)'

DISABLE_AUTO_TITLE="true"
tab_title() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}
add-zsh-hook precmd tab_title

node-project() {
  git init
  npx license $(npm get init.license) -o "$(npm get init.author.name)" > LICENSE
  npx gitignore node
  npx covgen "$(npm get init.author.email)"
  npm init -y
  git add -A
  git commit -m "Initial commit"
}

# Prints file_name + line number for every hunk in a diff
# Example output:
#
# .gitconfig 19
# .gitignore 4
# .zshrc 18
# .zshrc 369
hunk-lines() {
    local file_path=
    local line_number=
    local output=
    zmodload -s -F zsh/pcre C:pcre-match && setopt re_match_pcre

    while read; do
        esc=$'\033'
        if [[ $REPLY =~ '---\ (a/)?.*' ]]; then
            continue
        elif [[ $REPLY =~ '^\+\+\+\ (b\/)?([^\t]+.*)' ]]; then
            file_path=${match[2]}
        elif [[ $REPLY =~ '@@\ -([0-9]*)+(,[0-9]+)?\ \+([0-9]+)(,[0-9]+)?\ @@.*' ]]; then
            line_number=${match[1]}
            if [ -z "$output" ]; then
              output="${file_path} ${line_number}"
            else
              output="${output}\n${file_path} ${line_number}"
            fi
        fi
    done

    echo "${output}"
}

_stage_hunk="git diff | filterdiff --lines={+2} -i 'a/{+1}' | echo"

hunk-diff() {
  git diff \
  | hunk-lines \
  | fzf --no-sort --reverse \
    --preview 'git diff --unified=8 {+1} | filterdiff --lines={+2} | colordiff | sed "s/0;//g" | diff-so-fancy' \
    --preview-window=right:60%:wrap \
    --bind=ctrl-e:preview-down --bind=ctrl-y:preview-up \
    --bind=ctrl-d:preview-page-down --bind=ctrl-u:preview-page-up \
    --bind "enter:execute:(echo {} | git diff --unified=8 {+1} | filterdiff --lines={+2} -i 'a/{+1}' | git apply --cached --whitespace=nowarn)"
}

hd() {
  hunk-diff
}

source /Users/ben/Library/Preferences/org.dystroy.broot/launcher/bash/br



# Theme for fzf
# Base16 Chalk
# Author: Chris Kempson (http://chriskempson.com)

_gen_fzf_default_opts() {

local color00='#1B2B34'
local color01='#343D46'
local color02='#4F5B66'
local color03='#65737E'
local color04='#A7ADBA'
local color05='#C0C5CE'
local color06='#CDD3DE'
local color07='#D8DEE9'
local color08='#EC5f67'
local color09='#F99157'
local color0A='#FAC863'
local color0B='#99C794'
local color0C='#5FB3B3'
local color0D='#6699CC'
local color0E='#C594C5'
local color0F='#AB7967'

export FZF_DEFAULT_OPTS="
  --black
  --border
  --color=bg+:$color00,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

}

_gen_fzf_default_opts

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
