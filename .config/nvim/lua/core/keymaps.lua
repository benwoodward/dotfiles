-- vim: ts=2 sw=2 et:

local nest = require('nest')
local g = vim.g
local wo  = vim.wo
local cmd = vim.cmd

g.mapleader      = ' '
g.maplocalleader = ' '

nest.applyKeymaps {
	{ '<Left>',  '<CMD>vertical resize +2<CR>', options = { noremap = false } },
  { '<Right>', '<CMD>vertical resize -2<CR>', options = { noremap = false } },
  { '<Up>',    '<CMD>resize   +2<CR>', options = { noremap = false } },
  { '<Down>',  '<CMD>resize   -2<CR>', options = { noremap = false } },

  { '<a-', {

  	-- buffer movements
		{ 'l>', '<CMD>bn<CR>' },
		{ 'h>', '<CMD>bp<CR>' },
  }},

	-- Quit
	{ 'Q', ':q<cr>' },

	-- Move current line to top of screen + 3 lines
	{ 'zu', 'zt<c-y><c-y><c-y>' },

	-- Move current line to bottom of screen - 3 lines
	{ 'zd', 'zb<c-e><c-e><c-e>' },

	-- Previous file
	{ '<Tab>', ':lua load_prev_file()<cr>' },

	{ 'f', '<Plug>Sneak_f', options = { noremap = false } },
	{ 'F', '<Plug>Sneak_F', options = { noremap = false } },
	{ 't', '<Plug>Sneak_t', options = { noremap = false } },
	{ 'T', '<Plug>Sneak_T', options = { noremap = false } },

	{ 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>' },
	{ 'gd', '<cmd>lua vim.lsp.buf.definitions()<cr>' },
	{ 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>' },

	-- nvim_comment
	{ 'gcc', '<cmd>CommentToggle<cr>' },
	{ 'gcc', '<cmd>CommentToggle<cr>' },

	{ '<leader>', {
		-- Edit init.lua
		{ '-', ':e $HOME/.config/nvim/init.lua<cr>'},

		-- TODO: This doesn't work, doesn't seem to be a good solution for this yet
		-- Source init.lua
		-- { 'i', ':lua require(\'nvim-reload\').Reload()<cr>'},

		-- Telescope
		{ '/',  ':lua require("telescope.builtin").live_grep()<cr>' },
		{ 'ff', ':lua require("telescope.builtin").grep_string()<cr>' },
		{ 'b', ':lua require("telescope.builtin").buffers({ show_all_buffers=true, sort_lastused=true })<cr>' },
		{ 'e', ':lua require("telescope.builtin").find_files()<cr>' },
		{ 'og', ':lua require("telescope.builtin").git_files()<cr>' },
		{ 'op', ':lua require("telescope").extensions.project.project{display_type = "full"}<cr>' },
		{ 'oc', ':Telescope neoclip<cr>' },

		-- Find git conflict markers <<<<<< | ======
		{ 'fc', '<ESC>/\v^[<=>]{7}( .*\\|$)<cr>' },

		{ 'fs', ':FloatermNew ranger<cr>' },

		{ 'gr', '<cmd>lua vim.lsp.buf.references()<cr>' },

		-- Toggle search result highlights
		{ 'hl', ':set hlsearch! hlsearch?<cr>'},

		-- Toggle relative numbers on/off
		{ 'ln', ':lua toggle_number_mode()<cr>' },

		-- upcase a word
		{ 'u', 'mQviwU`Q'},

		-- downcase a word
		{ 'd', 'mQviwu`Q'},

		{ 'v', ':exe "vnew"<cr>:exe "setlocal buftype=nofile bufhidden=hide"<cr>'},

		-- Write file
		{ 'w', ':w<cr>' },

		{ 'y', ':OSCYank<cr>', mode = 'v' },

		{ 'z', [[ <Cmd> lua toggle_zoom()<CR>]] },
	}},

	{ '<c-', {
		{ 'h>', '<C-\\><C-n><C-w><C-h>' },
		{ 'j>', '<C-\\><C-n><C-w><C-j>' },
		{ 'k>', '<C-\\><C-n><C-w><C-k>' },
		{ 'l>', '<C-\\><C-n><C-w><C-l>' },

		{ 'w>', '<cmd>lua require"hop".hint_words()<cr>' },

	}}
}


function _G.load_prev_file()
	cmd('b#')
end

function _G.toggle_number_mode()
  wo.number = true
  wo.relativenumber = not wo.relativenumber
end

function _G.toggle_zoom()
  require("zen-mode").toggle({
    window = {
      width = .65,
    }
  })
end