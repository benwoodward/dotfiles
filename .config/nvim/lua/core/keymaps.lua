-- vim: ts=2 sw=2 et:

local nest = require('nest')
local g = vim.g
local wo  = vim.wo
local cmd = vim.cmd

g.mapleader      = ' '
g.maplocalleader = ' '

nest.applyKeymaps {
	-- Quit
	{ 'Q', ':q<CR>' },

	-- Move current line to top of screen + 3 lines
	{ 'zu', 'zt<c-y><c-y><c-y>' },

	-- Move current line to bottom of screen - 3 lines
	{ 'zd', 'zb<c-e><c-e><c-e>' },

	-- Previous file
	{ '<Tab>', ':lua load_prev_file()<CR>' },

	{ 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>' },
	{ 'gd', '<cmd>lua vim.lsp.buf.definitions()<cr>' },
	{ 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>' },

	{ '<leader>', {
		-- Edit init.lua
		{ '-', ':e $HOME/.config/nvim/init.lua<CR>'},

		-- TODO: This doesn't work, doesn't seem to be a good solution for this yet
		-- Source init.lua
		-- { 'i', ':lua require(\'nvim-reload\').Reload()<CR>'},

		{ 'bb', ':lua require("telescope.builtin").buffers{show_all_buffers = true}<CR>' },

		-- Find git conflict markers <<<<<< | ======
		{ 'fc', '<ESC>/\v^[<=>]{7}( .*\\|$)<CR>' },

		{ 'gr', '<cmd>lua vim.lsp.buf.references()<cr>' },

		-- Toggle search result highlights
		{ 'hs', ':set hlsearch! hlsearch?<CR>'},

		-- upcase a word
		{ 'u', 'mQviwU`Q'},

		-- downcase a word
		{ 'd', 'mQviwu`Q'},

		-- Write file
		{ 'w', ':w<CR>' },
	}},

	{ '<C-', {
		-- Toggle relative numbers on/off
		{ 'l>', ':lua toggle_number_mode()<CR>' },

		{ 'p>', ':lua require("telescope").extensions.project.project{display_type = "full"}<CR>' }
	}}
}


function _G.load_prev_file()
	cmd('b#')
end

function _G.toggle_number_mode()
  wo.number = true
  wo.relativenumber = not wo.relativenumber
end