-- vim: ts=2 sw=2 et:

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

vim.cmd [[autocmd BufWritePost packages.lua PackerCompile]]

local packer_ok, packer = pcall(require, 'packer')

packer.init {
  git = {
    clone_timeout = 360
  },

  display = {
    open_cmd = 'topleft 80vnew [packer]',
    border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'}
  }
}

require('plugins.packages')

