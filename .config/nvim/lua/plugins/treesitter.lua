return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   version = false, -- last release is way too old and doesn't work on Windows
  --   build = ":TSUpdate",
  --   event = { "BufReadPost", "BufNewFile" },
  --   dependencies = {
  --     { "nvim-treesitter/nvim-treesitter-textobjects" },
  --     { "RRethy/nvim-treesitter-textsubjects" },
  --   },
  --   config = function(_, opts)
  --     require('nvim-treesitter.configs').setup {
  --       -- Add languages to be installed here that you want installed for treesitter
  --       -- ensure_installed = { 'go', 'lua', 'python', 'tsx', 'typescript', 'svelte', 'help', 'vim' },

  --       -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  --       -- auto_install = true,

  --       highlight = { enable = true },
  --       indent = { enable = false, disable = { 'python' } },
  --       textsubjects = {
  --         enable = true,
  --         prev_selection = ',', -- (Optional) keymap to select the previous selection
  --         keymaps = {
  --           ['.'] = 'textsubjects-smart',
  --           [';'] = 'textsubjects-container-outer',
  --           ['i;'] = 'textsubjects-container-inner', -- doesn't seem to work
  --         },
  --       },
  --       matchup = { -- vim-matchup
  --         enable = true,
  --       },
  --     }
  --   end,
  -- },

  {
    "https://github.com/hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local ts = require('vim.treesitter')

      require('treesj').setup({
        use_default_keymaps = false,
        cursor_behavior = 'start',
        max_join_length = 200,
        langs = {
          svelte = {
            ['quoted_attribute_value'] = {
              both = {
                enable = function(tsn)
                  return tsn:parent():type() == 'attribute'
                end,
              },
              split = {
                format_tree = function(tsj)
                  local str = tsj:child('attribute_value')
                  local words = vim.split(str:text(), ' ')
                  tsj:remove_child('attribute_value')
                  for i, word in ipairs(words) do
                    tsj:create_child({ text = word }, i + 1)
                  end
                end,
              },
              join = {
                format_tree = function(tsj)
                  local str = tsj:child('attribute_value')
                  local node_text = str:text()
                  tsj:remove_child('attribute_value')
                  tsj:create_child({ text = node_text }, 2)
                end,
              },
            },
          }
        }
      })
    end,
  },
}
