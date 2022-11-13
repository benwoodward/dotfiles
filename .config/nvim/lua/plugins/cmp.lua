local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require('lspkind')

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
      cmp.TriggerEvent.InsertEnter,
    },
    completeopt = "menuone,noinsert,noselect",
    -- keyword_length = 0,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
    --   if cmp.visible() then
    --     local entry = cmp.get_selected_entry()
    --     if not entry then
    --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    --     else
    --       cmp.confirm()
    --     end
    --   else
    --     fallback()
    --   end
    -- end, {"i","s","c",}),
    ["<tab>"] = cmp.mapping({
      i = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
    }),
    ["<C-j>"] = cmp.mapping({
      i = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
    }),
    ["<s-tab>"] = cmp.mapping({
      i = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
    }),
    ["<C-k>"] = cmp.mapping({
      i = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
    }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
    }),
    ["<c-l>"] = cmp.mapping({
      i = cmp.mapping.confirm({select = false}),
    }),
    ["<c-l>"] = vim.schedule_wrap(function(fallback)
      if luasnip.expand_or_jumpable() and has_words_before() then
        luasnip.expand_or_jump()
      elseif cmp.visible() and has_words_before() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end),
    ["<cr>"] = cmp.mapping({
      i = cmp.mapping.confirm({select = false}),
    }),
  },
  sources = {
    -- { name = "copilot" }, -- copilot is not quite there yet, and kinda buggy
    { name = 'cmp_tabnine' },
    { name = "luasnip" },
    -- { name = "nvim_lsp" },
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
    { name = "path" },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,
      require("copilot_cmp.comparators").score,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]

        local menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
          end
          vim_item.kind = ""
        end

        if entry.source.name == "copilot" then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
          end
          vim_item.kind = ""
        end

        vim_item.menu = menu

        return vim_item
      end,
    }),
  },
  experimental = {
    view = {
      -- entries = true,
      entries = { name = 'custom', selection_order = 'near_cursor' } 
    },
    ghost_text = true,
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'nvim_lua' },
    { name = 'cmdline' },
  },
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'buffer' },
  },
})