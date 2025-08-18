-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
local cmd = vim.cmd
local wo = vim.wo
local api = vim.api

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

map("n", "<c-i>", "<c-i>", opts)
map("n", "0", "^", opts)
map("v", "0", "^", { noremap = false })

map("n", "<Left>", "<CMD>vertical resize +2<cr>", { noremap = false })
map("n", "<Right>", "<CMD>vertical resize -2<cr>", { noremap = false })
map("n", "<Up>", "<CMD>resize +2<cr>", { noremap = false })
map("n", "<Down>", "<CMD>resize -2<cr>", { noremap = false })
map("n", "<Tab>", ":lua load_prev_file()<cr>", { noremap = false })
map("n", "<Esc>", "<Esc><Esc>", opts)
map("n", "Q", ":q<cr>", opts)
map("n", "<C-e>", "3<C-e>", opts)
map("n", "<C-y>", "3<C-y>", opts)
map("n", "zu", "zt<c-y><c-y><c-y>", opts)
map("n", "zd", "zb<c-e><c-e><c-e>", opts)
map("n", "zJ", [[ <Cmd> lua go_next_closed_and_peek()<cr>]], opts)
map("n", "zK", [[ <Cmd> lua go_previous_closed_and_peek()<cr>]], opts)
map("n", "<leader>0", "0", opts)
map("n", "<leader>.", ":Telescope find_files hidden=true<cr>", opts)
map("n", "<leader>;", ":Telescope command_history<cr>", opts)
map("n", "<leader>-", ":e $HOME/.config/nvim/init.lua<cr>", opts)
-- map('n', '<leader>/', ':Ag!<cr>', opts)
map(
  "n",
  "<leader>b",
  ':lua require("telescope.builtin").buffers({ show_all_buffers=true, sort_lastused=true })<cr>',
  opts
)
map("n", "<leader>d", "mQviwu`Q", opts)
map("n", "<leader>e", ":Telescope find_files<cr>", opts)
map("n", "<leader>/", ":Telescope live_grep<cr>", opts)
map("n", "<leader>r", ":lua oldfiles_gitdir()<cr>", opts)
map("n", "<leader>fc", "<ESC>/\v^[<=>]{7}( .*\\|$)<cr>", opts)
map("n", "<leader>ff", ':lua require("telescope.builtin").grep_string()<cr>', opts)
map("n", "<leader>fr", ":FloatermNew ranger<cr>", opts)
map("n", "<leader>g", "<Plug>SearchNormal", { noremap = false, silent = true }, "n")
map("v", "<leader>g", "<Plug>SearchVisual", { noremap = false, silent = true }, "v")
map("n", "<leader>h", ":set hlsearch! hlsearch?<cr><cr>", opts)
map("n", "<leader>n", ":lua toggle_number_mode()<cr>", opts)
map("n", "<leader>og", ':lua require("telescope.builtin").git_files()<cr>', opts)
map("n", "<leader>op", ':lua require("telescope").extensions.project.project{display_type = "full"}<cr>', opts)
map("n", "<leader>p", ':lua require("telescope").extensions.neoclip.default()<cr>', opts)
map("n", "<leader>u", "mQviwU`Q", opts)
map("n", "<leader>v", ':exe "vnew"<cr>:exe "setlocal buftype=nofile bufhidden=hide"<cr>', opts)
map("n", "<leader>bh", ':exe "new"<cr>:exe "setlocal buftype=nofile bufhidden=hide"<cr>', opts)
map("n", "<leader>w", ":w<cr>", opts)
map(
  "v",
  "<leader>y",
  ':<CR>:let @a=@" | execute "normal! vgvy" | let res=system("pbcopy", @") | let @"=@a<CR>',
  { noremap = false, silent = true }
)
map("n", "<leader>z", [[ <Cmd> lua toggle_zoom()<CR>]], opts)
map("n", "<leader>gu", ":GitBlameOpenCommitURL<cr>", opts)
map("n", "<leader>gb", [[ <Cmd> lua toggle_gitblame_virtual_text()<CR>]], opts)
map("n", "gM", ":lua require('treesj').toggle()<cr>", opts)
map("n", "gS", ":lua require('treesj').split()<cr>", opts)
map("n", "gJ", ":lua require('treesj').join()<cr>", opts)

-- lsp stuff
map("n", "<leader>t", "<Plug>(toggle-lsp-diag-vtext)<cr>", opts)
map("n", "<leader>fs", ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>:w<cr>", opts)
map("n", "<leader>gt", ":lua vim.lsp.buf.type_definition()<cr>", opts)

-- nvim-surround visual selection (S is used by leap)
map("v", "<leader>s", "<Plug>(nvim-surround-visual)", { noremap = true, silent = true })

-- lspsaga
-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Code action
-- vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

-- Rename all occurrences of the hovered word for the entire file
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)

-- Rename all occurrences of the hovered word for the selected files
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>", opts)

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)

-- Go to definition
-- vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)

-- Go to type definition
-- vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window, show error
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show buffer diagnostics
vim.keymap.set("n", "<leader>bd", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

-- Show workspace diagnostics
-- vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)

-- Show cursor diagnostics
vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
-- vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
-- vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Diagnostic jump with filters such as only jumping to an error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Toggle outline
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opt)

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)

-- Call hierarchy
-- vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
-- vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opt)

-- Floating terminal
-- vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", opts)

-- jumping to context (upwards) - https://github.com/nvim-treesitter/nvim-treesitter-context
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true })

-- nvim-dap
vim.keymap.set("n", "<leader>dc", '<cmd>lua require"dap".continue()<cr>', opts)
vim.keymap.set("n", "<leader>dr", '<cmd>lua require"dap".repl.open()<cr>', opts)
vim.keymap.set("n", "<leader>ds", '<cmd>lua require"dap".step_over()<cr>', opts)
vim.keymap.set("n", "<leader>di", '<cmd>lua require"dap".step_into()<cr>', opts)
vim.keymap.set("n", "<leader>do", '<cmd>lua require"dap".step_out()<cr>', opts)
vim.keymap.set("n", "<leader>db", '<cmd>lua require"dap".toggle_breakpoint()<cr>', opts)
vim.keymap.set(
  "n",
  "<leader>dB",
  '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>',
  opts
)
vim.keymap.set(
  "n",
  "<leader>dl",
  '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>',
  opts
)

vim.keymap.set("n", "<leader>sf", ":GetCurrentFunctionsForce telescope<cr>", opts)

-- nvim-dap-ui
vim.keymap.set("n", "<leader>du", '<cmd>lua require"dapui".open()<cr>', opts)
vim.keymap.set("n", "<leader>dt", '<cmd>lua require"dapui".toggle()<cr>', opts)
vim.keymap.set("n", "<leader>dq", '<cmd>lua require"dapui".close()<cr>', opts)

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

map("n", "<leader><space>", ":WindowsToggleAutowidth<cr>", opts)
map("n", "<leader>ll", ":PrtChatNew<cr>", opts)

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
vim.keymap.set("n", "r", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "rr", require("substitute").line, { noremap = true })
vim.keymap.set("n", "R", require("substitute").eol, { noremap = true })
vim.keymap.set("x", "r", require("substitute").visual, { noremap = true })

-- hlslens
local kopts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', 'n',
--   [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
--   kopts)
-- vim.api.nvim_set_keymap('n', 'N',
--   [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
--   kopts)

vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)

-- neovide clipboard stuff
if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

function _G.toggle_gitblame_virtual_text()
  if vim.g.gitblame_display_virtual_text == 0 then
    vim.g.gitblame_display_virtual_text = 1
  else
    vim.g.gitblame_display_virtual_text = 0
  end
end

function _G.load_prev_file()
  cmd("b#")
end

function _G.toggle_number_mode()
  wo.number = true
  wo.relativenumber = not wo.relativenumber
end

function _G.toggle_zoom()
  require("zen-mode").toggle({
    window = {
      width = 0.80,
    },
  })
end

function _G.go_previous_closed_and_peek()
  require("ufo").goPreviousClosedFold()
  require("ufo").peekFoldedLinesUnderCursor()
  -- require("fold-preview").show_preview()
end

function _G.go_next_closed_and_peek()
  require("ufo").goNextClosedFold()
  require("ufo").peekFoldedLinesUnderCursor()
  -- require("fold-preview").show_preview()
end
