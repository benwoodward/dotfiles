local opts = { noremap = true, silent = true }
local cmd = vim.cmd

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map('n', '0', '^', opts)
map('v', '0', '^', { noremap = false })

map('n', '<Left>', '<CMD>vertical resize +2<cr>', { noremap = false })
map('n', '<Right>', '<CMD>vertical resize -2<cr>', { noremap = false })
map('n', '<Up>', '<CMD>resize +2<cr>', { noremap = false })
map('n', '<Down>', '<CMD>resize -2<cr>', { noremap = false })
map('n', '<Tab>', ':lua load_prev_file()<cr>', { noremap = false })
map('n', '<Esc>', '<Esc><Esc>', opts)
map('n', 'Q', ':q<cr>', opts)
map('n', 'zu', 'zt<c-y><c-y><c-y>', opts)
map('n', 'zd', 'zb<c-e><c-e><c-e>', opts)
map('n', 'zJ', [[ <Cmd> lua go_next_closed_and_peek()<cr>]], opts)
map('n', 'zK', [[ <Cmd> lua go_previous_closed_and_peek()<cr>]], opts)
map('n', '<leader>0', '0', opts)
map('n', '<leader>.', ':Telescope find_files hidden=true<cr>', opts)
map('n', '<leader>;', ':Telescope command_history<cr>', opts)
map('n', '<leader>-', ':e $HOME/.config/nvim/init.lua<cr>', opts)
map('n', '<leader>/', ':Ag!<cr>', opts)
map('n', '<leader>b', ':lua require("telescope.builtin").buffers({ show_all_buffers=true, sort_lastused=true })<cr>', opts)
map('n', '<leader>d', 'mQviwu`Q', opts)
map('n', '<leader>e', ':lua require("telescope.builtin").find_files()<cr>', opts)
map('n', '<leader>fc', '<ESC>/\v^[<=>]{7}( .*\\|$)<cr>', opts)
map('n', '<leader>ff', ':lua require("telescope.builtin").grep_string()<cr>', opts)
map('n', '<leader>fs', ':Telescope file_browser path=%:p:h select_buffer=true<cr>', opts)
map('n', '<leader>g', '<Plug>SearchNormal', { noremap = false, silent = true }, 'n')
map('v', '<leader>g', '<Plug>SearchVisual', { noremap = false, silent = true }, 'v')
map('n', '<leader>s', ':set hlsearch! hlsearch?<cr><cr>', opts)
map('n', '<leader>n', ':lua toggle_number_mode()<cr>', opts)
map('n', '<leader>og', ':lua require("telescope.builtin").git_files()<cr>', opts)
map('n', '<leader>op', ':lua require("telescope").extensions.project.project{display_type = "full"}<cr>', opts)
map('n', '<leader>p', ':lua require("telescope").extensions.neoclip.default()<cr>', opts)
map('n', '<leader>r', ':Telescope oldfiles<cr>', opts)
map('n', '<leader>t', '<Plug>(toggle-lsp-diag-vtext)<cr>', opts)
map('n', '<leader>u', 'mQviwU`Q', opts)
map('n', '<leader>v', ':exe "vnew"<cr>:exe "setlocal buftype=nofile bufhidden=hide"<cr>', opts)
map('n', '<leader>w', ':w<cr>', opts)
map('v', '<leader>y', ':<CR>:let @a=@" | execute "normal! vgvy" | let res=system("pbcopy", @") | let @"=@a<CR>', { noremap = false, silent = true })
map('n', '<leader>z', [[ <Cmd> lua toggle_zoom()<CR>]], opts)

map('n', '<c-h>', ':wincmd h<cr>', opts)
map('n', '<c-j>', ':wincmd j<cr>', opts)
map('n', '<c-k>', ':wincmd k<cr>', opts)
map('n', '<c-l>', ':wincmd l<cr>', opts)

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