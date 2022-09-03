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

set guifont=Hack\ Nerd\ Font\ Mono:h18

" order matters
runtime! lua/modules/options.lua
runtime! lua/modules/util.lua
runtime! lua/modules/mappings.vim

" packer commands
command! PackerInstall packadd packer.nvim | lua require('plugins.packages').install()
command! PackerUpdate  packadd packer.nvim | lua require('plugins.packages').update()
command! PackerSync    packadd packer.nvim | lua require('plugins.packages').sync()
command! PackerClean   packadd packer.nvim | lua require('plugins.packages').clean()
command! PackerStatus  packadd packer.nvim | lua require('plugins.packages').status()
command! PackerCompile packadd packer.nvim | lua require('plugins.packages').compile('~/.config/nvim/plugin/packer_load.vim')
command! -nargs=+ -complete=customlist,v:lua.require'packer'.loader_complete PackerLoad | lua require('packer').loader(<q-args>)
