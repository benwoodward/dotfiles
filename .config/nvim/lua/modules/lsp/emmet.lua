local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local util = require("lspconfig").util
    local configs = require('lspconfig/configs')
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig["svelte"].setup({
      on_attach = function(client, bufnr)
        require("modules.lsp.mappings").lsp_mappings(bufnr)
      end,
      on_init = function(client, bufnr)
        client.server_capabilities.document_formatting = true

        vim.notify(
          client.name .. ": Svelte Language Server Client successfully started!",
          "info"
        )
      end,
      capabilities = capabilities,
      filetypes = {'html', 'svelte', 'css'},
      default_config = {
        cmd = { 'ls_emmet', '--stdio' },
        root_dir = util.find_git_ancestor,
        settings = {},
      }})
    end,
  }

  return M

 