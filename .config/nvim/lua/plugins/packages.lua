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

    {'https://github.com/kyazdani42/nvim-web-devicons'},

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

    {'https://github.com/nanotee/nvim-lsp-basics'},

    {
      'https://github.com/folke/trouble.nvim',
      requires = {
        'nvim-web-devicons'
      },
      config = function()
        require('plugins.trouble')
      end,
    },

    -- TreeSitter
    {
      'https://github.com/nvim-treesitter/nvim-treesitter',
      requires = {
        'https://github.com/nvim-treesitter/nvim-treesitter-refactor',
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        'https://github.com/p00f/nvim-ts-rainbow',
        -- 'polarmutex/contextprint.nvim',
        'https://github.com/theHamsta/nvim-treesitter-pairs',
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
    },

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
        {
          'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
          run = 'make'
        },
      },
      config = function()
        require('plugins.telescope')
      end,
    },

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
    },

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
      'https://github.com/norcalli/nvim-colorizer.lua',
      config = function()
        require('plugins.colorizer')
      end,
    },

    {'https://github.com/mg979/vim-visual-multi'},

    {'https://github.com/dstein64/nvim-scrollview'},

    { "https://github.com/AndrewRadev/splitjoin.vim", keys = "gS" },

    {
      'ruifm/gitlinker.nvim',
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
    -- },

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
      },
    },

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
    },

    -- {"github/copilot.vim"},
    {
      "https://github.com/zbirenbaum/copilot-cmp",
      module = "copilot_cmp",
    },

    {
      "https://github.com/zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function ()
        vim.schedule(function() require("copilot").setup() end)
      end,
    },

    -- Easier keymapping
    {
      'https://github.com/LionC/nest.nvim',
      config = function()
        require 'plugins.nest'
      end,
    },

    {
      "https://github.com/folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          window = {
            width = .85 -- width will be 85% of the editor width
          }
        }
      end
    },

    { 'https://github.com/psliwka/vim-smoothie' }, -- Neovide has built-in smoothing

    { 'https://github.com/voldikss/vim-floaterm' },

    -- { 'https://github.com/justinmk/vim-sneak' },

    { 'https://github.com/ggandor/lightspeed.nvim',
      config = function()
        require('plugins.lightspeed')
      end,
    },

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

    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require('neoclip').setup({
          history = 1000,
          enable_persistent_history = true,
          db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
          filter = nil,
          preview = true,
          default_register = '"',
          content_spec_column = false,
          on_paste = {
            set_reg = false,
          },
          keys = {
            telescope = {
              i = {
                select = '<cr>',
                paste = '<c-p>',
                paste_behind = '<c-k>',
                custom = {},
              },
              n = {
                select = '<cr>',
                paste = 'p',
                paste_behind = 'P',
                custom = {},
              },
            },
          },
        })
      end,
      requires = {
        'https://github.com/tami5/sqlite.lua'
      }
    },

    { 'https://github.com/jparise/vim-graphql' },

    { 'https://github.com/jose-elias-alvarez/typescript.nvim' },

    { 'https://github.com/danymat/neogen',
       config = function()
         require('plugins.neogen')
       end,
    }, -- highlights and allows moving between variable references

    { 'https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' },

    { 'https://github.com/JoseConseco/vim-case-change' },

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

    { 'https://github.com/anuvyklack/fold-preview.nvim',
       requires = 'https://github.com/anuvyklack/keymap-amend.nvim',
       config = function()
          require('plugins.fold-preview')
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
      'https://github.com/zhimsel/vim-stay'
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
