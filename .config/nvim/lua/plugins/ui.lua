return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
        virtual_lines = false, -- Move it here instead
      },
      servers = {
        astro = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
        },
        markdown = {
          autostart = false,
        },
      },
    },
  },

  {
    "http://github.com/dmmulroy/ts-error-translator.nvim",
    opts = {},
  },

  {
    "http://github.com/andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "https://github.com/NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
          cmp_docs = { always_update = true }, -- necessary for highlighting tailwind colors in cmp menu
          "!TelescopeResults", -- https://github.com/nvim-telescope/telescope.nvim/issues/2490#issuecomment-1616160620
        },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = false, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { css } }, -- Enable sass colors
          virtualtext = "■",
          always_update = true, -- necessary for highlighting tailwind colors in cmp menu
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      })
    end,
  },

  { "https://github.com/mg979/vim-visual-multi" },

  { "https://github.com/dstein64/nvim-scrollview" },
  { "https://github.com/voldikss/vim-floaterm" }, -- used for ranger / lf

  {
    "https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require("toggle_lsp_diagnostics").init({ all = true, start_on = true })
    end,
  },

  {
    "https://github.com/akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local status_ok, toggleterm = pcall(require, "toggleterm")
      if not status_ok then
        return
      end
      toggleterm.setup({
        size = 20,
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
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },

  {
    "https://github.com/kevinhwang91/nvim-ufo",
    dependencies = {
      "https://github.com/kevinhwang91/promise-async",
    },
    config = function()
      -- TODO: https://github.com/kevinhwang91/nvim-ufo/issues/4
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.foldcolumn = '5'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- TODO: move these to nest.lua
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      -- vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          -- choose one of coc.nvim and nvim lsp
          vim.lsp.buf.hover()
        end
      end)

      -- Option 3: treesitter as a main provider instead
      -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        preview = {
          win_config = {
            winblend = 0,
            winhighlight = "NormalFloat:FoldPreview,FloatBorder:FoldPreviewBorder",
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
          },
        },
      })
    end,
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("smart-splits").setup({
        default_amount = 5,
        cursor_follows_swapped_bufs = true,
        at_edge = "stop",
      })
    end,
  },

  {
    "https://github.com/folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          width = 0.85, -- width will be 85% of the editor width
        },
      })
    end,
  }, -- center current buffer in editor using <leader>z

  {
    -- Git Blame plugin for Neovim written in Lua
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 1
      vim.g.gitblame_display_virtual_text = 1
      vim.g.gitblame_ignored_filetypes = { "gitcommit" }
      vim.g.gitblame_message_when_not_committed = " Not committed yet"
      vim.g.gitblame_delay = 1000
      vim.g.gitblame_message_template = "    <committer> (<date>) • <summary> "
    end,
  },

  {
    "https://github.com/kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
    end,
  },

  {
    "https://github.com/kevinhwang91/nvim-bqf",
  },

  {
    "https://github.com/psliwka/vim-smoothie",
  },

  -- {
  --   'https://github.com/declancm/cinnamon.nvim',
  --   config = function()
  --     require('cinnamon').setup()
  --   end
  -- },
}
