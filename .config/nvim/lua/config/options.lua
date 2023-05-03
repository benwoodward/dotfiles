-- vim: ts=2 sw=2 et:

local o   = vim.o
local opt = vim.opt
local g   = vim.g
local wo  = vim.wo

vim.cmd.colorscheme 'tokyonight-storm'
-- vim.opt.guifont = { "Hack Nerd Font Mono", ":h18" }
vim.opt.guifont = "Hack Nerd Font Mono:h18"
-- vim.opt.guifont = "iMWritingDuospace Nerd Font Mono:h18"

g.smoothie_experimental_mappings = true
g.fzf_history_dir = './.fzf-history'
g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/data/snippets'


-- Global options {{{
o.encoding      = 'utf8'
o.formatoptions = o.formatoptions .. "cro" -- auto-comment next line after comment
o.hidden        = true
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
o.softtabstop   = 2
o.shiftwidth    = 2      -- an autoindent (with <<) is two spaces
o.expandtab     = true   -- use spaces, not tabs
o.autoindent    = true
o.smartindent   = true
o.backspace     = [[indent,eol,start]]  -- backspace through everything in insert mode
o.listchars     = [[tab:→ ,space: ,trail:·,extends:↷,precedes:↶]]
o.completeopt   = 'menuone,noinsert'
o.backup        = false -- true
o.splitbelow    = true -- split below instead of above
o.splitright    = true -- split right instead of left
o.undofile      = true
o.textwidth     = 95
o.virtualedit   = ''

opt.viewoptions = 'cursor,folds,slash,unix'

-- Window options {{{
wo.number       = true
wo.relativenumber = true
wo.signcolumn   = 'yes'
wo.numberwidth  = 3
wo.list         = true
wo.cursorline   = true
wo.cursorcolumn = false
-- }}}

-- g.loaded_node_provider   = 0
-- g.loaded_ruby_provider   = 0
g.loaded_perl_provider   = 0
g.loaded_python_provider = 0

vim.cmd [[
  syntax enable
]]


vim.env.FZF_DEFAULT_OPTS = table.concat({
  vim.env.FZF_DEFAULT_OPTS or '',
  ' --layout reverse',
  ' --info inline',
  ' --pointer " "',
  ' --border rounded',
}, '')

vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

-- neovim 0.8 stuff:
-- Hide statusline by setting laststatus and cmdheight to 0.
-- o.ls = 0
o.ch = 0

-- Set the winbar to the statusline.
o.wbr = o.stl

-- With vertical splits, the statusline would still show up at the
-- bottom of the split. A quick fix is to just set the statusline
-- to empty whitespace (it can't be an empty string because then
-- it'll get replaced by the default stline).
-- o.stl = " "

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.9,
  }
}

vim.diagnostic.config({
  virtual_text = true,
})