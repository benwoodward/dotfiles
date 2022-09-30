-- vim: ts=2 sw=2 et:

require('nvim-treesitter.configs').setup {
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  refactor = {
    highlight_current_scope = {enable = true},
    highlight_definitions   = {enable = false},
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename         = 'grr',
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition      = 'gnd',
        list_definitions     = 'gnD',
        list_definitions_toc = 'gO',
        goto_next_usage      = '<a-*>',
        goto_previous_usage  = '<a-#>',
      },
    },
  },
}

require('nvim-treesitter.highlight').set_custom_captures {
  ['camelCase'] = 'TSUnderline',
}