-- -- vim: ts=2 sw=2 et:

-- local api = vim.api
-- local lspconfig = require('lspconfig')
-- local sign_define = vim.fn.sign_define

-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--   vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     virtual_text = {
--       spacing = 2,
--       --prefix = '~'
--     },
--     signs = true,
--     update_in_insert = true,
--   }
-- )

-- sign_define("LspDiagnosticsSignError", {
--     text   = ' ',
--     texthl = 'LspDiagnosticsSignError',
--     numhl  = 'LspDiagnosticsSignError'
--   }
-- )

-- sign_define("LspDiagnosticsSignWarning", {
--     text   = ' ',
--     texthl = 'LspDiagnosticsSignWarning',
--     numhl  = 'LspDiagnosticsSignWarning'
--   }
-- )

-- sign_define("LspDiagnosticsSignInformation", {
--     text   = ' ',
--     texthl = 'LspDiagnosticsSignInformation',
--     numhl  = 'LspDiagnosticsSignInformation'
--   }
-- )

-- sign_define("LspDiagnosticsSignHint", {
--     text   = ' ',
--     texthl = 'LspDiagnosticsSignHint',
--     numhl  = 'LspDiagnosticsSignHint'
--   }
-- )

local fn, lsp = vim.fn, vim.lsp

lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
  border = {
      -- fancy border
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }
})

lsp.handlers["textDocument/signatureHelp"] = lsp.with(
  lsp.handlers.signature_help,
  {
    border = {
      -- fancy border
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  function(_, _, params, client_id, _)
    local config = {
      underline = true,
      virtual_text = {
        prefix = "■ ",
        spacing = 4,
      },
      signs = true,
      update_in_insert = false,
    }
    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = params.diagnostics

    for i, v in ipairs(diagnostics) do
      diagnostics[i].message = string.format("%s: %s", v.source, v.message)
    end

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
  end

local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " ",
}

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
