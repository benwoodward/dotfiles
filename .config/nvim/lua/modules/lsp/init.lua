local u = require("modules.util")

local lsp = vim.lsp

local border_opts = {border = "single", focusable = false, scope = "line"}

vim.diagnostic.config({virtual_text = false, float = border_opts})

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  -- commands
  -- u.buf_command(bufnr, "LspHover", vim.lsp.buf.hover)
  -- u.buf_command(bufnr, "LspDiagPrev", vim.diagnostic.goto_prev)
  -- u.buf_command(bufnr, "LspDiagNext", vim.diagnostic.goto_next)
  -- u.buf_command(bufnr, "LspDiagLine", vim.diagnostic.open_float)
  -- u.buf_command(bufnr, "LspDiagQuickfix", vim.diagnostic.setqflist)
  -- u.buf_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help)
  -- u.buf_command(bufnr, "LspTypeDef", vim.lsp.buf.type_definition)
  -- u.buf_command(bufnr, "LspRangeAct", vim.lsp.buf.range_code_action)
  -- not sure why this is necessary?
  -- u.buf_command(bufnr, "LspRename", vim.lsp.buf.rename)

  -- bindings
  -- u.buf_map(bufnr, "n", "gi", ":LspRename<CR>")
  -- u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
  -- u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  -- u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  -- u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
  -- u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

  -- u.buf_map(bufnr, "n", "gy", ":LspRef<CR>")
  -- u.buf_map(bufnr, "n", "gh", ":LspTypeDef<CR>")
  -- u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  -- u.buf_map(bufnr, "n", "ga", ":LspAct<CR>")
  -- u.buf_map(bufnr, "v", "ga", "<Esc><cmd> LspRangeAct<CR>")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs({
  "eslint",
  "tsserver",
  "svelte",
}) do
require("modules.lsp." .. server).setup(on_attach, capabilities)
end

-- suppress irrelevant messages
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("%[lspconfig%]") then
    return
  end

  if msg:match("warning: multiple different client offset_encodings") then
    return
  end

  notify(msg, ...)
end
