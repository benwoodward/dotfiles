-- vim: ts=2 sw=2 et:

local actions   = require('telescope.actions')
local telescope = require('telescope')

-- Extensions
require('telescope').load_extension('project')

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
      horizontal = {
        height = 0.8,
        width  = 0.75,
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      prompt_position = "bottom",
      preview_cutoff  = 120,
    },
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
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
