-- vim: ts=2 sw=2 et:

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

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
    --   'https://github.com/tzachar/cmp-tabnine',
    --   run='./install.sh',
    --   requires = { 
    --     'https://github.com/hrsh7th/nvim-cmp',
    --     'https://github.com/onsails/lspkind.nvim',
    --   },
    --   config = function()
    --     require('cmp_tabnine.config').setup {
    --       max_lines = 1000,
    --       max_num_results = 20,
    --       sort = true,
    --       run_on_every_keystroke = true,
    --       snippet_placeholder = '..',
    --       ignored_file_types = { 
    --         -- default is not to ignore
    --         -- uncomment to ignore in lua:
    --         -- lua = true
    --       },
    --       show_prediction_strength = false
    --     }
    --   end,
    -- }, -- autocompletions

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

    -- { 'https://github.com/jose-elias-alvarez/typescript.nvim' },

    {
      'https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
      config = function()
        require'toggle_lsp_diagnostics'.init({ all = true, start_on = true })
      end
    }, -- broken as of 2023-02-21 

    { 'https://github.com/akinsho/toggleterm.nvim',
      config = function()
        require('plugins.toggleterm')
      end
    },

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
      -- 'https://github.com/zhimsel/vim-stay'
    }, -- remember cursor position

    {
      'https://github.com/farmergreg/vim-lastplace'
    }, -- remember cursor position

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
    },

    {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'https://github.com/jose-elias-alvarez/null-ls.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'https://github.com/onsails/lspkind.nvim'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
      },
    },

    {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
  },

  config = {
    compile_path = vim.fn.stdpath "data"
      .. "/site/pack/loader/start/packer.nvim/plugin/packer_compiled.lua",
    git = {
      clone_timeout = 300,
    },
  },
}
