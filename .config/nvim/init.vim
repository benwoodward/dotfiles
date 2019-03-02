" TODO:
" - Comment, and group all Plugins with configs and by type
" - Group settings/configs, functions, mappings etc.
" - Divide sections with " ================ Section: Name ===========================

call plug#begin()

Plug 'git@github.com:ap/vim-css-color.git'
Plug 'git@github.com:tpope/vim-abolish.git'
Plug 'git@github.com:Raimondi/delimitMate.git'
Plug 'git@github.com:AndrewRadev/splitjoin.vim.git'
Plug 'git@github.com:tpope/vim-bundler.git'
Plug 'git@github.com:mattn/emmet-vim.git'
Plug 'git@github.com:tpope/vim-rails.git'
Plug 'git@github.com:tyru/open-browser.vim.git'
Plug 'git@github.com:junegunn/vim-easy-align.git'
Plug 'git@github.com:stephpy/vim-yaml.git'
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git'
Plug 'git@github.com:ervandew/supertab.git'
" Plug 'git@github.com:airblade/vim-gitgutter.git' " Disabled due to lag
Plug 'git@github.com:elzr/vim-json.git'
Plug 'git@github.com:bronson/vim-trailing-whitespace.git'
Plug 'git@github.com:scrooloose/nerdtree.git'
Plug 'git@github.com:scrooloose/nerdcommenter.git'
Plug 'git@github.com:tpope/vim-fugitive.git'
Plug 'git@github.com:Chun-Yang/vim-action-ag.git'
Plug 'git@github.com:tpope/vim-surround.git'
Plug 'git@github.com:terryma/vim-multiple-cursors.git'
Plug 'git@github.com:ludovicchabant/vim-gutentags.git'
Plug 'git@github.com:keith/swift.vim.git'
Plug 'git@github.com:kana/vim-textobj-user.git'
Plug 'git@github.com:vim-ruby/vim-ruby.git'
Plug 'git@github.com:henrik/vim-reveal-in-finder.git'
Plug 'https://github.com/mattn/gist-vim'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'gfontenot/vim-xcode'
Plug 'mileszs/ack.vim'
" Plug 'itchyny/lightline.vim' " Disabled due to lag
Plug 'christoomey/vim-tmux-runner'
" Plug 'jerrymarino/SwiftPlayground.vim'
" Plug 'git@github.com:benwoodward/SwiftPlayground.vim.git', { 'branch': 'regex-fix'}
Plug 'w0rp/ale'
Plug 'dikiaap/minimalist'
Plug 'othree/yajs.vim'
Plug 'mhartington/oceanic-next'
Plug 'othree/html5.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'tpope/vim-repeat'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-startify'
Plug 'farmergreg/vim-lastplace'
Plug 'ruanyl/vim-gh-line'
Plug 'voldikss/vim-searchme'
Plug 'tpope/vim-rhubarb'

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
set ruler

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
set colorcolumn=80

" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

" flashes matching brackets or parentheses
set showmatch

" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

" Set temporary directory (don't litter local dir with swp/tmp files)
set directory=/tmp/

""
"" Whitespace
""
set nowrap                        " don't wrap lines
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
map <leader>f :NERDTreeFind<cr>
map <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
augroup AuNERDTreeCmd " TODO: This does what?

let NERDTreeHijackNetrw=0
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']

" so it doesn't complain about types it doesn't know
let NERDShutUp = 1

" quit NERDTree after openning a file
let NERDTreeQuitOnOpen=1

" colored NERD Tree
let NERDChristmasTree = 1

" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'


" previous file
" map <Leader>p <C-^>
function! LoadPreviousFile()
  b#
endfunction

" Toggle between current and previous file
nmap <Tab> :call LoadPreviousFile()<CR>

ino <Leader>e <esc>
cno <Leader>e <c-c>
vno <Leader>e <esc>

" Open latest commit in browser
map lc :Gbrowse HEAD^{}<CR>

" Open current file at HEAD in browser
map flc :Gbrowse HEAD^{}:%<CR>


" vim-search-me
" https://github.com/voldikss/vim-search-me
"
" Search word under cursor in default browser
noremap  <Leader>ss :<C-u>SearchCurrentText<CR>
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

" TODO: Can this just be specified in the general wildignore var?
let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v[\/]\.(git|hg|svn)$|bower_components|node_modules',
 \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
 \ }

" Use RipGrep with CtrlP
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

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
map <leader>fws :FixWhitespace

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

nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

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

let g:netrw_nogx = 0 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)



set smartcase

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
"" Section: Ack
"" TODO: How do Ack, Ag, rg, CtrlP work together?
""       Do I need Ack?
let g:ackprg = 'ag --nogroup --nocolor --column'
map <leader>f :Ack<space>


""
"" Section: Ale
"" https://github.com/w0rp/ale
""
let g:ale_enabled = 1

let g:ale_linters = {
  \   'javascript': ['eslint'],
  \}
let g:ale_open_list = 1 " show when there are errors

" always show sign column, so text doesn't move around
let g:ale_sign_column_always = 1

" Errors
let g:ale_sign_error = '✖︎'
highlight ALEErrorSign guifg=red ctermfg=red
let g:ale_echo_msg_error_str = 'E'

" Warnings
let g:ale_sign_warning = '✔︎'
highlight ALEWarningSign guifg=grey ctermfg=grey
let g:ale_echo_msg_warning_str = 'W'

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:move_key_modifier = 'N'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

nmap <leader>d <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""
"" Section: startify
""
if !has('nvim')
	set viminfo='100,n$HOME/.vim/files/info/viminfo
endif

let g:startify_list_order = ['dir', 'bookmarks', 'sessions', 'commands']

" don't change into directory, to keep at project root
let g:startify_change_to_dir = 0

" init.vim editing
map <leader>- :e $HOME/.config/nvim/init.vim<CR>

" source init.vim
map <leader>v :source $HOME/.config/nvim/init.vim<CR>

" Terminal
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
