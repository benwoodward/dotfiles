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
      ensure_installed = { "svelte", "javascript", "typescript", "html", "css" },
      matchup = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
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
