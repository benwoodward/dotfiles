local utils = require('modules.util')
local map = vim.api.nvim_buf_set_keymap
local telescope = require "telescope.builtin"

local M = {}

M.lsp_mappings = function(bufnr)
  map(bufnr, "i", "<C-s>", '<cmd>lua vim.lsp.buf.signature_help()<CR>', {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "K", '<cmd>lua vim.lsp.buf.hover()<CR>', {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>ga", '<cmd>lua vim.lsp.buf.code_action()<CR>', {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gl", "<cmd>lua vim.lsp.codelens.run()<CR>", {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gD",
    Util.lua_fn(function()
      vim.diagnostic.open_float(0, {
        show_header = false,
        border = Util.borders,
        severity_sort = true,
        scope = "line",
      })
    end),
  {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gr", "<cmd>lua telescope.lsp_references()<CR>", {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gs", "<cmd>lua M.workspace_symbols()<CR>", {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gR", "<cmd>lua vim.lsp.buf.rename()<CR>", {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>g]",
    Util.lua_fn(function()
      vim.diagnostic.goto_next {
        float = { show_header = false, border = Util.borders },
      }
    end),
  {
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>g[",
    Util.lua_fn(function()
      vim.diagnostic.goto_prev {
        float = { show_header = false, border = Util.borders },
      }
    end),
  {
    noremap = true,
    silent = true,
  })
end

return M