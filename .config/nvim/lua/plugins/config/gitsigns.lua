-- vim: ts=2 sw=2 et:

require('gitsigns').setup {
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

    ['n ]c'] = {expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = {expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
  },
  numhl              = true,
  linehl             = false,
  current_line_blame = true,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'right_align',
  sign_priority      = 6,
  update_debounce    = 100,
  status_formatter   = nil,
  use_decoration_api = true,
  use_internal_diff  = true,
}

