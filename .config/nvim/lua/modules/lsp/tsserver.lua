local u = require("modules.util")

local M = {}
M.setup = function(on_attach, capabilities)
  require("typescript").setup({
    server = {
      on_attach = function(client, bufnr)
        require("modules.lsp.mappings").lsp_mappings(bufnr)

        u.buf_map(bufnr, "n", "gs", ":TypescriptRemoveUnused<CR>")
        -- u.buf_map(bufnr, "n", "gS", ":TypescriptOrganizeImports<CR>") -- conflicts with splitjoin gS
        u.buf_map(bufnr, "n", "go", ":TypescriptAddMissingImports<CR>")
        u.buf_map(bufnr, "n", "gA", ":TypescriptFixAll<CR>")
        u.buf_map(bufnr, "n", "gI", ":TypescriptRenameFile<CR>")

        if client.name == "tsserver" then
          local ts_utils = require "nvim-lsp-ts-utils"
          ts_utils.setup {
            auto_inlay_hints = true, -- enable this once #9496 got merged
            enable_import_on_completion = true,
          }
          ts_utils.setup_client(client)
        end

        on_attach(client, bufnr)
      end,
      on_init = function(client, bufnr)
        client.server_capabilities.document_formatting = false

        vim.notify(
          client.name .. ": Typescript Language Server Client successfully started!",
          "info"
        )
      end,
      capabilities = capabilities,
    },
  })
end

return M
