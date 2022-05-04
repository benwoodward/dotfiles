local fn, lsp = vim.fn, vim.lsp
local u = require("modules.util")

lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
  border = u.borders,
})

lsp.handlers["textDocument/signatureHelp"] = lsp.with(
  lsp.handlers.signature_help,
  {
    border = u.borders,
  }
)

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = "",
  })
end

vim.diagnostic.config {
  underline = true,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    prefix = "■ ",
    spacing = 4,
    source = "always",
  },
}