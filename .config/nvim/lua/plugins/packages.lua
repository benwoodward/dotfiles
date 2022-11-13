-- vim: ts=2 sw=2 et:

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end
local u = require("modules.util")

return packer.startup {
  {
    {
      'https://github.com/wbthomason/packer.nvim',
      opt = true,
    },

    {
      -- disable = true,
      'https://github.com/folke/tokyonight.nvim',
      config = function()
        vim.g.tokyonight_style            = 'storm' -- 'storm', 'night'  or 'day'
        vim.g.tokyonight_italic_comments  = true
        vim.g.tokyonight_italic_keywords  = false
        vim.g.tokyonight_italic_functions = false
        vim.g.tokyonight_italic_variables = false
        vim.g.tokyonight_transparent      = false
        vim.g.tokyonight_sidebars         = {'qf', 'vista_kind', 'terminal', 'packer'}
        vim.cmd [[colorscheme tokyonight]]
      end,
    },

    {'https://github.com/kyazdani42/nvim-web-devicons'}, -- makes it possible to display special characters and icons in vim using patched fonts

    -- LSP
    {
      'https://github.com/neovim/nvim-lspconfig',
      config = function()
        require('modules.lsp')
      end,
      requires = {
        'https://github.com/jose-elias-alvarez/null-ls.nvim',
        'https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils'
      },
    },

    -- {'https://github.com/nanotee/nvim-lsp-basics'},

    {
      'https://github.com/folke/trouble.nvim',
      requires = {
        'nvim-web-devicons'
      },
      config = function()
        require('plugins.trouble')
      end,
    }, -- list all diagnostics in separate pane

    -- TreeSitter
    {
      'https://github.com/nvim-treesitter/nvim-treesitter',
      requires = {
        'https://github.com/nvim-treesitter/nvim-treesitter-refactor',
        -- 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        'https://github.com/p00f/nvim-ts-rainbow', -- color-code parentheses
        -- 'polarmutex/contextprint.nvim',
        -- 'https://github.com/theHamsta/nvim-treesitter-pairs',
        'https://github.com/nvim-treesitter/playground',
      },
      run = ':TSUpdate',
      config = function()
        -- causing a weird error in 0.8
        require('plugins.treesitter')
      end,
    },

    -- Git
    {
      'https://github.com/lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('plugins.gitsigns')
      end,
    }, -- jump between hunks, unstage/reset hunks etc.

    {
      'https://github.com/sindrets/diffview.nvim',
      requires = {'nvim-web-devicons'},
      config = function()
        require('plugins.diffview')
      end,
    },

    {'https://github.com/euclidianAce/BetterLua.vim'},

    -- Telescope
    {
      'https://github.com/nvim-telescope/telescope.nvim',
      requires = {
        'https://github.com/nvim-lua/popup.nvim',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-telescope/telescope-project.nvim',
        'https://github.com/nvim-telescope/telescope-live-grep-args.nvim',
        {
          'https://github.com/nvim-telescope/telescope-smart-history.nvim',
          requires = {
            'https://github.com/tami5/sqlite.lua'
          }
        },
        'https://github.com/nvim-telescope/telescope-frecency.nvim',
      },
      config = function()
        require('plugins.telescope')
      end,
    }, -- modal for searching through sources

    {
      "https://github.com/AckslD/nvim-neoclip.lua",
      config = function()
        require('neoclip').setup({
          history = 1000,
          enable_persistent_history = false,
          length_limit = 1048576,
          continuous_sync = false,
          db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
          filter = nil,
          preview = true,
          default_register = '"',
          default_register_macros = 'q',
          enable_macro_history = true,
          content_spec_column = false,
          on_paste = {
            set_reg = true,
          },
          on_replay = {
            set_reg = false,
          },
          keys = {
            telescope = {
              i = {
                select = "<nop>",
                paste = "<cr>",
                paste_behind = "<nop>",
                replay = "<nop>",
                delete = "<c-d>",
                custom = {},
              },
              n = {
                select = "<nop>",
                paste = "<cr>",
                paste_behind = "<nop>",
                replay = "<nop>",
                delete = "dd",
                custom = {},
              }
            },
          },
        })
        require("telescope").load_extension("neoclip")
      end,
      requires = {
        'https://github.com/tami5/sqlite.lua',
      }
    }, -- clipboard history

    -- {
    --   'terrortylor/nvim-comment',
    --   requires = {
    --     'JoosepAlviste/nvim-ts-context-commentstring'
    --   },
    --   config = function()
    --     require('plugins.comment')
    --   end,
    -- },

    {
      'https://github.com/numToStr/Comment.nvim',
      requires = {
        'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
      },
      config = function()
        require('Comment').setup {
          mappings = {
            ---operator-pending mapping
            ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
            basic = true,
            ---extra mapping
            ---Includes `gco`, `gcO`, `gcA`
            extra = true,
            ---extended mapping
            ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
            extended = false,
          },
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
      end,
    }, -- intelligent code commenting

    {
      'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
          require'nvim-treesitter.configs'.setup {
            context_commentstring = {
              enable = true,
              enable_autocmd = false,
            }
          }
        end
    },

    {
      'https://github.com/NvChad/nvim-colorizer.lua',
      config = function()
        require('plugins.colorizer')
      end,
    }, -- highlight CSS colors in the editor

    {'https://github.com/mg979/vim-visual-multi'}, -- multiple cursors

    {'https://github.com/dstein64/nvim-scrollview'}, -- add scrollbars

    { "https://github.com/AndrewRadev/splitjoin.vim", keys = "gS" }, -- convert single line statements to multiline

    {
      'https://github.com/ruifm/gitlinker.nvim',
      key = "gy",
      config = function()
        require('gitlinker').setup {
          mappings = "gy",
        }
      end,
    },

    -- {
    --   'L3MON4D3/LuaSnip',
    --   config = function()
    --     require 'plugins.luasnip'
    --   end,
    -- }, -- snippets

    {
      "https://github.com/hrsh7th/nvim-cmp",
      config = function()
        require "plugins.cmp"
      end,
      requires = {
        "https://github.com/hrsh7th/cmp-nvim-lsp",
        "https://github.com/hrsh7th/cmp-path",
        "https://github.com/hrsh7th/cmp-buffer",
        "https://github.com/tzachar/cmp-tabnine",
        -- "hrsh7th/cmp-vsnip",
        -- "hrsh7th/vim-vsnip",
        "onsails/lspkind-nvim", -- Enables icons on completions
        { -- Snippets
          "L3MON4D3/LuaSnip",
          requires = {
            "saadparwaiz1/cmp_luasnip",
          },
        },
        {
          "zbirenbaum/copilot.lua",
          event = "InsertEnter",
          config = function()
            vim.schedule(function() require("copilot").setup() end)
          end,
        },
        {
          "zbirenbaum/copilot-cmp",
          after = { "copilot.lua" },
          module = "copilot_cmp",
          config = function()
            require("copilot_cmp").setup({
              formatters = {
                insert_text = require("copilot_cmp.format").remove_existing
              },
            })
          end,
        },
      },
    }, -- autocompletions

    {
      'https://github.com/tzachar/cmp-tabnine',
      run='./install.sh',
      requires = { 
        'https://github.com/hrsh7th/nvim-cmp',
        'https://github.com/onsails/lspkind.nvim',
      },
      config = function()
        require('cmp_tabnine.config').setup {
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = '..',
          ignored_file_types = { 
            -- default is not to ignore
            -- uncomment to ignore in lua:
            -- lua = true
          },
          show_prediction_strength = false
        }
      end,
    }, -- autocompletions

    {
      'https://github.com/LionC/nest.nvim',
      config = function()
        require 'plugins.nest'
      end,
    }, -- keymap organization

    {
      "https://github.com/folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          window = {
            width = .85 -- width will be 85% of the editor width
          }
        }
      end
    }, -- center current buffer in editor using <leader>z

    { 'https://github.com/psliwka/vim-smoothie' }, -- Neovide has built-in smoothing

    { 'https://github.com/voldikss/vim-floaterm' }, -- used for ranger / lf

    -- { 'https://github.com/justinmk/vim-sneak' },

    { 'https://github.com/ggandor/lightspeed.nvim',
      config = function()
        require('plugins.lightspeed')
      end,
    }, -- jump around quickly using 's'

    { 'https://github.com/tpope/vim-repeat' },

    { 'https://github.com/Himujjal/tree-sitter-svelte' },

    { 'https://github.com/tpope/vim-surround' },

    { 
      'https://github.com/windwp/nvim-autopairs',
      config = function()
        require("nvim-autopairs").setup{}
      end
    },

    { 'https://github.com/andymass/vim-matchup' },

    { 
      'https://github.com/junegunn/fzf.vim',
      requires = {
        'https://github.com/junegunn/fzf',
        run = vim.fn['fzf#install'],
      }
    },

    { 'https://github.com/voldikss/vim-browser-search' },

    { 'https://github.com/jparise/vim-graphql' },

    { 'https://github.com/jose-elias-alvarez/typescript.nvim' },

    -- { 'https://github.com/danymat/neogen',
    --    config = function()
    --      require('plugins.neogen')
    --    end,
    -- }, -- highlights and allows moving between variable references

    { 'https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' },

    -- { 'https://github.com/JoseConseco/vim-case-change' }, -- vim-abolish is better

    { 'https://github.com/akinsho/toggleterm.nvim',
      config = function()
        require('plugins.toggleterm')
      end
    },

    -- {
    --   'https://github.com/jghauser/fold-cycle.nvim',
    --   config = function()
    --     require('plugins.fold')
    --   end,
    --   requires = 'https://github.com/anuvyklack/pretty-fold.nvim'
    -- },

    -- {
    --   'https://github.com/anuvyklack/pretty-fold.nvim',
    --   config = function()
    --     require('plugins.pretty-fold')
    --   end
    -- },

    -- { 'https://github.com/anuvyklack/fold-preview.nvim',
    --    requires = 'https://github.com/anuvyklack/keymap-amend.nvim',
    --    config = function()
    --       require('plugins.fold-preview')
    --    end
    -- }, -- this isn't needed, because nvim-ufo provides this functionality, however, fold-preview previews look a lot better

    {
      'https://github.com/kevinhwang91/nvim-ufo',
      requires = {
        'https://github.com/kevinhwang91/promise-async'
      },
      config = function()
        require('plugins.nvim-ufo')
      end
    },

    { 
      'https://github.com/tpope/vim-abolish'
    },

    {
      'https://github.com/zhimsel/vim-stay'
    },

    {
      "https://github.com/folke/todo-comments.nvim",
      requires = "https://github.com/nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
        }
      end
    },

    {
      'https://github.com/RRethy/vim-illuminate'
    }, -- highlight usages of word under cursor, more configurable than treesitter-refactor

    -- {
    --   'https://github.com/milkias17/reloader.nvim',
    --   requires = "https://github.com/nvim-lua/plenary.nvim",
    -- }, -- reload config with :Reload

    -- { "https://github.com/anuvyklack/windows.nvim",
    --   requires = {
    --     "https://github.com/anuvyklack/middleclass",
    --     "https://github.com/anuvyklack/animation.nvim"
    --   },
    --   cond = true,
    --   config = function()
    --      vim.o.winwidth = 5
    --      vim.o.winminwidth = 15
    --      vim.o.equalalways = false
    --      require('windows').setup()
    --   end
    -- }, -- automatically resizes vim panes
    { "anuvyklack/windows.nvim",
       requires = {
          "anuvyklack/middleclass",
          "anuvyklack/animation.nvim"
       },
       config = function()
          vim.o.winwidth = 10
          vim.o.winminwidth = 10
          vim.o.equalalways = false
          require('windows').setup()
       end
    }
  },

  config = {
    compile_path = vim.fn.stdpath "data"
      .. "/site/pack/loader/start/packer.nvim/plugin/packer_compiled.lua",
    git = {
      clone_timeout = 300,
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = u.borders }
      end,
    },
  },
}
