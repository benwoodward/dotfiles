" syntax match StartifyVim     /VIM/
" syntax match CompleteLine     /.*p/
" highlight default link StartifyVim     Type
" highlight default link CompleteLine    Type

" execute 'syntax region StartifyHeader contains=StartifyVim,CompleteLine start=/\%1l/ end=/\%'. (len(g:startify_header) + 2) .'l/'
