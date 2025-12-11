return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "vv",
          node_incremental = ".",
          node_decremental = ",",
        },
      },
      highlight = { enable = true },
      ensure_installed = { "svelte", "javascript", "typescript", "html", "css" }, -- Install Svelte parser
      matchup = { -- vim-matchup
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    },
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local ts = require("vim.treesitter")

      require("treesj").setup({
        use_default_keymaps = false,
        cursor_behavior = "start",
        max_join_length = 200,
        langs = {
          svelte = {
            ["quoted_attribute_value"] = {
              both = {
                enable = function(tsn)
                  return tsn:parent():type() == "attribute"
                end,
              },
              split = {
                format_tree = function(tsj)
                  local str = tsj:child("attribute_value")
                  local words = vim.split(str:text(), " ")
                  tsj:remove_child("attribute_value")
                  for i, word in ipairs(words) do
                    tsj:create_child({ text = word }, i + 1)
                  end
                end,
              },
              join = {
                format_tree = function(tsj)
                  local str = tsj:child("attribute_value")
                  local node_text = str:text()
                  tsj:remove_child("attribute_value")
                  tsj:create_child({ text = node_text }, 2)
                end,
              },
            },
          },
        },
      })
    end,
  },
}
