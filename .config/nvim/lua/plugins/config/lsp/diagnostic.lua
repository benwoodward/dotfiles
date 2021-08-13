-- vim: ts=2 sw=2 et:

local api = vim.api
local lspconfig = require('lspconfig')
local sign_define = vim.fn.sign_define

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 2,
      --prefix = '~'
    },
    signs = true,
    update_in_insert = true,
  }
)

sign_define("LspDiagnosticsSignError", {
    text   = ' ',
    texthl = 'LspDiagnosticsSignError',
    numhl  = 'LspDiagnosticsSignError'
  }
)

sign_define("LspDiagnosticsSignWarning", {
    text   = ' ',
    texthl = 'LspDiagnosticsSignWarning',
    numhl  = 'LspDiagnosticsSignWarning'
  }
)

sign_define("LspDiagnosticsSignInformation", {
    text   = ' ',
    texthl = 'LspDiagnosticsSignInformation',
    numhl  = 'LspDiagnosticsSignInformation'
  }
)

sign_define("LspDiagnosticsSignHint", {
    text   = ' ',
    texthl = 'LspDiagnosticsSignHint',
    numhl  = 'LspDiagnosticsSignHint'
  }
)

