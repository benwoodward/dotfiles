local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  completion = {
    completeopt = "menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-j>"] = cmp.mapping({
      i = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
    }),
    ["<C-k>"] = cmp.mapping({
      i = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
    }),
    ["<C-l>"] = cmp.mapping({
      i = cmp.mapping.confirm({select = false}),
    }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
    }),
    ["<CR>"] = cmp.mapping({
      i = cmp.mapping.confirm({select = true}),
    }),
    -- ["<C-Space>"] = cmp.mapping({
    --   i = cmp.mapping.complete(),
    -- }),
  },
  sources = {
    {name = "luasnip", priority = 9999},
    {name = "nvim_lsp"},
    {name = "path"},
    {
      name = "buffer",
      option = {
        -- complete from visible buffers
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
  },
})
