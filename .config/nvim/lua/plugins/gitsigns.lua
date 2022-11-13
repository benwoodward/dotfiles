 -- vim: ts=2 sw=2 et:

require('gitsigns').setup {
  diff_opts = {
    internal = true,
  },
  signs = {
    add          = {hl = 'GitSignsAdd',    text = '+', numhl = 'GitSignsAddNr',    linehl = 'GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '!', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
  },
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer  = true,

    ['n ]c'] = {expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<cr><cr>'"},
    ['n [c'] = {expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<cr><cr>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<cr><cr>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr><cr>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<cr><cr>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<cr><cr>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<cr><cr>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<cr><cr>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<cr><cr>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<cr><cr>'
  },
  watch_gitdir = {
    interval = 1000,
  },
  numhl              = false,
  linehl             = false,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 1000,
    virt_text_pos = 'eol',
  },
  sign_priority      = 6,
  update_debounce    = 100,
  status_formatter   = nil,
}

