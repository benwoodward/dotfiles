### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
### End of Zinit's installer chunk

# Advanced auto-completion
zinit light-mode for atload'source ~/.p10k.zsh' romkatv/powerlevel10k

# Command-line syntax highlighting
# Must be AFTER after all calls to `compdef`, `zle -N` or `zle -C`.
zinit light-mode for zdharma/fast-syntax-highlighting

zinit light-mode for 'zsh-users/zsh-autosuggestions'
zinit light-mode for rupa/z
zinit light-mode for changyuheng/fz
zinit light-mode for kiurchv/asdf.plugin.zsh
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
export SECRET_KEY_BASE=$(security find-generic-password -s 'secret-key-base' -w)
export MAILGUN_API_KEY=$(security find-generic-password -s 'mailgun-api-key' -w)
export SONOS_CLIENT_ID=$(security find-generic-password -s 'sonos-client-id' -w)
export SONOS_CLIENT_SECRET=$(security find-generic-password -s 'sonos-client-secret' -w)

# Personal aliases
alias nt="nvim -cStart"
alias n="nvim"
alias nn="nvim ."
alias ne="nvim '+call FzfFilePreview()' ."
alias nl="nvim '+FloatermNew lf' ."
alias vc='nvim ~/.config/nvim/init.vim'
alias zc="nvim ~/.zshrc"
alias gc="nvim ~/.gitconfig"
alias reload="exec zsh"
alias g='git'
alias ls='exa'
alias ll='exa -l'
alias lll='exa -l | less'
alias lla='exa -la'
alias llt='exa -T'
alias llfu='exa -bghHliS --git'

# list recursive files, ordered by creation date
alias lsr="find . -type f -not \( -wholename './.git*' -prune \) -not \( -wholename './tags*' -prune \) -exec ls -lTU {} \; | sort -k 6 | rev | cut -d ' ' -f 1,2,4,5 | rev"
alias lsrs="find . -type f -not \( -wholename './.git*' -prune \) -not \( -wholename './tags*' -prune \) -exec ls -lTU {} \; | sort -k 6 -r | rev | cut -d ' ' -f 1,2,4,5 | rev"

# Open current branch
alias gbb='gb tree/$(git symbolic-ref --quiet --short HEAD )'

# Open current directory/file in current branch
alias gbbf='gb tree/$(git symbolic-ref --quiet --short HEAD )/$(git rev-parse --show-prefix)'

# Open current directory/file in master branch
alias gbmf='gb tree/master/$(git rev-parse --show-prefix)'

relative-date() {
  while read input_string; do
    local file_path=`echo $input_string | cut -d ' ' -f 5`
    local ls_date=`echo $input_string | cut -d ' ' -f 1,2,3,4`
    # Accepts date in format found in `ls` output, and converts to epoch
    local date="$(date -j -f "%d %b %H:%M:%S %Y" "$ls_date" +"%s")"
    local now="$(date +"%s")"
    local time_diff=$((now - date))

    if ((time_diff > 24*60*60)); then
      date_string=`printf "%.0f days ago" time_diff/((24*60*60))`
    elif ((time_diff > 60*60)); then
      date_string=`printf "%.0f hours ago" time_diff/((60*60))`;
    elif ((time_diff > 60)); then
      date_string=`printf "%.0f minutes ago" time_diff/60`;
    else
      date_string=`printf "%s seconds ago" $time_diff`;
    fi

    date_string=${(r:18:)date_string}

    echo "$date:$date_string:\e[32m$file_path\e[m\n"
  done
}
zle -N relative-date

function list-new-files() {
  find . -type f \
    -not \( -wholename './.git*' -prune \) \
    -not \( -wholename './tags*' -prune \) \
    -exec ls -lTU {} \; | rev | cut -d ' ' -f 1,2,3,4,5 | rev | relative-date \
      | sort -k 1 -r \
      | rev \
      | cut -d ':' -f 1,2 \
      | rev \
      | sed 's/://g'
}
zle -N list-new-files

function new-files() {
if [ "$1" != "" ]
then
  list-new-files | head -n "$1"
else
  list-new-files
fi
}

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



autoload -U select-word-style
select-word-style bash

# activate vi modes and display mode indicator in prompt
source ~/.zshrc.vimode

# Load asdf version manager
source /Users/$(whoami)/.asdf/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Include git information in FZF preview
export FZF_PREVIEW_COMMAND='(bat --style=numbers,changes --color=always --wrap=never {})'
export BAT_STYLE=changes,header,grid
export FZF_DEFAULT_COMMAND='rg --files --hidden --iglob "!.DS_Store" --iglob "!.git"'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

TERM=xterm-256color
ZSH_AUTOSUGGEST_STRATEGY=(history)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

DISABLE_AUTO_TITLE="true"
tab_title() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}
add-zsh-hook precmd tab_title

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
  --preview-window='right:70%'
  --bind ctrl-e:preview-down,ctrl-y:preview-up,ctrl-u:preview-page-up,ctrl-d:preview-page-down,tab:toggle+up,shift-tab:toggle+down
"

}

_gen_fzf_default_opts



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

# https://github.com/zsh-users/zsh-autosuggestions autocomplete word by word
bindkey '^E' forward-word
bindkey '^B' backward-kill-word
bindkey '^L' autosuggest-accept

# completion
bindkey "^[[Z" reverse-menu-complete                        # shift-tab - move through the completion menu backwards

bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

bindkey -r "^j"

no-op() {
}
zle -N no-op no-op
bindkey "^d" no-op

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

