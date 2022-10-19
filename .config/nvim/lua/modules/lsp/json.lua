local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")

    lspconfig["json"].setup({
      cmd = { "vscode-json-languageserver", "--stdio" },
      filetypes = { "json", "jsonc" },
      on_init = function(client, bufnr)
        client.server_capabilities.document_formatting = true

        vim.notify(
          client.name .. ": JSON Language Server Client successfully started!",
          "info"
        )
      end,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { "package.json" },
              url = "https://json.schemastore.org/package.json",
            },
            {
              fileMatch = { "jsconfig*.json" },
              url = "https://json.schemastore.org/jsconfig.json",
            },
            {
              fileMatch = { "tsconfig*.json" },
              url = "https://json.schemastore.org/tsconfig.json",
            },
            {
              fileMatch = {
                ".prettierrc",
                ".prettierrc.json",
                "prettier.config.json",
              },
              url = "https://json.schemastore.org/prettierrc.json",
            },
            {
              fileMatch = { ".eslintrc", ".eslintrc.json" },
              url = "https://json.schemastore.org/eslintrc.json",
            },
            {
              fileMatch = { "nodemon.json" },
              url = "https://json.schemastore.org/nodemon.json",
            },
          },
        },
      },
    })
  end,
}

return M