local M = {}

M.setup = function()
  local null_ls = require "null-ls"
  local b = null_ls.builtins

  vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath "config" .. "/.prettierrc"

  null_ls.setup {
    debounce = 150,
    sources = {
      b.diagnostics.eslint.with {
        command = "eslint_d",
        filetypes = { "svelte" }
      },
      b.formatting.stylua.with {
        args = {
          "--config-path",
          vim.fn.stdpath "config" .. "/stylua.toml",
          "-",
        },
      },
      -- prettier needs to disabled until this is fixed: https://github.com/sveltejs/prettier-plugin-svelte/issues/102
      -- b.formatting.prettierd.with {
      --   filetypes = {
      --     "typescriptreact",
      --     "typescript",
      --     "javascriptreact",
      --     "javascript",
      --     "svelte",
      --     "json",
      --     "jsonc",
      --     "css",
      --   },
      -- },
    },
  }
end

return M
