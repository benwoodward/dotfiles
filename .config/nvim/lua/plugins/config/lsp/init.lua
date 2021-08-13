-- vim: ts=2 sw=2 et:

require('plugins.config.lsp.settings')
require('plugins.config.lsp.diagnostic')

-- Pretty icons
vim.lsp.protocol.CompletionItemKind = {
  '  [text]',
  '[method]',
  '  [function]',
  '[constructor]',
  '[field]',
  '[variable]',
  '[class]',
  '[interface]',
  '[module]',
  '[property]',
  '[unit]',
  '[value]',
  '[enum]',
  '[key]',
  '  [snippet]',
  '[color]',
  '[file]',
  '[reference]',
  '  [folder]',
  '[enum member]',
  '[constant]',
  '[struct]',
  '[event]',
  '[operator]',
  '[type]',
}

