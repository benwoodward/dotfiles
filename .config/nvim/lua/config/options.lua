-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

if vim.env.CONDUCTOR_WORKSPACE_PATH then
  opt.cursorcolumn = true
end

opt.signcolumn = "no" -- prevent jumpiness while scrolling

if not vim.env.SSH_TTY then
  opt.clipboard = "" -- Don't sync with system clipboard
end

vim.diagnostic.config({
  virtual_lines = false,
})

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Number of spaces for indentation
vim.opt.tabstop = 2 -- Number of spaces a tab represents
vim.opt.softtabstop = 2 -- Number of spaces for tab key

-- Specifically for JS/TS files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})
