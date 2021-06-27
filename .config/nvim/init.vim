lua << EOF
-- require'lsp-config'
EOF

" TODO:
" - Group settings/configs, functions, mappings etc.
"   - Modularise into files

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin()

""
"" Section: Editing
""

" Switches between a single-line statement and a multi-line one
Plug 'https://github.com/AndrewRadev/splitjoin.vim.git', {'branch': 'master'}
  nmap <Leader>sj :SplitjoinSplit<cr>
  nmap <Leader>sk :SplitjoinJoin<cr>

" Emmet for Vim, make HTML without going mad
Plug 'https://github.com/mattn/emmet-vim.git', { 'for': ['html', 'vue', 'javascript', 'css', 'svelte'] }
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

" Alignment plugin with smart key bindings
Plug 'https://github.com/junegunn/vim-easy-align.git'
  " Key bindings:
  " ga
  "
  " vipga=
  "   - visual-select inner paragraph
  "   - Start EasyAlign command (ga)
  "   - Align around =
  "
  " gaip=
  "   - Start EasyAlign command (ga) for inner paragraph
  "   - Align around =



""
"" Section: Syntax Tools
""

Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/HerringtonDarkholme/yats.vim'

Plug 'https://github.com/vim-ruby/vim-ruby.git', { 'for': ['rb']} " Ruby syntax highlighting
Plug 'https://github.com/henrik/vim-ruby-runner'
" Plug 'https://github.com/othree/yajs.vim'           " Most up to date JS highlighter, works well with React
Plug 'https://github.com/othree/html5.vim'          " html5 syntax highlighting
" Plug 'https://github.com/maxmellon/vim-jsx-pretty'  " Jsx syntax highlighting
" Plug 'https://github.com/maksimr/vim-jsbeautify'
Plug 'https://github.com/mhartington/oceanic-next', {'commit': '08158eec24cd154afd1623686aeb336fad580be7'}  " Best dark colorscheme
Plug 'https://github.com/rakr/vim-one'              " Light colorscheme
Plug 'https://github.com/timakro/vim-searchant'     " Highlight search result under cursor
Plug 'https://github.com/elixir-editors/vim-elixir' " Elixir syntax highlighting
" Plug 'https://github.com/sbdchd/neoformat'          " Multi-language formatter. TODO: Check whether I can remove other beautifiers

autocmd FileType svelte setlocal formatoptions+=ro " Start a new line with comment string
Plug 'evanleck/vim-svelte', {'branch': 'main'}
let g:svelte_indent_script = 1
let g:svelte_indent_style = 0

Plug 'https://github.com/mhinz/vim-mix-format'      " Auto-format Elixir code with `mix format` on save
" Plug 'https://github.com/plasticboy/vim-markdown', { 'for': ['md', 'markdown']} " Markdown highlighting
"   let g:vim_markdown_folding_disabled = 1

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'https://github.com/chrisbra/Colorizer'
" :ColorToggle

Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/hrsh7th/vim-vsnip-integ'
Plug 'https://github.com/hrsh7th/nvim-compe'
Plug 'https://github.com/glepnir/lspsaga.nvim'

" Intellisense for Neovim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"   let g:coc_global_extensions = [
"         \ 'coc-eslint', 'coc-prettier',
"         \ 'coc-json', 'coc-yaml',
"         \ 'coc-snippets', 'coc-elixir', 'coc-svelte'
"         \ ]
"   let g:coc_snippet_next = '<C-n>' " Use <C-j> for jump to next placeholder, it's default of coc.nvim
"   let g:coc_snippet_prev = '<C-p>' " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"   " Use <C-j> and <C-k> to navigate the completion list
"   inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
"   inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
"   " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"   " Coc only does snippet and additional edit on confirm.
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"   set cmdheight=2 " Better display for messages
"   set updatetime=200 " Smaller updatetime for CursorHold & CursorHoldI
"   set shortmess+=c " don't give |ins-completion-menu| messages.
"   set signcolumn=yes " always show signcolumns
"   " Use `lp` and `ln` for navigate diagnostics
"   nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
"   nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
"   nmap <silent> <leader>pe <Plug>(coc-diagnostic-prev-error)
"   nmap <silent> <leader>ne <Plug>(coc-diagnostic-next-error)
"   " Remap keys for gotos
"   nmap <silent> <leader>ld <Plug>(coc-definition)
"   nmap <silent> <leader>lt <Plug>(coc-type-definition)
"   nmap <silent> <leader>li <Plug>(coc-implementation)
"   nmap <silent> <leader>lf <Plug>(coc-references)
"   " Use K for show documentation in preview window
"   nnoremap <silent> K :call <SID>show_documentation()<CR>

"   function! s:show_documentation()
"     if &filetype == 'vim'
"       execute 'h '.expand('<cword>')
"     else
"       call CocAction('doHover')
"     endif
"   endfunction

"   " Fix current line
"   nmap <Leader>qf <Plug>(coc-fix-current)
"   vmap <leader>fs <Plug>(coc-format-selected)
"   nmap <leader>fs <Plug>(coc-format-selected)
"   nmap <Leader>rn <Plug>(coc-rename)
"   nmap <Leader>gd <Plug>(coc-definition)
"   " Auto-scroll floating window
"   " nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
"   nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

Plug 'https://github.com/stephpy/vim-yaml.git', { 'for': ['yaml.yml'] } " YAML hightlighting
Plug 'https://github.com/elzr/vim-json.git', { 'for': ['json']}         " JSON highlighter
Plug 'https://github.com/bronson/vim-trailing-whitespace.git'           " Highlights trailing whitespace characters in red


""
"" Section: Interface enhancements
""
Plug 'https://github.com/brooth/far.vim'
Plug 'https://github.com/soywod/himalaya', {'rtp': 'vim'} " Use himalaya CLI gmail client via Vim
nmap gw <plug>(himalaya-msg-write)
nmap gr <plug>(himalaya-msg-reply)
nmap gR <plug>(himalaya-msg-reply-all)
nmap gf <plug>(himalaya-msg-forward)
nmap ga <plug>(himalaya-msg-attachments)
nmap gC <plug>(himalaya-msg-copy)
nmap gM <plug>(himalaya-msg-move)
nmap gD <plug>(himalaya-msg-delete)

Plug 'https://github.com/AndrewRadev/switch.vim'
nnoremap <leader>ta :Switch<CR>

" === Vim airline ==== "
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/danilamihailov/beacon.nvim'
Plug 'https://github.com/itchyny/vim-cursorword'
Plug 'https://github.com/dhruvasagar/vim-zoom'
" <C-W>m to toggle zoom in and out for the split

fun! Startscreen()
  " Don't run if:
  " - there are commandline arguments;
  " - the buffer isn't empty (e.g. cmd | vi -);
  " - we're not invoked as vim or gvim;
  " - we're starting in insert mode.
  if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
    return
  endif

  " Start a new buffer...
  enew

  " ...and set some options for it
  setlocal
    \ bufhidden=wipe
    \ buftype=nofile
    \ nobuflisted
    \ nocursorcolumn
    \ nocursorline
    \ nolist
    \ nonumber
    \ noswapfile
    \ norelativenumber


  e ~/.config/nvim/files/vim_tips.md
  set buftype=
  set filetype=markdown.pandoc
  set concealcursor=n
  set wrap
  let linenumber = execute(':ruby puts Random.rand(287)')
  execute ":" . linenumber
endfun

command! Start call Startscreen()

Plug 'https://github.com/justinmk/vim-sneak'
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" Plug 'https://github.com/unblevable/quick-scope'
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

Plug 'https://github.com/andrewradev/sideways.vim'
nnoremap msl :SidewaysLeft<cr>
nnoremap msr :SidewaysRight<cr>
Plug 'https://github.com/matze/vim-move'
let g:move_map_keys = 0
vmap <c-h> <Plug>MoveBlockLeft
vmap <c-l> <Plug>MoveBlockRight

nmap <c-h> <Plug>MoveLineLeft
nmap <c-l> <Plug>MoveLineRight

vmap <c-j> <Plug>MoveBlockDown
vmap <c-k> <Plug>MoveBlockUp

nmap <c-j> <Plug>MoveLineDown
nmap <c-k> <Plug>MoveLineUp

Plug 'https://github.com/janko/vim-test'
Plug 'https://github.com/bfredl/nvim-miniyank'

function FZFYankList() abort
  function! KeyValue(key, val)
    let line = join(a:val[0], '')
    if (a:val[1] ==# 'V')
      let line = line
    endif
    return a:key.' '.line
  endfunction
  return map(miniyank#read(), function('KeyValue'))
endfunction

function FZFYankHandler(opt, line) abort
  let key = substitute(a:line, ' .*', '', '')
  if !empty(a:line)
    let yanks = miniyank#read()[key]
    call miniyank#drop(yanks, a:opt)
  endif
endfunction

command! YanksAfter call fzf#run(fzf#wrap('YanksAfter', {
\ 'source':  FZFYankList(),
\ 'sink':    function('FZFYankHandler', ['p']),
\ 'options': '--no-sort --no-preview --prompt="Yanks-p> "',
\ }))

command! YanksBefore call fzf#run(fzf#wrap('YanksBefore', {
\ 'source':  FZFYankList(),
\ 'sink':    function('FZFYankHandler', ['P']),
\ 'options': '--no-sort --no-preview --prompt="Yanks-P> "',
\ }))


map <leader>ya :YanksAfter<CR>
map <leader>yb :YanksBefore<CR>

" Plug 'https://github.com/svermeulen/vim-yoink'
"   nmap ny <plug>(YoinkPostPasteSwapBack)
"   nmap py <plug>(YoinkPostPasteSwapForward)

"   " nmap p <plug>(YoinkPaste_p)

"   nmap p <plug>(YoinkPaste_P)
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/tyru/open-browser.vim'
" Plug 'https://github.com/farmergreg/vim-lastplace' " Open file at last place edited
Plug 'https://github.com/zhimsel/vim-stay'
" Run :CleanViewdir if having current working dir weirdness problems
let g:lastplace_ignore_buftype = "quickfix,nofile,help"
set viewoptions=cursor,folds,slash,unix " XXX: Important!
set viewoptions-=options " XXX: Important!

Plug 'https://github.com/rhysd/git-messenger.vim' " Show git blame for current line in floating window
  " <Leader>gm
  " q Close the popup window
  " o older. Back to older commit at the line
  " O Opposite to o. Forward to newer commit at the line
  " d Toggle diff hunks only related to current file in the commit
  " D Toggle all diff hunks in the commit
  " ? Show mappings help


" Alternative to git-gutter, display git status for modified lines in gutter
" Plug 'https://github.com/mhinz/vim-signify'
  " `+`     This line was added.
  " `!`     This line was modified.
  " `_1`    The number of deleted lines below this sign. If the number is larger
  " `99`    than 9, the `_` will be omitted. For numbers larger than 99, `_>`
  " `_>`    will be shown instead.
  " `!1`    This line was modified and the lines below were deleted.
  " `!>`    It is a combination of `!` and `_`. If the number is larger than 9,
  "       `!>` will be shown instead.
  " `‾`     The first line was removed. It's a special case of the `_` sign.
  "
  " Key bindings:
  " ]c   Jump to the next hunk.
  " [c   Jump to the previous hunk.

  " ]C   Jump to the last hunk.
  " [C   Jump to the first hunk.
Plug 'https://github.com/airblade/vim-gitgutter'
  " <leader>hu " Undo hunk
  function! GitGutterNextHunkCycle()
    let line = line('.')
    silent! GitGutterNextHunk
    if line('.') == line
      1
      GitGutterNextHunk
    endif
  endfunction

  nmap ]h :call GitGutterNextHunkCycle()<CR>
  nmap [h <Plug>(GitGutterPrevHunk)
  nnoremap <leader>gg :let g:gitgutter_diff_base='HEAD~'<CR>
  nnoremap <leader>ggm :let g:gitgutter_diff_base='master'<CR>
  nnoremap <leader>ggh :let g:gitgutter_diff_base=''<CR>

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'oguzbilgic/vim-gdiff'
  " Quickfix motions
  nnoremap [q :cprevious<cr>
  nnoremap ]q :cnext<cr>
  nnoremap [Q :cfirst<cr>
  nnoremap ]Q :clast<cr>

" Notes:
" :GFiles? / :GF? will list modified files
function! CodeReview()
  let g:gitgutter_diff_base='master'
  :Gdiff master...
  :GitGutter
endfunction

nnoremap <leader>cr :call CodeReview()<CR>


let loaded_netrw = 0

Plug 'https://github.com/henrik/vim-reveal-in-finder.git' " Reveal current file in Finder
  " :Reveal

" Terminal in floating window
Plug 'https://github.com/voldikss/vim-floaterm'
  nnoremap <leader>fs :FloatermNew ranger<CR>
  " Key bindings:
  " fn F12

" Auto-hides search highlights when not needed
Plug 'https://github.com/haya14busa/incsearch.vim'
  let g:incsearch#auto_nohlsearch                   = 1 " auto unhighlight after searching
  let g:incsearch#do_not_save_error_message_history = 1 " do not store incsearch errors in history
  let g:incsearch#consistent_n_direction            = 1 " when searching backward, do not invert meaning of n and N
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)


Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/mattn/webapi-vim' " Required by gist-vim
Plug 'https://github.com/mattn/gist-vim' " Post selected code to Gist
Plug 'https://github.com/ruanyl/vim-gh-line' " Open current file at current line on Github
" Default key mapping for a blob view: <leader>gh
" Default key mapping for a blame view: <leader>gb
" Default key mapping for repo view: <leader>go
" Open latest commit in browser
map <Leader>lc :Gbrowse HEAD^{}<CR>

" Open current file at HEAD in browser
map <Leader>flc :Gbrowse HEAD^{}:%<CR>

Plug 'zegervdv/nrpattern.nvim' " A Neovim plugin to expand the number formats supported to increment or decrement.
Plug 'https://github.com/voldikss/vim-searchme' " Search under cursor with options
  " vim-search-me
  nmap <silent> <Leader>s <Plug>SearchNormal
  vmap <silent> <Leader>s <Plug>SearchVisual
  " Select text and type <Leader>s to do a web search
  " <leader>saw in to search web for a word
  " <leader>sa( to search web for the text wrapped in the bracket
  " <leader>sas to search web for a sentence
" Plug 'https://github.com/prabirshrestha/async.vim' " TODO: Do I need this?
" Plug 'https://github.com/HendrikPetertje/vimify'
" Plug 'https://github.com/benwoodward/vimify', { 'branch': 'playlists' }
Plug '~/dev/oss/Forks/vim-plugins/vimify'
  noremap <leader>sp :SpPlaylists<CR>

Plug 'https://github.com/tpope/vim-commentary/'
" Modifies commentstring dynamically, makes commenting possible in multi-language files like components
Plug 'https://github.com/npearson72/vim-context-commentstring'

Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = './.fzf-history'
Plug 'pbogut/fzf-mru.vim'
let g:fzf_mru_no_sort = 1

  "" FZF

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Some ripgrep searching defaults
function! RgCommand(ignore, current_file) abort
  let glob = '--glob ' . expand("%:t") " exclude current file
  return 'rg' .
    \ ' --hidden' .
    \ ' --color=always' .
    \ ' --colors "path:fg:190,220,255"' .
    \ ' --colors "line:fg:128,128,128" ' .
    \ ' --column' .
    \ ' --line-number' .
    \ ' --no-heading' .
    \ ' --smart-case' .
    \ ' ' . (a:current_file == 1 ? glob : '') .
    \ ' ' . (a:ignore == 1 ? '--ignore' : '--no-ignore')
endfunction

" Adds prompt
function! PreviewFlags(prompt) abort
  return ' --prompt="' . a:prompt . '> "'
endfunction

" Ensure that only the 4th column delimited by : is filtered by FZF
function! RgPreviewFlags(prompt) abort
  return PreviewFlags(a:prompt) . ' --delimiter : --nth 4.. --color hl:123,hl+:222 '
endfunction

" Configs the preview
function! Preview(flags) abort
  return fzf#vim#with_preview({'options': a:flags}, 'up:70%:noborder')
endfunction

" Executes ripgrep with a preview
function! RgWithPreview(ignore, args, prompt, bang) abort
  let command = RgCommand(a:ignore, v:false).' '.shellescape(a:args)
  call fzf#vim#grep(command, 1, Preview(RgPreviewFlags(a:prompt)), a:bang)
endfunction

function! RgCurrentFileWithPreview(ignore, args, prompt, bang) abort
  let command = RgCommand(a:ignore, v:true).' '.shellescape(a:args)
  call fzf#vim#grep(command, 1, Preview(RgPreviewFlags(a:prompt)), a:bang)
endfunction

" Defines search command for :Files
let $FZF_DEFAULT_COMMAND='rg --files --hidden --iglob "!.DS_Store" --iglob "!.git" --iglob "!node_modules"'

" Opens files search with preview
function! FilesWithPreview(args, bang) abort
  call fzf#vim#files(a:args, Preview(PreviewFlags('Files')), a:bang)
endfunction

command! -bang -nargs=* Rg call RgWithPreview(v:true, <q-args>, 'Grep', <bang>0)
command! -bang -nargs=* Rgcf call RgCurrentFileWithPreview(v:true, <q-args>, 'Grep', <bang>0)
command! -bang -nargs=* Rgg call RgWithPreview(v:false, <q-args>, 'Global Grep', <bang>0)
command! -bang -nargs=? -complete=dir Files call FilesWithPreview(<q-args>, <bang>0)

" Don't use status line in FZF
augroup FzfConfig
  autocmd!
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 noshowmode noruler
augroup END

" Default FZF options with bindings to match layout and select all + none
let $FZF_DEFAULT_OPTS = '--layout=default --reverse' .
  \ ' --info inline' .
  \ ' --bind ctrl-e:preview-down,ctrl-y:preview-up,ctrl-u:preview-page-up,ctrl-d:preview-page-down,tab:toggle+up,shift-tab:toggle+down' .
  \ ' --preview "bat --theme="OneHalfDark" --style=changes,grid --color always {2..-1} | head -200" --expect=ctrl-v,ctrl-x'

let preview_file = '/Users/' . $USER . '/.config/preview/preview.sh'
command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \      'window': 'call FloatingFZF()',
  \      'options': '
  \         --with-nth 1,2
  \         --prompt "Tags> "
  \         --preview-window="right:70%:noborder"
  \         --preview ''' . preview_file . ' {}'''
  \ }, <bang>0)

" Search project for file to edit
nnoremap <silent> <leader>e :call FzfFilePreview()<CR>
" Search recent files for file to edit
nnoremap <silent> <leader>r :FZFMru --preview="bat --color always --style changes,grid {}" --preview-window="right:50%:noborder"<CR>
" Open fuzzy buffers with leader b
nnoremap <silent> <leader>b :Buffers<CR>
" Open ripgrep
nnoremap <silent> <leader>/ :Rg<CR>
" Open ripgrep current file only
nnoremap <silent> <leader>f/ :Rgcf<CR>
" Open ripgrep and search word under cursor, current file only
nnoremap <silent> <leader>cff :Rgcf <C-R><C-W><CR>
" Open ripgrep and search word under cursor
nnoremap <silent> <leader>ff :Rg <C-R><C-W><CR>
" Search ctags
nnoremap <silent> <leader>t :Tags<CR>

  " Allow pasting from system clipboard
  tnoremap <expr> <C-v> '<C-\><C-N>pi'


  " Cut selected lines to system clipboard
  vmap <C-x> :!pbcopy<CR>
  " Copy selected lines to system clipboad
  vmap <C-c> :w !pbcopy<CR><CR>
  " Copy visual selection to system clipboard
  noremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>



  ""
  "" Section: Navigation
  ""
  Plug 'https://github.com/subnut/vim-smoothie', {'branch': 'devel'} " Smooth scrolling for vim
  Plug 'https://github.com/tpope/vim-surround.git' " Easily surround things with things, e.g. string -> 'string'
  " Plug 'https://github.com/terryma/vim-multiple-cursors.git' " Pretty effective multiple cursors functionality
  Plug 'https://github.com/mg979/vim-visual-multi', {'branch': 'master'} " Alternative to https://github.com/terryma/vim-multiple-cursors.git
  " Plug 'https://github.com/ludovicchabant/vim-gutentags.git' " The best ctags plugin for Vim
  Plug 'https://github.com/ludovicchabant/vim-gutentags', { 'branch': 'master' }

  " Add plugins to &runtimepath
  call plug#end()


  " Section: configs

  " Change <Leader>
  nnoremap <SPACE> <Nop>
  map <Space> <Leader>


" autocmd VimEnter * silent! lcd %:p:h
map <leader>c :lcd $PWD<CR>

set noautochdir
set number
set relativenumber  " show relative line numbers
set numberwidth=3   " narrow number column
setlocal spell " Elixir's syntax highlighting is clever enough to only spellcheck comments, so it's nice to enable this. use Ctrl+L to toggle the line number counting method

function! g:ToggleNuMode()
  if &relativenumber == 1
     set number
     set norelativenumber
  else
     set number
     set relativenumber
  endif
endfunction
nnoremap <c-l> :call g:ToggleNuMode()<cr>

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

  " Show line and column number
  " set ruler

  scriptencoding utf-8
  " Enable filetype-specific indenting and plugins
  filetype plugin on
  filetype plugin indent on
  set noautoindent
  set cinoptions+=+1
  " These two enable syntax highlighting
  set nocompatible
  syntax enable
  syntax on

  set nolazyredraw

  " TODO: What does this do?
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  let base16colorspace=256
  highlight Comment gui=italic

  " Set up theme
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  " set bg=dark
  colorscheme OceanicNext

function! LightTheme()
  set bg=light
  colorscheme one
  let g:airline_theme = 'one'
endfunction

map <leader>lt :call LightTheme()<CR>

" Use OceanicNext colours for SearchCurrent
autocmd BufEnter * highlight SearchCurrent ctermbg=35 ctermfg=29 guibg=#00d75f guifg=#00875f
autocmd BufEnter * highlight Search ctermbg=29 ctermfg=16 guibg=#00875f guifg=#1B2B34

  " Neovim disallow changing 'enconding' option after initialization
  " see https://github.com/neovim/neovim/pull/2929 for more details
  if !has('nvim')
    set encoding=utf-8  " Set default encoding to UTF-8
  endif

set completeopt-=menu
set completeopt+=menuone   " Show the completions UI even with only 1 item
set completeopt-=longest   " Don't insert the longest common text
set completeopt-=preview   " Hide the documentation preview window
set completeopt+=noinsert  " Don't insert text automatically
set completeopt-=noselect  " Highlight the first completion automatically
set pumheight=15
set wildmenu
set wildignorecase
  " neovim only
if matchstr(execute('silent version'), 'NVIM v\zs[^\n-]*') >= '0.4.0'
  set shada='20,<50,s10
  set inccommand=nosplit
  set wildoptions+=pum
  set signcolumn=yes:2
  set pumblend=10
endif

cnoremap <expr> <C-j>  pumvisible() ? '<Right>' : '<Down>'
cnoremap <expr> <C-k>  pumvisible() ? '<Left>' : '<Up>'
cnoremap <expr> <Up>   pumvisible() ? '<C-p>' : '<up>'
cnoremap <expr> <Down> pumvisible() ? '<C-n>' : '<down>'

  " highlight the current line
  set cursorline

  " When scrolling off-screen do so 3 lines at a time, not 1
  " set scrolloff=3
  " set scroll=4

  " Set temporary directory (don't litter local dir with swp/tmp files)
  set directory=/tmp/

  ""
  "" Whitespace
  ""
  set nowrap                        " don't wrap lines
  set linebreak
  set tabstop=2                     " a tab is two spaces
  set shiftwidth=2                  " an autoindent (with <<) is two spaces
  set expandtab                     " use spaces, not tabs
  match Error /\t/                  " Highlight tabs as errors (red)
  set list                          " Show invisible characters
  set backspace=indent,eol,start    " backspace through everything in insert mode

  " List chars
  set listchars=""                  " Reset the listchars
  set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
  set listchars+=trail:.            " show trailing spaces as dots
  set listchars+=extends:>          " The character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
  set listchars+=precedes:<         " The character to show in the last column when wrap is
                                    " off and the line continues beyond the left of the screen

  ""
  "" Searching
  ""
  set nohlsearch  " don't highlight matches by default
  set incsearch   " incremental searching
  set ignorecase  " searches are case insensitive...
  set smartcase   " ... unless they contain at least one capital letter

  " Disable backup behavior
  set nobackup
  set nowritebackup
  set noswapfile

  ""
  "" Wild settings
  ""

  " Disable output and VCS files
  set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

  " Disable archive files
  set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

  " Ignore bundler and sass cache
  set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

  " Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
  set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

  " Ignore rails temporary asset caches
  set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

  " Disable temp and backup files
  set wildignore+=*.swp,*~,._*

  " Don't search inside font files / svg graphics
  set wildignore+=*.svg

  " Ignore JS packages
  set wildignore+=*/node_modules

  " Backup and swap files
  set backupdir^=~/.vim/_backup//    " where to put backup files.
  set directory^=~/.vim/_temp//      " where to put swap files.

  ""
  "" Section: CTags
  ""
  set tags+=gems.tags
  set tags+=tags

  " g] <- show multiple
  " http://stackoverflow.com/a/33629584
  function! FollowTag()
    if !exists("w:tagbrowse")
      " vsplit
      let w:tagbrowse=1
    endif
    execute "tag " . expand("<cword>")
  endfunction

  nnoremap <c-]> :call FollowTag()<CR>zt<c-y><c-y><c-y>

  let g:gutentags_modules = ['ctags']
  let g:gutentags_enabled = 1
  let g:gutentags_trace = 0
  " let g:gutentags_ctags_exclude = ['*.min.js', '*.min.css', 'build', '_build', 'vendor', '.git', 'node_modules', '*.vim/bundle/*']
  " let g:gutentags_file_list_command = '( rg --files --no-ignore lib | rg .ex ; rg --files --no-ignore deps | rg .ex) | cat'
  let g:gutentags_file_list_command = 'rg --files'
  let g:gutentags_ctags_extra_args = ['--excmd=number']
  let g:gutentags_project_root = ['tags']
  let g:gutentags_project_info = []
  call add(g:gutentags_project_info, {'type': 'elixir', 'file': 'mix.exs'})
  call add(g:gutentags_project_info, { "type": "javascript", "glob": "assets/src/*" })
  call add(g:gutentags_project_info, { "type": "svelte", "glob": "*.svelte" })

  " config project root markers.
  " let g:gutentags_project_root = ['.root']
  " generate datebases in my cache directory, prevent gtags files polluting my project
  " let g:gutentags_cache_dir = expand('~/.cache/tags')


  ""
  "" Section: open-browser
  ""
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)



  " Toggle between current and previous file
  nmap <Tab> :call LoadPreviousFile()<CR>

  function! LoadPreviousFile()
    b#
  endfunction

  " Remove trailing whitespace
  map <leader>fws :FixWhitespace<CR>

  ""
  "" Section: Filetypes
  "" TODO: Add to 'augroup'?
  ""

  au BufNewFile,BufRead *.es6 set filetype=javascript
  " au BufNewFile,BufRead *.svelte set filetype=svelte
  au BufNewFile,BufRead *.slim set filetype=slim
  au BufNewFile,BufRead *.tsv,*.psv setf csv
  au BufRead,BufNewFile Gemfile* set filetype=ruby
  au BufRead,BufNewFile Dockerfile* set filetype=Dockerfile
  autocmd BufNewFile,BufRead Guardfile set filetype=ruby
  " autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.scss set filetype=scss.css|set tabstop=2|set shiftwidth=2
  autocmd BufRead,BufNewFile *.rb set filetype=ruby tabstop=2|set shiftwidth=2
  autocmd BufRead,BufNewFile *. set tabstop=2|set shiftwidth=2|set expandtab
  autocmd BufRead,BufNewFile *.jsx set filetype=javascript|set tabstop=2|set shiftwidth=2|set expandtab
  autocmd BufRead,BufNewFile *.erb setlocal tabstop=4|set shiftwidth=4|set expandtab
  autocmd BufRead,BufNewFile *.py set filetype=python tabstop=4|set shiftwidth=4|set expandtab
  autocmd BufRead,BufNewFile *.vue set filetype=vue tabstop=2|set shiftwidth=2
  au FileType css,scss setl iskeyword+=-

augroup UserChecktime
  autocmd!
  autocmd FocusGained * checktime
augroup END

  let g:session_autoload="no"
  let g:session_autosave="no"


  ""
  "" Section: Viewport Manipulation
  ""

  " Adjust viewports to the same size
  map <Leader>= <C-w>=

  " https://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
  " window
  nmap <leader>sw<c-h>  :topleft  vnew<CR>
  nmap <leader>sw<c-l> :botright vnew<CR>
  nmap <leader>sw<c-u>    :topleft  new<CR>
  nmap <leader>sw<c-j>  :botright new<CR>
  " buffer
  nmap <leader>s<c-h>  :leftabove  vnew<CR>
  nmap <leader>s<c-l>  :rightbelow vnew<CR>
  nmap <leader>s<c-u>  :leftabove  new<CR>
  nmap <leader>s<c-j>  :rightbelow new<CR>

  " http://flaviusim.com/blog/resizing-vim-window-splits-like-a-boss/
  nnoremap <silent> + :exe "vertical resize +4"<CR>
  nnoremap <silent> - :exe "vertical resize -4"<CR>
  nnoremap <s-up> :exe "resize +4"<CR>
  nnoremap <s-down> :exe "resize -4"<CR>

  set undodir=$HOME/.vim/undo
  set undofile
  set undolevels=1000
  set undoreload=10000

  set smartcase

  " Set cursor to underscore in normal mode
  " set guicursor+=n:hor20-Cursor/lCursor

  " upper/lower word
  nmap <leader>u mQviwU`Q
  nmap <leader>l mQviwu`Q

  " upper/lower first char of word
  nmap <leader>U mQgewvU`Q
  nmap <leader>L mQgewvu`Q

  " Swap two words
  nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

  " find merge conflict markers
  nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

  " Map the arrow keys to be based on display lines, not physical lines
  map <Down> gj
  map <Up> gk

" Disable Searchant highlight when incsearch.vim highlights also disable
autocmd CursorMoved * call SearchantStop()
function SearchantStop()
  :execute "normal \<Plug>SearchantStop"
endfunction

  " Toggle hlsearch with <leader>hs
  nmap <leader>hs :set hlsearch! hlsearch?<CR>

  " init.vim editing
  map <leader>- :e $HOME/.config/nvim/init.vim<CR>

  " source init.vim
  map <leader>v :source $HOME/.config/nvim/init.vim<CR>

  " Terminal

  " Move up and down on visual lines"
  nnoremap k gk
  nnoremap j gj
  nnoremap gk k
  nnoremap gj j

  nnoremap zu zt<c-y><c-y><c-y>
  nnoremap zd zb<c-e><c-e><c-e>

  " MatchParen.vim causes lag.
  "
  " FUNCTIONS SORTED ON SELF TIME
  " count  total (s)   self (s)  function
  " 21              0.007059  <SNR>79_Highlight_Matching_Pair()
  "
  " https://stackoverflow.com/a/47361068
  "
  " Disable parentheses matching depends on system. This way we should address all cases (?)
  set noshowmatch
  " NoMatchParen " This doesnt work as it belongs to a plugin, which is only loaded _after_ all files are.
  " Trying disable MatchParen after loading all plugins
  "
  function! g:FuckThatMatchParen ()
      if exists(":NoMatchParen")
          :NoMatchParen
      endif
  endfunction

  augroup plugin_initialize
      autocmd!
      autocmd VimEnter * call FuckThatMatchParen()
  augroup END

  let g:python3_host_prog = '/usr/local/bin/python3'

  " Turn off auto-indendation before pasting
  set pastetoggle=<F3>

  let g:mix_format_on_save = 0

  nnoremap Q :q<CR>
  nnoremap <leader>w :w<CR>
  map R :e!<CR>
  " TODO: Create a PR for vim-smoothie to make these scroll using smoothie logic
  " map Y 5<c-y>
  " map E 5<c-e>
  silent! map <unique> gg         <Plug>(Smoothie_gg)
  silent! map <unique> G          <Plug>(Smoothie_G)
  " Swap ^ and 0 because I use ^ 99% of the time
  noremap 0 ^
  noremap ^ 0

  let g:floaterm_width = 0.9
  let g:floaterm_height = 0.9
  let g:floaterm_position = 'center'
  let g:floaterm_background = '#1B2B34'
  hi FloatermNF guibg='#1B2B34'
  hi FloatermBorderNF guibg='#1B2B34' guifg=cyan
  let g:floaterm_gitcommit='vsplit'


  noremap  <silent> <F6>           :FloatermToggle<CR>
  noremap! <silent> <F6>           <Esc>:FloatermToggle<CR>
  tnoremap <silent> <F6>           <C-\><C-n>:FloatermToggle<CR>

  highlight VertSplit guibg=NONE

  let g:spotify_token=$VIMIFY_SPOTIFY_TOKEN

  set foldlevelstart=99
  set nofoldenable
  au WinEnter * set nofoldenable
  au WinLeave * set nofoldenable

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let height = &lines
    let width = &columns

    let opts = {
          \ 'relative': 'editor',
          \ 'row': 0,
          \ 'col': 0,
          \ 'width': width,
          \ 'height': height
          \ }
    set winhl=Normal:Floating
    call nvim_open_win(buf, v:true, opts)
  endfunction

" TODO: Update to work with streaming, + any fixes from original thread:
"
" https://github.com/ryanoasis/vim-devicons/issues/106#issuecomment-354629715
" https://coreyja.com/vim-fzf-with-devicons/
" https://www.reddit.com/r/neovim/comments/f8ouv3/i_added_a_git_status_column_to_udanmikitas_fzf/finpwoa/
"
" Files + devicons + floating fzf
function! FzfFilePreview()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -200" --expect=ctrl-v,ctrl-x'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

    for l:item in a:lines[1:]
      let l:pos = stridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --preview-window=right:70%:noborder --prompt Files\> ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call FloatingFZF()'})

endfunction

" Files + devicons + floating fzf
function! FzfFilePreviewWithGitStatus()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=changes,grid --color always {3..-1} | head -200" --expect=ctrl-v,ctrl-x'
  let s:files_status = {}

  function! s:cacheGitStatus()
    let l:gitcmd = 'git -c color.status=false -C ' . $PWD . ' status -s'
    let l:statusesStr = system(l:gitcmd)
    let l:statusesSplit = split(l:statusesStr, '\n')
    for l:statusLine in l:statusesSplit
      let l:fileStatus = split(l:statusLine, ' ')[0]
      let l:fileName = split(l:statusLine, ' ')[1]
      let s:files_status[l:fileName] = l:fileStatus
    endfor
  endfunction

  function! s:files()
    call s:cacheGitStatus()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_indicators(l:files)
  endfunction

  function! s:prepend_indicators(candidates)
    return s:prepend_git_status(s:prepend_icon(a:candidates))
  endfunction

  function! s:prepend_git_status(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:status = ''
      let l:icon = split(l:candidate, ' ')[0]
      let l:filePathWithIcon = split(l:candidate, ' ')[1]

      let l:pos = strridx(l:filePathWithIcon, ' ')
      let l:file_path = l:filePathWithIcon[pos+1:-1]
      if has_key(s:files_status, l:file_path)
        let l:status = s:files_status[l:file_path]
        call add(l:result, printf('%s %s %s', l:status, l:icon, l:file_path))
      else
        " printf statement contains a load-bearing unicode space
        " the file path is extracted from the list item using {3..-1},
        " this breaks if there is a different number of spaces, which
        " means if we add a space in the following printf it breaks.
        " using a unicode space preserves the spacing in the fzf list
        " without breaking the {3..-1} index
        call add(l:result, printf('%s %s %s', ' ', l:icon, l:file_path))
      endif
    endfor

    return l:result
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

    for l:item in a:lines[1:]
      let l:pos = strridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --preview-window=right:70%:noborder --prompt Files\> ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call FloatingFZF()'})

endfunction

set noshowcmd  " to get rid of display of last command
set noshowmode  " to get rid of thing like --INSERT--
set laststatus=2

" Vim airline theme
let g:airline_theme='space'
" Enable extensions
let g:airline_extensions = ['branch', 'hunks', 'nvimlsp']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Customize vim airline per filetype
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

" Shift+Space - duplicate selected lines
map <Leader>d y'>p
vmap <Leader>d y'>p

set winblend=0
set pumblend=0
