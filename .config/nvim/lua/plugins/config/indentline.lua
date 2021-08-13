-- vim: ts=2 sw=2 et:

local g = vim.g

g.indent_blankline_char             = '▏'
g.indent_blankline_filetype_exclude = {
  'NvimTree',
  'git',
  'help',
  'lspinfo',
  'markdown',
  'packer',
  'startify',
  'tex',
  'txt',
}
g.indent_blankline_buftype_exclude = {
  'terminal',
}
g.indent_blankline_context_patterns = {
  'class',
  'funtion',
  'method',
  '^if',
  'while',
  'for',
  'with',
  'func_literal',
  'block',
  'try',
  'except',
  'argument_list',
  'object',
  'dictionary'
}
g.indent_blankline_show_current_context           = true
g.indent_blankline_show_first_indent_level        = false
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_space_char_blankline           = '·'
g.indent_blankline_use_treesitter                 = true
