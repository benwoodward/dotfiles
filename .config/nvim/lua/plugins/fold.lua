require('fold-cycle').setup({
  open_if_max_closed = true,    -- closing a fully closed fold will open it
  close_if_max_opened = true,   -- opening a fully open fold will close it
  softwrap_movement_fix = false -- see below
})

vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
"set foldtext=substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))
"set foldnestmax=20
"set foldminlines=1
"set foldlevel=99
"set foldmethod=indent
]])

-- vim.o.foldtext = [[substitute(getline(v:foldstart),'\\\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

vim.api.nvim_set_keymap('n', 'zo', [[<cmd>lua require('fold-cycle').open()<cr>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'zc', [[<cmd>lua require('fold-cycle').close()<cr>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'zC', [[<cmd>lua require('fold-cycle').close_all()<cr>]], {noremap = false, silent = true})
-- vim.keymap.set('n', 'zo',
--   function() return require('fold-cycle').open() end,
--   {silent = true, desc = 'Fold-cycle: open folds'})
-- vim.keymap.set('n', 'zc',
--   function() return require('fold-cycle').close() end,
--   {silent = true, desc = 'Fold-cycle: close folds'})
-- vim.keymap.set('n', 'zC',
--   function() return require('fold-cycle').close_all() end,
--   {remap = true, silent = true, desc = 'Fold-cycle: close all folds'})