local M = {}

function M.setup()
  vim.g.nvim_tree_side       = 'left'
  vim.g.nvim_tree_width      = 65

  vim.g.nvim_tree_auto_open  = 0
  vim.g.nvim_tree_auto_close = 1
  vim.g.nvim_tree_follow     = 1
  vim.g.nvim_tree_tab_open   = 1

  vim.g.nvim_tree_lsp_diagnostics = 1
  vim.g.nvim_tree_gitignore  = 0

  vim.g.nvim_tree_ignore     = {
    '.git',
    '.hg',
    '.svn',
    'node_modules'
  }

  vim.g.nvim_tree_show_icons = {
    git     = 1,
    folders = 1,
    files   = 1
  }

  vim.g.nvim_tree_icons = {
    default      = " ",
    symlink      = "",
    git= {
      unstaged   = "✗",
      staged     = "✓",
      unmerged   = "",
      renamed    = "➜",
      untracked  = "★"
    },
    folder = {
      default    = "",
      open       = "",
      empty      = "",
      empty_open = ""
    },
    lsp = {
      hint       = "",
      info       = "",
      warning    = "",
      error      = "",
    }
  }

    vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle<CR>', {
        noremap = true,
        silent = true
    })

    vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {
        noremap = true,
        silent = true
    })
end

return M
