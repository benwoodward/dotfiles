let s:user = "wbthomason"
let s:repo = "packer.nvim"
let s:install_path = stdpath("data") . "/site/pack/packer/opt/" . s:repo
if empty(glob(s:install_path)) > 0
  execute printf("!git clone https://github.com/%s/%s %s", s:user, s:repo, s:install_path)
  packadd repo
endif

" map leader key to space
let g:mapleader = " "
let g:maplocalleader = " "

" Neovide settings
set guifont=Hack\ Nerd\ Font\ Mono:h18
let g:neovide_input_use_logo=v:true

" order matters
runtime! lua/modules/options.lua
runtime! lua/modules/mappings.vim

lua <<EOF
local null_ls = require('null-ls')
local lsp = require('lsp-zero')
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require('lspkind')

lsp.configure("tsserver", {
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
  end
})

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
  vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
      filter = function(client)
        return client.name == "null-ls"
      end
    end,
  })
end

null_ls.setup({
  debug = false,
  sources = { null_ls.builtins.formatting.prettier },
  on_attach = format_on_save
})

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp_format_on_save(bufnr)
end)

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'svelte',
  'html',
  'cssls',
  'emmet_ls',
})

lsp.setup_nvim_cmp({
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
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          cmp.confirm()
        end
      else
        fallback()
      end
    end, {"i","s","c",}),
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
  }),
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
  experimental = {
    view = {
      -- entries = true,
      entries = { name = 'custom', selection_order = 'near_cursor' } 
    },
    ghost_text = true,
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
EOF

" packer commands
command! PackerInstall packadd packer.nvim | lua require('plugins.packages').install()
command! PackerUpdate  packadd packer.nvim | lua require('plugins.packages').update()
command! PackerSync    packadd packer.nvim | lua require('plugins.packages').sync()
command! PackerClean   packadd packer.nvim | lua require('plugins.packages').clean()
command! PackerStatus  packadd packer.nvim | lua require('plugins.packages').status()
command! PackerCompile packadd packer.nvim | lua require('plugins.packages').compile('~/.config/nvim/plugin/packer_load.vim')
command! -nargs=+ -complete=customlist,v:lua.require'packer'.loader_complete PackerLoad | lua require('packer').loader(<q-args>)