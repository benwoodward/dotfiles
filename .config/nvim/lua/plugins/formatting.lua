return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      vue = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      less = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      jsonc = { "prettierd", "prettier" },
      graphql = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      astro = { "prettierd", "prettier" },
      svelte_fmt = {
        command = "prettier",
        args = { "--plugin", "prettier-plugin-svelte", "--stdin-filepath", "$FILENAME" },
      },
    },
  },
}
