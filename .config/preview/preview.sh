#!/usr/bin/env bash

FILENAME=$(echo "$1" | cut -f 2 | gsed -r 's/\.\./\./g')
LINE=$(echo "$1" | cut -f 3 | gsed -r 's/;"//g')
PREV_COMMAND=$FZF_PREVIEW_COMMAND
FZF_PREVIEW_COMMAND="bat --theme='OneHalfDark' --style=numbers,changes --color always {}"
export FZF_PREVIEW_COMMAND
/Users/$USER/.config/nvim/plugged/fzf.vim/bin/preview.sh "$FILENAME":"$LINE"
FZF_PREVIEW_COMMAND=$PREV_COMMAND
export FZF_PREVIEW_COMMAND

