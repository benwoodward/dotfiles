local opts = { noremap = true, silent = true }
local cmd  = vim.cmd
local wo   = vim.wo
local api  = vim.api

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
-- map('n', '<leader>/', ':Ag!<cr>', opts)
map('n', '<leader>b', ':lua require("telescope.builtin").buffers({ show_all_buffers=true, sort_lastused=true })<cr>',
  opts)
map('n', '<leader>d', 'mQviwu`Q', opts)
map('n', '<leader>e', ':lua find_files_gitdir()<cr>', opts)
map('n', '<leader>/', ':lua live_grep_gitdir()<cr>', opts)
map('n', '<leader>r', ':lua oldfiles_gitdir()<cr>', opts)
map('n', '<leader>fc', '<ESC>/\v^[<=>]{7}( .*\\|$)<cr>', opts)
map('n', '<leader>ff', ':lua require("telescope.builtin").grep_string()<cr>', opts)
map('n', '<leader>fr', ':FloatermNew ranger<cr>', opts)
map('n', '<leader>g', '<Plug>SearchNormal', { noremap = false, silent = true }, 'n')
map('v', '<leader>g', '<Plug>SearchVisual', { noremap = false, silent = true }, 'v')
map('n', '<leader>h', ':set hlsearch! hlsearch?<cr><cr>', opts)
map('n', '<leader>n', ':lua toggle_number_mode()<cr>', opts)
map('n', '<leader>og', ':lua require("telescope.builtin").git_files()<cr>', opts)
map('n', '<leader>op', ':lua require("telescope").extensions.project.project{display_type = "full"}<cr>', opts)
map('n', '<leader>p', ':lua require("telescope").extensions.neoclip.default()<cr>', opts)
map('n', '<leader>t', '<Plug>(toggle-lsp-diag-vtext)<cr>', opts)
map('n', '<leader>u', 'mQviwU`Q', opts)
map('n', '<leader>v', ':exe "vnew"<cr>:exe "setlocal buftype=nofile bufhidden=hide"<cr>', opts)
map('n', '<leader>w', ':w<cr>', opts)
map('v', '<leader>y', ':<CR>:let @a=@" | execute "normal! vgvy" | let res=system("pbcopy", @") | let @"=@a<CR>',
  { noremap = false, silent = true })
map('n', '<leader>z', [[ <Cmd> lua toggle_zoom()<CR>]], opts)
map('n', '<leader>fs', ':lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>:w<cr>', opts)
map('n', '<leader>gu', ':GitBlameOpenCommitURL<cr>', opts)
map('n', '<leader>gb', [[ <Cmd> lua toggle_gitblame_virtual_text()<CR>]], opts)
map('n', 'G', [[<Cmd> lua maybe_smooth_scroll()<CR>]], opts)
map('n', 'gM', ":lua require('treesj').toggle()<cr>", opts)
map('n', 'gS', ":lua require('treesj').split()<cr>", opts)
map('n', 'gJ', ":lua require('treesj').join()<cr>", opts)

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

map('n', '<A-w>', ':WindowsToggleAutowidth<cr>', opts)

-- dial
vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })

-- substitute
vim.keymap.set("n", "r", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "rr", require('substitute').line, { noremap = true })
vim.keymap.set("n", "R", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "r", require('substitute').visual, { noremap = true })

-- hlslens
local kopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
vim.api.nvim_set_keymap('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

function _G.toggle_gitblame_virtual_text()
  if vim.g.gitblame_display_virtual_text == 0 then
    vim.g.gitblame_display_virtual_text = 1
  else
    vim.g.gitblame_display_virtual_text = 0
  end
end

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

function _G.maybe_smooth_scroll()
  local win_height = api.nvim_win_get_height(0)
  local buf_line_count = api.nvim_buf_line_count(0)

  if buf_line_count < win_height then
    api.nvim_command('normal! G')
  else
    require('neoscroll').scroll(1 * buf_line_count, true, 1, 5)
  end
end

function _G.get_git_dir()
  local git_dir = vim.fn.trim(vim.fn.system "git rev-parse --show-toplevel")
  return git_dir
end

local builtin = require "telescope.builtin"

function _G.live_grep_gitdir()
  local git_dir = get_git_dir()
  if git_dir == "" then
    builtin.live_grep()
  else
    builtin.live_grep {
      cwd = git_dir,
    }
  end
end

function _G.find_files_gitdir()
  local git_dir = get_git_dir()
  if git_dir == "" then
    builtin.find_files()
  else
    builtin.find_files {
      cwd = git_dir,
    }
  end
end

function _G.oldfiles_gitdir()
  local git_dir = get_git_dir()
  if git_dir == "" then
    builtin.oldfiles()
  else
    builtin.oldfiles {
      cwd = git_dir,
    }
  end
end

