-- vim: ts=2 sw=2 et:

require('util.keys')
local g = vim.g

g.mapleader      = ' '
g.maplocalleader = ' '

nnoremap('<Leader>w', ':w<CR>')
nnoremap('<Leader>q', ':q<CR>')

-- Reload Restart
nnoremap('<Leader>vr', ':Reload<CR>')
nnoremap('<Leader>vR', ':Restart<CR>')

-- Telescope
nnoremap('<Leader>bb', ':lua require("telescope.builtin").buffers{show_all_buffers = true}<CR>')
nnoremap('<C-p>',      ':lua require("telescope").extensions.project.project{display_type = "full"}<CR>')

