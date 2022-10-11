-- vim: ts=2 sw=2 et:

local nest = require('nest')
local g = vim.g
local wo  = vim.wo
local cmd = vim.cmd
require('plugins.fzf')

g.mapleader      = ' '
g.maplocalleader = ' '

nest.applyKeymaps {
	{ '0', '^' },
	{ '0', '^', options = { noremap = false }, mode = 'v' },
	-- { '^', '0' },

	{ ']t', ':lua require("todo-comments").jump_next()<cr>' },
	{ '[t', ':lua require("todo-comments").jump_prev()<cr>' },

	{ '<Left>',  '<CMD>vertical resize +2<cr>', options = { noremap = false } },
  { '<Right>', '<CMD>vertical resize -2<cr>', options = { noremap = false } },
  { '<Up>',    '<CMD>resize   +2<cr>', options = { noremap = false } },
  { '<Down>',  '<CMD>resize   -2<cr>', options = { noremap = false } },

	-- Previous file
	{ '<Tab>', ':lua load_prev_file()<cr>', options = { noremap = false } },

	{ '<Esc>', '<Esc><Esc>' },

	-- Quit
	{ 'Q', ':q<cr>' },

	-- Move current line to top of screen + 3 lines
	{ 'zu', 'zt<c-y><c-y><c-y>' },

	-- Move current line to bottom of screen - 3 lines
	{ 'zd', 'zb<c-e><c-e><c-e>' },

	-- { 'f', '<Plug>Sneak_f', options = { noremap = false } },
	-- { 'F', '<Plug>Sneak_F', options = { noremap = false } },
	-- { 't', '<Plug>Sneak_t', options = { noremap = false } },
	-- { 'T', '<Plug>Sneak_T', options = { noremap = false } },

	-- { 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>' },
	{ 'gd', '<cmd>lua vim.lsp.buf.definitions()<cr>' },
	-- { 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>' }, -- mapped in nvim-ufo function


	{ 'gx', '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>' },

	{ 'zJ', [[ <Cmd> lua go_next_closed_and_peek()<cr>]] },
	{ 'zK', [[ <Cmd> lua go_previous_closed_and_peek()<cr>]] },

	{ '<A-', {
		{ 'o>', '<c-i>'},
		{ 'j>', 'jjjj' },
		{ 'k>', 'kkkk' },
	}},

	{ '<leader>', {
		{ '0', '0' },
		{ '.', ':Telescope find_files hidden=true<cr>' },

		{ ';', ':Telescope command_history<cr>' },

		-- Edit init.lua
		{ '-', ':e $HOME/.config/nvim/init.lua<cr>'},

		-- TODO: This doesn't work, doesn't seem to be a good solution for this yet
		-- Source init.lua
		-- { 'i', ':lua require(\'nvim-reload\').Reload()<cr>'},

		-- Telescope
		-- { '/',  ':Rg!<cr>' },
		{ '/', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>" },

		{ 'b', ':lua require("telescope.builtin").buffers({ show_all_buffers=true, sort_lastused=true })<cr>' },

		-- downcase a word
		{ 'd', 'mQviwu`Q'},

		{ 'e', ':lua require("telescope.builtin").find_files()<cr>' },

		-- Find git conflict markers <<<<<< | ======
		{ 'fc', '<ESC>/\v^[<=>]{7}( .*\\|$)<cr>' },

		{ 'ff', ':lua require("telescope.builtin").grep_string()<cr>' },

		{ 'fs', ':FloatermNew ranger<cr>' },

		{ 'g', '<Plug>SearchNormal', options = { noremap = false }, mode = 'n' },
		{ 'g', '<Plug>SearchVisual', options = { noremap = false }, mode = 'v'},
		{ 'gr', '<cmd>lua vim.lsp.buf.references()<cr>' },

		-- Toggle search result highlights
		{ 'hl', ':set hlsearch! hlsearch?<cr>'},

		-- Toggle relative numbers on/off
		{ 'ln', ':lua toggle_number_mode()<cr>' },

		{ 'og', ':lua require("telescope.builtin").git_files()<cr>' },
		{ 'op', ':lua require("telescope").extensions.project.project{display_type = "full"}<cr>' },

		{ 'p', ':lua require("telescope").extensions.neoclip.default()<cr>' },

		{ 'r', ':Telescope oldfiles<cr>' },

		{ 't', '<Plug>(toggle-lsp-diag-vtext)' },

		-- upcase a word
		{ 'u', 'mQviwU`Q'},

		{ 'v', ':exe "vnew"<cr>:exe "setlocal buftype=nofile bufhidden=hide"<cr>'},

		-- Write file
		{ 'w', ':w<cr>' },

		{ 'y', ':<CR>:let @a=@" | execute "normal! vgvy" | let res=system("pbcopy", @") | let @"=@a<CR>', mode = 'v'},

		{ 'z', [[ <Cmd> lua toggle_zoom()<CR>]] },
	}},

	{ '<c-', {
		{ 'h>', '<C-\\><C-n><C-w><C-h>' }, 
		{ 'j>', '<C-\\><C-n><C-w><C-j>' },
		{ 'k>', '<C-\\><C-n><C-w><C-k>' },
		{ 'l>', '<C-\\><C-n><C-w><C-l>' },
	}},
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
      width = .80,
    }
  })
end

function _G.go_previous_closed_and_peek()
  require('ufo').goPreviousClosedFold()
  require('ufo').peekFoldedLinesUnderCursor()
  -- require("fold-preview").show_preview()
end

function _G.go_next_closed_and_peek()
  require('ufo').goNextClosedFold()
  require('ufo').peekFoldedLinesUnderCursor()
  -- require("fold-preview").show_preview()
end
