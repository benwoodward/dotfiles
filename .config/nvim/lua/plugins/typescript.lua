return {

  -- correctly setup lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = { "jose-elias-alvarez/typescript.nvim" },
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       ---@type lspconfig.options.tsserver
  --       tsserver = {
  --         settings = {
  --           completions = {
  --             completeFunctionCalls = true,
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       tsserver = function(_, opts)
  --         vim.api.nvim_create_autocmd("LspAttach", {
  --           callback = function(args)
  --             local buffer = args.buf
  --             local client = vim.lsp.get_client_by_id(args.data.client_id)
  --             on_attach = function(client, buffer)
  --               if client.name == "tsserver" then
  --                 -- stylua: ignore
  --                 vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
  --                 -- stylua: ignore
  --                 vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
  --               end
  --             end
  --           end,
  --         })
  --         require("typescript").setup({ server = opts })
  --         return true
  --       end,
  --     },
  --   },
  -- },

 
}
