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

-- Filetype detection for helixql
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hx",
  callback = function()
    vim.bo.filetype = "helixql"
  end,
})

-- Enable treesitter highlighting for helixql
vim.api.nvim_create_autocmd("FileType", {
  pattern = "helixql",
  callback = function(args)
    vim.treesitter.start(args.buf, "helixql")
  end,
})

-- Register custom helixql parser
local function register_helixql_parser()
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if ok then
    parsers.helixql = {
      install_info = {
        path = "/Users/ben/dev/helixdb-treesitter/tree-sitter-helixql",
        files = { "src/parser.c", "src/scanner.c" },
      },
      filetype = "helixql",
    }
  end
end

-- Register on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(register_helixql_parser)
  end,
})

-- Re-register on TSUpdate
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = register_helixql_parser,
})

