" TODO:
" - Comment, and group all Plugins with configs and by type
" - Group settings/configs, functions, mappings etc.
" - Divide sections with " ================ Section: Name ===========================

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin()

" Switches between a single-line statement and a multi-line one
Plug 'git@github.com:AndrewRadev/splitjoin.vim.git'

" Emmet for Vim, make HTML without going mad
Plug 'git@github.com:mattn/emmet-vim.git', { 'for': ['html', 'vue', 'javascript', 'css', 'svelte'] }

Plug 'git@github.com:tpope/vim-rails.git', { 'for': ['rb'] } " Rails shortcuts
Plug 'git@github.com:junegunn/vim-easy-align.git' " Alignment plugin with smart key bindings
Plug 'git@github.com:stephpy/vim-yaml.git', { 'for': ['yaml.yml'] } " YAML hightlighting
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git' " Fuzzy search files, ctags and more
Plug 'mhinz/vim-signify' " Alternative to git-gutter, shortcuts: [c, ]c, [C, ]C
Plug 'git@github.com:elzr/vim-json.git' " JSON highlighter
Plug 'git@github.com:bronson/vim-trailing-whitespace.git' " Hightligts trailing whitespace characters in red
Plug 'git@github.com:scrooloose/nerdtree.git' " File browser in sidebar
Plug 'git@github.com:tpope/vim-fugitive.git' " Github commands
Plug 'git@github.com:tpope/vim-surround.git' " Easily surround things with things, e.g. string -> 'string'
Plug 'git@github.com:terryma/vim-multiple-cursors.git' " Pretty effective multiple cursors functionality
Plug 'git@github.com:ludovicchabant/vim-gutentags.git' " The best ctags plugin for Vim
Plug 'git@github.com:keith/swift.vim.git' " Swift syntax highlighting
Plug 'git@github.com:vim-ruby/vim-ruby.git' " Ruby syntax highlighting
Plug 'git@github.com:henrik/vim-reveal-in-finder.git' " Reveal current file in Finder
Plug 'mattn/webapi-vim'
Plug 'https://github.com/mattn/gist-vim' " Post selected code to Gist
Plug 'gfontenot/vim-xcode' " Create and build XCode projects without using the dreaded XCode
Plug 'mileszs/ack.vim' " Search files, configured to work with ripgrep
" Plug 'jerrymarino/SwiftPlayground.vim' " Disabled because it's broken / don't use it
Plug 'git@github.com:benwoodward/SwiftPlayground.vim.git', { 'branch': 'regex-fix'}
Plug 'othree/yajs.vim' " Most up to date JS highlighter, works well with React
Plug 'mhartington/oceanic-next' " Best dark colorscheme
Plug 'othree/html5.vim' " html5 syntax highlighting
Plug 'maxmellon/vim-jsx-pretty' " Jsx syntax highlighting
Plug 'elixir-editors/vim-elixir' " Elixir syntax highlighting
Plug 'farmergreg/vim-lastplace' " Open file at last place edited
Plug 'ruanyl/vim-gh-line' " Open current file at current line on Github
Plug 'voldikss/vim-searchme' " Search under cursor with options
Plug 'git://github.com/tommcdo/vim-lion.git'
Plug 'maksimr/vim-jsbeautify'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'posva/vim-vue'
Plug 'sbdchd/neoformat'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'floobits/floobits-neovim'
Plug '~/Dev/GitHub/CoVim-Neovim', {'branch': 'neovim'}
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-mix-format'
Plug 'liuchengxu/vista.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'voldikss/vim-floaterm'
Plug 'HendrikPetertje/vimify'
Plug 'psliwka/vim-smoothie'
Plug 'evanleck/vim-svelte'
Plug 'tpope/vim-commentary'
Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }
Plug 'sheerun/vim-polyglot'



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

nnoremap <c-]> :call FollowTag()<CR>

let g:gutentags_enabled = 1
let g:gutentags_trace = 0
let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", "vendor", ".git", "node_modules", "*.vim/bundle/*"]
let g:gutentags_file_list_command = '( rg --files --no-ignore lib | rg .ex ; rg --files --no-ignore deps | rg .ex ) | cat'

" enable gtags module
" let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
" let g:gutentags_cache_dir = expand('~/.cache/tags')


""
"" Section: open-browser
""
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


""
"" Section: Coc.nvim
""
let g:coc_global_extensions = [
      \ 'coc-emoji', 'coc-eslint', 'coc-prettier',
      \ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
      \ 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml',
      \ 'coc-snippets', 'coc-elixir'
      \ ]

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-n>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-p>'

" Use <C-j> and <C-k> to navigate the completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

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

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')



""
"" Section: Nerdtree
""
let g:NERDSpaceDelims = 1 " TODO: This does what?
let nerdtreeshowlinenumbers=1 " TODO: This does what?
let g:NERDTreeWinPos = "right"

" Locate current file in Nerdtree
map <leader>nf :NERDTreeFind<cr>
map <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
augroup AuNERDTreeCmd " TODO: This does what?

let NERDTreeHijackNetrw=0
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '\.beam']

" so it doesn't complain about types it doesn't know
let NERDShutUp = 1

" quit NERDTree after opening a file
let NERDTreeQuitOnOpen=0

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
let g:ctrlp_root_markers = ['mix.exs', 'Gemfile']

" Search ctags
nmap <Leader>c :CtrlPTag<CR>

" Search buffers
nmap <Leader>r :CtrlPBuffer<CR>

" Map CtrlP to <Leader>p
let g:ctrlp_map = ''
map <Leader>p :CtrlP<CR>

" Use RipGrep with CtrlP
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob "" --ignore-file $HOME/.ctrlp-ignore --hidden'
  let g:ctrlp_use_caching = 0
endif

""
"" Section: Ack
"" TODO: How do Ack, Ag, rg, CtrlP work together?
""       Do I need Ack?
" let g:ackprg = 'ag --nogroup --nocolor --column' " Use ag with Ack
let g:ackprg = 'rg --vimgrep --no-heading --smart-case --ignore-file $HOME/.gitignore' " Use rg with Ack
" map <leader>f :Ack<space>

noremap F :Clap grep<CR>
noremap ff :Clap grep ++query=<cword><CR>




" TODO: Why has this stopped working?
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
map <leader>fws :FixWhitespace<CR>

" insert hashrocket, =>, with control-l
imap <C-l> <Space>=><Space>

""
"" Section: Filetypes
"" TODO: Add to 'augroup'?
""

au BufNewFile,BufRead *.es6 set filetype=javascript
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

" map <c-f> :call JsBeautify()<cr>
" " or
" autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" " for json
" autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" " for jsx
" autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" " for html
" autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" " for css or scss
" autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>


let g:python3_host_prog = '/usr/local/bin/python3'

" Turn off auto-indendation before pasting
set pastetoggle=<F3>

map <leader>o :!open % -a "Xcode-beta"<enter>

let g:mix_format_on_save = 1

map Q :q<CR>
map W :w<CR>

" if executable('sourcekit-lsp')
    " au User lsp_setup call lsp#register_server({
        " \ 'name': 'sourcekit-lsp',
        " \ 'cmd': {server_info->['sourcekit-lsp']},
        " \ 'whitelist': ['swift'],
        " \ })
" else
  " echohl ErrorMsg
  " echom 'Sorry, `sourcekit-lsp` is not installed. See `:help vim-lsp-swift` for more details on setup.'
  " echohl NONE
" endif

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

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


" Incsearch {{{
let g:incsearch#auto_nohlsearch                   = 1 " auto unhighlight after searching
let g:incsearch#do_not_save_error_message_history = 1 " do not store incsearch errors in history
let g:incsearch#consistent_n_direction            = 1 " when searching backward, do not invert meaning of n and N

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


" Fzf {{{
  " use bottom positioned 20% height bottom split
  let g:fzf_layout = { 'down': '~20%' }
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Clear'],
    \ 'hl':      ['fg', 'String'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

    " keeping Rg command since the built-in one does not skip checking filenames
  " for an in-file search...
  command! -bang -nargs=* Rg
   \ call fzf#vim#grep(
   \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
   \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
   \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '§'),
   \   <bang>0)

  " only use FZF shortcuts in non diff-mode
  if !&diff
    nnoremap <C-g> :Rg<Cr>
  endif

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

let g:vim_markdown_strikethrough = 1


function! s:goyo_enter()
  set wrap
  set linebreak
  " set noshowmode
  " set noshowcmd
  set scrolloff=999
  set filetype=markdown
endfunction

function! s:goyo_leave()
  set nowrap
  set nolinebreak
  set showmode
  set showcmd
  set scrolloff=0
  autocmd! BufRead
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:floaterm_width = float2nr(&columns * 0.7)
let g:floaterm_height = float2nr((&lines - 2) * 0.6)
let g:floaterm_position = 'center'

noremap  <silent> <F12>           :FloatermToggle<CR>
noremap! <silent> <F12>           <Esc>:FloatermToggle<CR>
tnoremap <silent> <F12>           <C-\><C-n>:FloatermToggle<CR>

highlight VertSplit guibg=NONE


let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o -path '_build' -prune -o -path 'deps' -prune -o -path 'tags' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(10)
  let width = float2nr(80)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" nnoremap <silent> <leader>t :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>

nnoremap <silent> <leader>t :Clap files<CR>

" set timeoutlen=100

let g:spotify_token=$VIMIFY_SPOTIFY_TOKEN

let g:vista_fzf_preview = ['right:50%']

