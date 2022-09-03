local status, fold = pcall(require, "fold-preview")
if not status then
  return
end

local keymap = vim.keymap
keymap.amend = require("keymap-amend")
local map = require("fold-preview").mapping

keymap.amend("n", "K", map.show_close_preview_open_fold)

fold.setup({
  border = "rounded",
})
