-- vim: foldmethod=marker

local cmp = require "cmp"
local remap = vim.api.nvim_set_keymap

cmp.setup {
  completion = {
    autocomplete = true,
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  documentation = {
    border = "solid",
  },
  sources = {
    { name = "nvim_lsp", priority = 10 },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 8 },
  },
  mapping = {
    ["<C-j>"] = cmp.mapping.select_next_item { cmp.SelectBehavior.Select },
    ["<C-k>"] = cmp.mapping.select_prev_item { cmp.SelectBehavior.Select },
    ["<C-l>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
}

remap(
  "i",
  "<CR>",
  "v:lua.Util.trigger_completion()",
  { noremap = true, expr = true }
)