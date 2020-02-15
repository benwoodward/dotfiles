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
Plug 'https://github.com/AndrewRadev/splitjoin.vim.git'
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

Plug 'https://github.com/sheerun/vim-polyglot' " Syntax highlighting for multiple languages.
  " TODO: See whether I can remove other syntax plugins using this

Plug 'https://github.com/vim-ruby/vim-ruby.git', { 'for': ['rb']} " Ruby syntax highlighting
Plug 'https://github.com/othree/yajs.vim'           " Most up to date JS highlighter, works well with React
Plug 'https://github.com/othree/html5.vim'          " html5 syntax highlighting
Plug 'https://github.com/maxmellon/vim-jsx-pretty'  " Jsx syntax highlighting
Plug 'https://github.com/maksimr/vim-jsbeautify'
Plug 'https://github.com/mhartington/oceanic-next'  " Best dark colorscheme
Plug 'https://github.com/elixir-editors/vim-elixir' " Elixir syntax highlighting
Plug 'https://github.com/sbdchd/neoformat'          " Multi-language formatter. TODO: Check whether I can remove other beautifiers
Plug 'https://github.com/evanleck/vim-svelte'       " Svelte highlighting
Plug 'https://github.com/mhinz/vim-mix-format'      " Auto-format Elixir code with `mix format` on save
Plug 'https://github.com/plasticboy/vim-markdown', { 'for': ['md', 'markdown']} " Markdown highlighting
  let g:vim_markdown_folding_disabled = 1

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'https://github.com/chrisbra/Colorizer'

" Intellisense for Neovim
Plug 'https://github.com/neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

  let g:coc_global_extensions = [
        \ 'coc-emoji', 'coc-eslint', 'coc-prettier',
        \ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
        \ 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml',
        \ 'coc-snippets', 'coc-elixir'
        \ ]
  let g:coc_snippet_next = '<C-n>' " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<C-p>' " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  " Use <C-j> and <C-k> to navigate the completion list
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  set cmdheight=2 " Better display for messages
  set updatetime=200 " Smaller updatetime for CursorHold & CursorHoldI
  set shortmess+=c " don't give |ins-completion-menu| messages.
  set signcolumn=yes " always show signcolumns
  " Use `lp` and `ln` for navigate diagnostics
  nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
  nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
  " Remap keys for gotos
  nmap <silent> <leader>ld <Plug>(coc-definition)
  nmap <silent> <leader>lt <Plug>(coc-type-definition)
  nmap <silent> <leader>li <Plug>(coc-implementation)
  nmap <silent> <leader>lf <Plug>(coc-references)
  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Fix current line
  nmap <Leader>qf <Plug>(coc-fix-current)
  vmap <leader>fs <Plug>(coc-format-selected)
  nmap <leader>fs <Plug>(coc-format-selected)
  nmap <Leader>rn <Plug>(coc-rename)
  nmap <Leader>gd <Plug>(coc-definition)
  " Auto-scroll floating window
  nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
  nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

Plug 'https://github.com/stephpy/vim-yaml.git', { 'for': ['yaml.yml'] } " YAML hightlighting
Plug 'https://github.com/elzr/vim-json.git', { 'for': ['json']}         " JSON highlighter
Plug 'https://github.com/bronson/vim-trailing-whitespace.git'           " Highlights trailing whitespace characters in red



""
"" Section: Interface enhancements
""
Plug 'https://github.com/tyru/open-browser.vim'
Plug 'https://github.com/farmergreg/vim-lastplace' " Open file at last place edited
let g:lastplace_ignore_buftype = "quickfix,nofile,help"

Plug 'https://github.com/rhysd/git-messenger.vim' " Show git blame for current line in floating window
  " <Leader>gm
  " q	Close the popup window
  " o	older. Back to older commit at the line
  " O	Opposite to o. Forward to newer commit at the line
  " d	Toggle diff hunks only related to current file in the commit
  " D	Toggle all diff hunks in the commit
  " ?	Show mappings help


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
  nnoremap <leader>gg :let g:gitgutter_diff_base='HEAD~'<Left>
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
" File browser in sidebar
" Plug 'https://github.com/scrooloose/nerdtree.git'
  let g:NERDSpaceDelims = 1 " TODO: This does what?
  let nerdtreeshowlinenumbers=1 " TODO: This does what?
  let g:NERDTreeWinPos = "right"
  " Locate current file in Nerdtree
  " map <leader>nf :NERDTreeFind<CR>
  " map <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
  augroup AuNERDTreeCmd " TODO: This does what?
  let NERDTreeHijackNetrw=0
  let NERDTreeHighlightCursorline = 1
  let NERDTreeShowHidden = 1
  let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '\.beam']
  let NERDShutUp = 1 " so it doesn't complain about types it doesn't know
  let NERDTreeQuitOnOpen=0 " quit NERDTree after opening a file
  let NERDChristmasTree = 1 " colored NERD Tree
  let NERDTreeMapActivateNode='<CR>' " map enter to activating a node

Plug 'https://github.com/henrik/vim-reveal-in-finder.git' " Reveal current file in Finder
  " :Reveal

" Terminal in floating window
Plug 'https://github.com/voldikss/vim-floaterm'
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


" Plug 'mattn/webapi-vim' " TODO: Do I need this?
Plug 'https://github.com/mattn/gist-vim' " Post selected code to Gist
Plug 'https://github.com/ruanyl/vim-gh-line' " Open current file at current line on Github
Plug 'https://github.com/voldikss/vim-searchme' " Search under cursor with options
  " vim-search-me
  nmap <silent> <Leader>s <Plug>SearchNormal
  vmap <silent> <Leader>s <Plug>SearchVisual
  " Select text and type <Leader>s to do a web search
  " <leader>saw in to search web for a word
  " <leader>sa( to search web for the text wrapped in the bracket
  " <leader>sas to search web for a sentence
Plug 'https://github.com/prabirshrestha/async.vim' " TODO: Do I need this?
" Plug 'https://github.com/HendrikPetertje/vimify'
" Plug 'https://github.com/benwoodward/vimify', { 'branch': 'playlists' }
Plug '~/dev/oss/Forks/vim-plugins/vimify'
  noremap <leader>sp :SpPlaylists<CR>

Plug 'https://github.com/tpope/vim-commentary'

Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere
  let g:webdevicons_conceal_nerdtree_brackets=1
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = './.fzf-history'

  "" FZF

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Some ripgrep searching defaults
function! RgCommand(ignore) abort
  return 'rg' .
    \ ' --hidden' .
    \ ' --color=always' .
    \ ' --colors "path:fg:190,220,255"' .
    \ ' --colors "line:fg:128,128,128" ' .
    \ ' --column' .
    \ ' --line-number' .
    \ ' --no-heading' .
    \ ' --smart-case' .
    \ ' ' . (a:ignore == 1 ? '--ignore' : '--no-ignore')
endfunction

" Adds prompt
function! PreviewFlags(prompt) abort
  return ' --prompt="' . a:prompt . '> "'
endfunction

" Ensure that only the 4th column delimited by : is filtered by FZF
function! RgPreviewFlags(prompt) abort
  return PreviewFlags(a:prompt) . ' --delimiter : --nth 4.. --color hl:123,hl+:222'
endfunction

" Configs the preview
function! Preview(flags) abort
  return fzf#vim#with_preview({'options': a:flags})
endfunction

" Executes ripgrep with a preview
function! RgWithPreview(ignore, args, prompt, bang) abort
  let command = RgCommand(a:ignore).' '.shellescape(a:args)
  call fzf#vim#grep(command, 1, Preview(RgPreviewFlags(a:prompt)), a:bang)
endfunction

" Defines search command for :Files
let $FZF_DEFAULT_COMMAND='rg --files --hidden --iglob "!.DS_Store" --iglob "!.git"'

" Opens files search with preview
function! FilesWithPreview(args, bang) abort
  call fzf#vim#files(a:args, Preview(PreviewFlags('Files')), a:bang)
endfunction

command! -bang -nargs=* Rg call RgWithPreview(v:true, <q-args>, 'Grep', <bang>0)
command! -bang -nargs=* Rgg call RgWithPreview(v:false, <q-args>, 'Global Grep', <bang>0)
command! -bang -nargs=* Rgv call RgWithPreview(v:true, <c-word>, 'Grep', <bang>0)
command! -bang -nargs=? -complete=dir Files call FilesWithPreview(<q-args>, <bang>0)

" Don't use status line in FZF
augroup FzfConfig
  autocmd!
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Default FZF options with bindings to match layout and select all + none
let $FZF_DEFAULT_OPTS = '--layout=default --reverse' .
  \ ' --info inline' .
  \ ' --bind ctrl-e:preview-down,ctrl-y:preview-up,ctrl-u:preview-page-up,ctrl-d:preview-page-down,tab:toggle+up,shift-tab:toggle+down' .
  \ ' --preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -200" --expect=ctrl-v,ctrl-x'

let preview_file = '/Users/' . $USER . '/.config/preview/preview.sh'
command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \      'window': 'call FloatingFZF()',
  \      'options': '
  \         --with-nth 1,2
  \         --prompt "Tags> "
  \         --preview-window="right:60%"
  \         --preview ''' . preview_file . ' {}'''
  \ }, <bang>0)

" Open fuzzy files with leader \
" nnoremap <silent> <Leader>e :Files<CR>
nnoremap <silent> <leader>e :call FzfFilePreview()<CR>
" Open fuzzy buffers with leader b
nnoremap <silent> <Leader>b :Buffers<CR>
" Open ripgrep
nnoremap <silent> <Leader>/ :Rg<CR>
" Search ctags
nnoremap <silent> <Leader>t :Tags<CR>

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
  Plug 'https://github.com/psliwka/vim-smoothie' " Smooth scrolling for vim
  Plug 'https://github.com/tpope/vim-surround.git' " Easily surround things with things, e.g. string -> 'string'
  Plug 'https://github.com/terryma/vim-multiple-cursors.git' " Pretty effective multiple cursors functionality
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git' " The best ctags plugin for Vim

  " Add plugins to &runtimepath
  call plug#end()


  " Section: configs

  " Change <Leader>
  nnoremap <SPACE> <Nop>
  map <Space> <Leader>



  " Show line numbers
  set number


  " Show line number for current line, and relative numbers for others
  " Toggle with F4
  if exists("+relativenumber")
    if v:version >= 400
     set number
    endif
    set relativenumber  " show relative line numbers
    set numberwidth=3   " narrow number column
    " cycles between relative / absolute / no numbering
    if v:version >= 400
     function! RelativeNumberToggle()
       if (&number == 1 && &relativenumber == 1)
         set nonumber
         set relativenumber relativenumber?
       elseif (&number == 0 && &relativenumber == 1)
         set norelativenumber
         set number number?
       elseif (&number == 1 && &relativenumber == 0)
         set norelativenumber
         set nonumber number?
       else
         set number
         set relativenumber relativenumber?
       endif
     endfunc
    else
     function! RelativeNumberToggle()
       if (&relativenumber == 1)
         set number number?
       elseif (&number == 1)
         set nonumber number?
       else
         set relativenumber relativenumber?
       endif
     endfunc
    endif
    nnoremap <F4> :call RelativeNumberToggle()<CR>
    inoremap <F4> <ESC>:call RelativeNumberToggle()<CR>
    vnoremap <F4> <ESC>:call RelativeNumberToggle()<CR>
  else                  " fallback
    set number          " show line numbers
    " inverts numbering
    nnoremap <F4> :set number! number?<CR>
  endif


  " Show line and column number
  " set ruler

  " These two enable syntax highlighting
  set nocompatible
  syntax enable

  set nolazyredraw

  " Enable command line completion vertical menu
  set wildoptions+=pum

  " TODO: What does this do?
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  let base16colorspace=256
  highlight Comment gui=italic

  " Set up theme
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  colorscheme OceanicNext

  scriptencoding utf-8

  " Enable filetype-specific indenting and plugins
  filetype plugin indent on

  " Neovim disallow changing 'enconding' option after initialization
  " see https://github.com/neovim/neovim/pull/2929 for more details
  if !has('nvim')
    set encoding=utf-8  " Set default encoding to UTF-8
  endif

  " highlight the current line
  set cursorline

  " When scrolling off-screen do so 3 lines at a time, not 1
  " set scrolloff=3

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
  set hlsearch    " highlight matches
  set incsearch   " incremental searching
  set ignorecase  " searches are case insensitive...
  set smartcase   " ... unless they contain at least one capital letter

  " Enable tab complete for commands.
  " first tab shows all matches. next tab starts cycling through the matches
  set wildmode=list:longest,full

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

  nnoremap <c-]> :call FollowTag()<CR>zt<c-y><c-y><c-y><c-y>

  let g:gutentags_modules = ['ctags']
  let g:gutentags_enabled = 1
  let g:gutentags_trace = 0
  let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", "vendor", ".git", "node_modules", "*.vim/bundle/*"]
  let g:gutentags_file_list_command = '( rg --files --no-ignore lib | rg .ex ; rg --files --no-ignore deps | rg .ex ) | cat'
  let g:gutentags_ctags_extra_args = ['--excmd=number']
  let g:gutentags_project_root = ['tags']
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

  " Open latest commit in browser
  map <Leader>lc :Gbrowse HEAD^{}<CR>

  " Open current file at HEAD in browser
  map <Leader>flc :Gbrowse HEAD^{}:%<CR>



  " Remove trailing whitespace
  map <leader>fws :FixWhitespace<CR>

  ""
  "" Section: Filetypes
  "" TODO: Add to 'augroup'?
  ""

  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead *.svelte set filetype=html
  au BufNewFile,BufRead *.slim set filetype=slim
  au BufNewFile,BufRead *.tsv,*.psv setf csv
  au BufRead,BufNewFile Gemfile* set filetype=ruby
  au BufRead,BufNewFile Dockerfile* set filetype=Dockerfile
  autocmd BufNewFile,BufRead Guardfile set filetype=ruby
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.scss set filetype=scss.css|set tabstop=2|set shiftwidth=2
  autocmd BufRead,BufNewFile *.rb set filetype=ruby tabstop=2|set shiftwidth=2
  autocmd BufRead,BufNewFile *. set tabstop=2|set shiftwidth=2|set expandtab
  autocmd BufRead,BufNewFile *.jsx set filetype=javascript|set tabstop=2|set shiftwidth=2|set expandtab
  autocmd BufRead,BufNewFile *.erb setlocal tabstop=4|set shiftwidth=4|set expandtab
  autocmd BufRead,BufNewFile *.py set filetype=python tabstop=4|set shiftwidth=4|set expandtab
  autocmd BufRead,BufNewFile *.vue set filetype=vue tabstop=2|set shiftwidth=2

  let g:session_autoload="no"
  let g:session_autosave="no"


  ""
  "" Section: Viewport Manipulation
  ""

  " Adjust viewports to the same size
  map <Leader>= <C-w>=

  " https://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
  " window
  nmap <leader>sw<left>  :topleft  vnew<CR>
  nmap <leader>sw<right> :botright vnew<CR>
  nmap <leader>sw<up>    :topleft  new<CR>
  nmap <leader>sw<down>  :botright new<CR>
  " buffer
  nmap <leader>s<left>   :leftabove  vnew<CR>
  nmap <leader>s<right>  :rightbelow vnew<CR>
  nmap <leader>s<up>     :leftabove  new<CR>
  nmap <leader>s<down>   :rightbelow new<CR>

  " http://flaviusim.com/blog/resizing-vim-window-splits-like-a-boss/
  nnoremap <silent> + :exe "vertical resize +4"<CR>
  nnoremap <silent> - :exe "vertical resize -4"<CR>

  set undodir=$HOME/.vim/undo
  set undofile
  set undolevels=1000
  set undoreload=10000

  set smartcase

  " Set cursor to underscore in normal mode
  set guicursor+=n:hor20-Cursor/lCursor

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

  " Toggle hlsearch with <leader>hs
  nmap <leader>hs :set hlsearch! hlsearch?<CR>

  " init.vim editing
  map <leader>- :e $HOME/.config/nvim/init.vim<CR>

  " source init.vim
  map <leader>v :source $HOME/.config/nvim/init.vim<CR>

  " Terminal
  " TODO: This does what?
  tnoremap ., <C-\><C-n>

  " Move up and down on visual lines"
  nnoremap k gk
  nnoremap j gj
  nnoremap gk k
  nnoremap gj j

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

  let g:mix_format_on_save = 1

  map Q :q<CR>
  map W :w<CR>
  map E :e!<CR>

  " for asyncomplete.vim log
  let g:asyncomplete_log_file = expand('~/asyncomplete.log')

  " when pairing some braces or quotes, put cursor between them
  inoremap <>   <><Left>
  inoremap ()   ()<Left>
  inoremap {}   {}<Left>
  inoremap []   []<Left>
  inoremap ""   ""<Left>
  inoremap ''   ''<Left>
  inoremap ``   ``<Left>

  let g:floaterm_width = 0.7
  let g:floaterm_height = 0.9
  let g:floaterm_position = 'topright'
  let g:floaterm_background = '#1B2B34'




  noremap  <silent> <F12>           :FloatermToggle<CR>
  noremap! <silent> <F12>           <Esc>:FloatermToggle<CR>
  tnoremap <silent> <F12>           <C-\><C-n>:FloatermToggle<CR>

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


