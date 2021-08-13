-- vim: ts=2 sw=2 et:

require('nvim_comment').setup()
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap=true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap=true, silent = true})

vim.api.nvim_set_keymap("n", "gcc", ":CommentToggle<CR>", {noremap=true, silent = true})
vim.api.nvim_set_keymap("v", "gcc", ":CommentToggle<CR>", {noremap=true, silent = true})
