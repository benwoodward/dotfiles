-- vim: ts=2 sw=2 et:

local o   = vim.o
local g   = vim.g
local wo  = vim.wo

-- Global options {{{
o.updatetime    = 800
o.termguicolors = true
o.mouse         = 'n'
o.ignorecase    = true
o.wrap          = false

o.wildmenu      = true
o.wildmode      = 'full'
o.hlsearch      = true

o.listchars     = [[tab:→ ,space:·,eol:¶,trail:·,extends:↷,precedes:↶]]

o.clipboard     = 'unnamedplus'

o.completeopt   = 'menuone,noinsert'

o.backup        = false -- true
o.undofile      = true
-- }}}
-- Window options {{{
wo.number       = true
wo.list         = true

wo.cursorline   = true
wo.cursorcolumn = true
-- }}}

-- g.loaded_node_provider   = 0
-- g.loaded_ruby_provider   = 0
g.loaded_perl_provider   = 0
g.loaded_python_provider = 0

