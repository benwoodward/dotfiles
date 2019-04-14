" TODO:
" - Comment, and group all Plugins with configs and by type
" - Group settings/configs, functions, mappings etc.
" - Divide sections with " ================ Section: Name ===========================
" - Why do L and H no longer go to the absolute top or bottom of window
"   anylonger? scrolloff setting?

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin()

" Plug 'git@github.com:ap/vim-css-color.git' " Disabled due to create_matches() lagging
" Plug 'git@github.com:tpope/vim-abolish.git' " Disabled because I never use it
" Plug 'git@github.com:Raimondi/delimitMate.git' " Auto-closes quotes, even when you don't want to!
Plug 'git@github.com:AndrewRadev/splitjoin.vim.git' " Switches between a single-line statement and a multi-line one
" Plug 'git@github.com:tpope/vim-bundler.git' " Disabled because I never use
Plug 'git@github.com:mattn/emmet-vim.git' " Emmet for Vim, make HTML without going mad
Plug 'git@github.com:tpope/vim-rails.git' " Rails shortcuts
" Plug 'git@github.com:tyru/open-browser.vim.git' " Disabled because replaced with vim-search-me
Plug 'git@github.com:junegunn/vim-easy-align.git' " Alignment plugin with smart key bindings
Plug 'git@github.com:stephpy/vim-yaml.git' " YAML hightlighting
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git' " Fuzzy search files, ctags and more
" Plug 'git@github.com:ervandew/supertab.git' " Don't use it
" Plug 'git@github.com:airblade/vim-gitgutter.git' " Disabled due to lag
Plug 'git@github.com:elzr/vim-json.git' " JSON highlighter
Plug 'git@github.com:bronson/vim-trailing-whitespace.git' " Hightligts trailing whitespace characters in red
Plug 'git@github.com:scrooloose/nerdtree.git' " File browser in sidebar
Plug 'git@github.com:scrooloose/nerdcommenter.git' " Toggle comments
Plug 'git@github.com:tpope/vim-fugitive.git' " Github commands
" Plug 'git@github.com:Chun-Yang/vim-action-ag.git' " Outdated / no longer use
Plug 'git@github.com:tpope/vim-surround.git' " Easily surround things with things, e.g. string -> 'string'
Plug 'git@github.com:terryma/vim-multiple-cursors.git' " Pretty effective multiple cursors functionality
Plug 'git@github.com:ludovicchabant/vim-gutentags.git' " The best ctags plugin for Vim
Plug 'git@github.com:keith/swift.vim.git' " Swift syntax highlighting
Plug 'git@github.com:vim-ruby/vim-ruby.git' " Ruby syntax highlighting
Plug 'git@github.com:henrik/vim-reveal-in-finder.git' " Reveal current file in Finder
Plug 'mattn/webapi-vim'
Plug 'https://github.com/mattn/gist-vim' " Post selected code to Gist
" Plug 'https://github.com/adelarsq/vim-matchit' " Outdated / no longer use
Plug 'gfontenot/vim-xcode' " Create and build XCode projects without using the dreaded XCode
Plug 'mileszs/ack.vim' " Search files, configured to work with ripgrep
" Plug 'itchyny/lightline.vim' " Disabled due to lag
" Plug 'christoomey/vim-tmux-runner' " Disabled because I don't use it
" Plug 'jerrymarino/SwiftPlayground.vim' " Disabled because it's broken / don't use it
Plug 'git@github.com:benwoodward/SwiftPlayground.vim.git', { 'branch': 'regex-fix'}
Plug 'w0rp/ale' " Async linting
" Plug 'dikiaap/minimalist' " Don't use it
Plug 'othree/yajs.vim' " Most up to date JS highlighter, works well with React
Plug 'mhartington/oceanic-next' " Best dark colorscheme
Plug 'othree/html5.vim' " html5 syntax highlighting
" Plug 'HerringtonDarkholme/yats.vim' " Don't use it
" Plug 'tpope/vim-repeat' " Don't use it
Plug 'maxmellon/vim-jsx-pretty' " Jsx syntax highlighting
Plug 'elixir-editors/vim-elixir' " Elixir syntax highlighting
Plug 'mhinz/vim-startify' " Startup screen for Vim
Plug 'farmergreg/vim-lastplace' " Open file at last place edited
Plug 'ruanyl/vim-gh-line' " Open current file at current line on Github
Plug 'voldikss/vim-searchme' " Search under cursor with options
" Plug 'tpope/vim-rhubarb'
Plug 'git://github.com/tommcdo/vim-lion.git'
Plug 'henrik/vim-ruby-runner'
Plug 'maksimr/vim-jsbeautify'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }


" Add plugins to &runtimepath
call plug#end()


" Section: configs

" Change <Leader>
let mapleader = ";"

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
  inoremap <F4> <ESC>:call RelativeNumberToggle()<CR>a
  vnoremap <F4> <ESC>:call RelativeNumberToggle()<CR>
else                  " fallback
  set number          " show line numbers
  " inverts numbering
  nnoremap <F4> :set number! number?<CR>
endif


" enable setting title
set title
" configure title to look like: Vim /path/to/file
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

" Show line and column number
" set ruler

" These two enable syntax highlighting
set nocompatible
syntax enable

set nolazyredraw

" TODO: What does this do?
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

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
set scrolloff=3

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
  echom "test"
  if !exists("w:tagbrowse")
    vsplit
    let w:tagbrowse=1
  endif
  execute "tag " . expand("<cword>")
endfunction

nnoremap <c-]> :call FollowTag()<CR>

""
"" Section: Nerdtree
""
let g:NERDSpaceDelims = 1 " TODO: This does what?
let nerdtreeshowlinenumbers=1 " TODO: This does what?

" Locate current file in Nerdtree
map <leader>nf :NERDTreeFind<cr>
map <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
augroup AuNERDTreeCmd " TODO: This does what?

let NERDTreeHijackNetrw=0
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']

" so it doesn't complain about types it doesn't know
let NERDShutUp = 1

" quit NERDTree after opening a file
let NERDTreeQuitOnOpen=1

" colored NERD Tree
let NERDChristmasTree = 1

" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'


" Toggle between current and previous file
nmap <Tab> :call LoadPreviousFile()<CR>

function! LoadPreviousFile()
  b#
endfunction

ino <Leader>e <esc>
cno <Leader>e <c-c>
vno <Leader>e <esc>

" Open latest commit in browser
map <Leader>lc :Gbrowse HEAD^{}<CR>

" Open current file at HEAD in browser
map <Leader>flc :Gbrowse HEAD^{}:%<CR>


" vim-search-me
" https://github.com/voldikss/vim-search-me
"
" Search word under cursor in default browser
noremap <Leader>ss :<C-u>SearchCurrentText<CR>
" Search selected text in default browser
vnoremap <Leader>sv :<C-u>SearchVisualText<CR>

let g:xcode_runner_command = 'VtrSendCommandToRunner! {cmd}'


""
"" CtrlP
""
" show hidden files in CtrlP
let g:ctrlp_show_hidden = 1

" Search ctags
nmap <Leader>c :CtrlPTag<CR>

" Search buffers
nmap <Leader>r :CtrlPBuffer<CR>

" Map CtrlP to <Leader>t
let g:ctrlp_map = ''
map <Leader>t :CtrlP<CR>

" Use RipGrep with CtrlP
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob "" --ignore-file $HOME/.gitignore'
  let g:ctrlp_use_caching = 0
endif

""
"" Section: Ack
"" TODO: How do Ack, Ag, rg, CtrlP work together?
""       Do I need Ack?
" let g:ackprg = 'ag --nogroup --nocolor --column' " Use ag with Ack
let g:ackprg = 'rg --vimgrep --no-heading --smart-case --ignore-file $HOME/.gitignore' " Use rg with Ack
map <leader>f :Ack<space>

" Shift+Space - duplicate selected lines
map <S-Space> y'>p
vmap <S-Space> y'>p

" Backspace / Delete tweaks:
" delete whole words with Alt+Backspace
" TODO: Why does this no longer work in Neovim?
nmap <A-BS> ciw

" delete to end of word with Alt+Delete
imap <A-Del> <C-[>lce
nmap <A-Del> ce

" always enter insert after deletion
nmap <BS> a<BS>;
nmap <Del> i<Del>
vmap <BS> <BS>i
vmap <Del> <Del>i
smap <BS> <BS>i
smap <Del> <Del>i

" Tweak cursor movement during Alt / Shift
nmap <A-Right> w
nmap <A-Left> b
imap <S-M-Right> <C-[>lve<C-g>
imap <S-M-Left> <C-[>hvb<C-g>
nmap <S-M-Right> ve<C-g>
nmap <S-M-Left> vb<C-g>
vmap <S-M-Right> e
vmap <S-M-Left> b
smap <S-M-Right> <C-O>e
smap <S-M-Left> <C-O>b

set splitbelow
set splitright

" ;. - new file in vertical split
imap <Leader>. <Esc>:new<CR><D-t>
map <Leader>. <Esc>:new<CR><D-t>


" ;h - same as above, but horizontal
imap <Leader>h <Esc>:new<CR><D-t>
map <Leader>h <Esc>:new<CR><D-t>

" ;; - activate surround.vim plugin for current line or selection
nmap <Leader><Leader> ^vg_S
smap <Leader><Leader> <C-g>S
vmap <Leader><Leader> S

" remove trailing whitespace (don't use on binary files!!)
map <leader>tws :FixWhitespace<CR>

" insert hashrocket, =>, with control-l
imap <C-l> <Space>=><Space>

" align hashrockets with <leader>t control-l
vmap <leader>t<C-l> :Align =><CR>

""
"" Section: Filetypes
"" TODO: Add to 'augroup'?
""

au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.slim set filetype=slim
au BufNewFile,BufRead *.tsv,*.psv setf csv
au BufRead,BufNewFile Gemfile* set filetype=ruby
autocmd BufNewFile,BufRead Guardfile set filetype=ruby
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufRead,BufNewFile *.scss set filetype=scss.css|set tabstop=2|set shiftwidth=2
autocmd BufRead,BufNewFile *.rb set filetype=ruby tabstop=2|set shiftwidth=2
autocmd BufRead,BufNewFile *. set tabstop=2|set shiftwidth=2|set expandtab
autocmd BufRead,BufNewFile *.jsx set filetype=javascript|set tabstop=2|set shiftwidth=2|set expandtab
autocmd BufRead,BufNewFile *.erb setlocal tabstop=4|set shiftwidth=4|set expandtab
autocmd BufRead,BufNewFile *.py set filetype=python tabstop=4|set shiftwidth=4|set expandtab


nmap <Leader>sj :SplitjoinSplit<cr>
nmap <Leader>sk :SplitjoinJoin<cr>

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

" https://github.com/nathanaelkane/vim-indent-guides
set ts=2 sw=2 et
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

set smartcase

" Set cursor to underscore in normal mode
set guicursor+=n:hor20-Cursor/lCursor

" https://github.com/airblade/vim-gitgutter/issues/259
let g:gitgutter_max_signs = 1000

runtime macros/matchit.vim

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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


""
"" Section: Ale
"" https://github.com/w0rp/ale
""
let g:ale_enabled = 1

let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'python':     ['flake8']
  \}
let b:ale_fixers = {
  \   'python': ['autopep8']
  \}

let g:ale_open_list = 0 " show when there are errors

" always show sign column, so text doesn't move around
let g:ale_sign_column_always = 1

" Errors
let g:ale_sign_error = '✖︎'
highlight ALEErrorSign guifg=red ctermfg=red
let g:ale_echo_msg_error_str = 'E'

" Warnings
highlight ALEWarningSign guifg=grey ctermfg=grey
let g:ale_echo_msg_warning_str = 'W'

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:move_key_modifier = 'N'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

let g:ale_ruby_reek_show_context = 1

let g:ale_python_flake8_auto_pipenv = 0
let g:ale_python_flake8_change_directory = 1
let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_flake8_options = ''
let g:ale_python_flake8_use_global = 0

nmap <leader>d <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""
"" Section: startify
""
if !has('nvim')
  set viminfo='100,n$HOME/.config/nvim/files/info
  set viminfo+=n$HOME/.config/nvim/files/info
endif

let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

let g:startify_list_order = ['dir', 'bookmarks', 'sessions', 'commands']
let g:startify_files_number = 5
let g:startify_custom_header =
      \ 'map(startify#fortune#quote(), "\"   \".v:val")'

let g:startify_custom_header_quotes = [
      \ ['VIM: Fr', '', 'Jumps to the false previous r (same line only).']
      \ ]

" don't change into directory, to keep at project root
let g:startify_change_to_dir = 0

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

vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>


let g:python3_host_prog = '/usr/local/bin/python3'

