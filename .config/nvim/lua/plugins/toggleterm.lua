local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end
toggleterm.setup({
  size = 10,
  open_mapping = [[<c-\>]],
  shading_factor = 2,
  direction = "float",
  float_opts = {
    border = "curved",
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})


function _G.set_terminal_keymaps()
  local opts = {noremap = true}

  if vim.fn.mapcheck("<Esc>", "t") ~= "" then
    vim.api.nvim_del_keymap("t", "<Esc>")
  end
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- vim.api.nvim_set_keymap('n', [[<C-\>]], ':ToggleTerm<CR>', { noremap = true, silent = false })

