-- vim: ts=2 sw=2 et:

local o   = vim.o
local g   = vim.g
local wo  = vim.wo

g.smoothie_experimental_mappings = true
g["sneak#label"] = 1

-- Global options {{{
o.updatetime    = 800
o.termguicolors = true
o.mouse         = 'n'
o.ignorecase    = true
o.wrap          = false

o.wildmenu      = true
o.wildmode      = 'full'
o.hlsearch      = true   -- highlight search results
o.linebreak     = true
o.tabstop       = 2      -- a tab is two spaces
o.shiftwidth    = 2      -- an autoindent (with <<) is two spaces
o.expandtab     = true   -- use spaces, not tabs
o.backspace     = [[indent,eol,start]]  -- backspace through everything in insert mode
o.listchars     = [[tab:→ ,space: ,trail:·,extends:↷,precedes:↶]]
o.clipboard     = 'unnamedplus'
o.completeopt   = 'menuone,noinsert'
o.backup        = false -- true
o.splitbelow     = true -- split below instead of above
o.splitright     = true -- split right instead of left
o.undofile      = true
-- }}}
-- Window options {{{
wo.number       = true
wo.relativenumber = true
wo.numberwidth  = 3
wo.list         = true

wo.cursorline   = true
wo.cursorcolumn = false
-- }}}

-- g.loaded_node_provider   = 0
-- g.loaded_ruby_provider   = 0
g.loaded_perl_provider   = 0
g.loaded_python_provider = 0

