local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")

    lspconfig["svelte"].setup({
      filetypes = { "svelte" },
      on_attach = function(client, bufnr)
        require("modules.lsp.mappings").lsp_mappings(bufnr)

        client.server_capabilities.completionProvider.triggerCharacters = {
          ".", "\"", "'", "`", "/", "@", "*",
          "#", "$", "+", "^", "(", "[", "-", ":",
        }

        if client.name == "tsserver" then
          local ts_utils = require "nvim-lsp-ts-utils"
          ts_utils.setup {
            auto_inlay_hints = true, -- enable this once #9496 got merged
            enable_import_on_completion = true,
          }
          ts_utils.setup_client(client)
        end
      end,
      on_init = function(client, bufnr)
        if
          client.name == "svelte"
          or client.name == "tsserver"
        then
          client.resolved_capabilities.document_formatting = false
        end

        vim.notify(
          client.name .. ": Language Server Client successfully started!",
          "info"
        )
      end,
      capabilities = capabilities,
      settings = {
        svelte = {
          plugin = {
            html   = { completions = { enable = true, emmet = false } },
            svelte = { completions = { enable = true, emmet = false } },
            css    = { completions = { enable = true, emmet = true  } },
          },
        },
      },
    })
  end,
}

return M