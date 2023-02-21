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
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'svelte',
  'html',
  'cssls',
  'emmet_ls',
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

local null_ls = require('null-ls')

local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
      })
    end
  end,
})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.formatting.prettierd,
  }
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