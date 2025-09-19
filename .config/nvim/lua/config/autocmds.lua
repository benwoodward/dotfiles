-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local karabiner = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

local function set_nv(var)
  -- Sets {"nvim_active": var}
  vim.fn.jobstart({ karabiner, "--set-variables", string.format('{"nvim_active": %d}', var) }, { detach = true })
end

-- on startup, mark Neovim active
set_nv(1)

-- Enter/leave Neovim
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, { callback = function() set_nv(1) end })
vim.api.nvim_create_autocmd({ "FocusLost", "VimLeavePre", "VimLeave" }, { callback = function() set_nv(0) end })

-- Safety: if your terminal restores focus without firing FocusGained/Lost
vim.api.nvim_create_autocmd("UIEnter", { callback = function() set_nv(1) end })

