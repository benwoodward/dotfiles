-- vim: ts=2 sw=2 et:

local actions   = require('telescope.actions')
local telescope = require('telescope')

-- Extensions
require('telescope').load_extension('project')
require('telescope').load_extension('dap')

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix      = "> ",
    selection_caret    = "> ",
    entry_prefix       = "  ",
    initial_mode       = "insert",
    selection_strategy = "reset",
    sorting_strategy   = "descending",
    layout_strategy    = "horizontal",
    layout_config = {
      height = 1,
      width  = 0.75,
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      prompt_position = "bottom",
      preview_cutoff  = 120,
    },
    file_sorter          = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter       = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display         = {},
    winblend             = 0,
    border               = {},
    borderchars          = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons       = true,
    use_less             = true,
    set_env              = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer       = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer       = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer     = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

vim.api.nvim_set_keymap('n', '<Leader>ob', ':Telescope buffers show_all_buffers=true sort_lastused=true<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>of', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>og', ':Telescope git_files<CR>', {})
-- vim.api.nvim_set_keymap('n', '<Leader>', ':Telescope <CR>', {})
