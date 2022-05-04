-- vim: ts=2 sw=2 et:

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end
local u = require("modules.util")

return packer.startup {
  {
    {
      'wbthomason/packer.nvim',
      opt = true,
    },

    {
      -- disable = true,
      'folke/tokyonight.nvim',
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

    {'kyazdani42/nvim-web-devicons'},

    -- LSP
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('modules.lsp')
      end,
      requires = {
        'jose-elias-alvarez/null-ls.nvim',
        'jose-elias-alvarez/nvim-lsp-ts-utils'
      },
    },

    {'nanotee/nvim-lsp-basics'},

    {
      'folke/trouble.nvim',
      requires = {
        'nvim-web-devicons'
      },
      config = function()
        require('plugins.trouble')
      end,
    },

    -- TreeSitter
    {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'p00f/nvim-ts-rainbow',
        -- 'polarmutex/contextprint.nvim',
        'theHamsta/nvim-treesitter-pairs',
        'nvim-treesitter/playground',
      },
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
    },

    -- Git
    {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('plugins.gitsigns')
      end,
    },

    {
      'sindrets/diffview.nvim',
      requires = {'nvim-web-devicons'},
      config = function()
        require('plugins.diffview')
      end,
    },

    {'euclidianAce/BetterLua.vim'},

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'https://github.com/nvim-lua/popup.nvim',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-telescope/telescope-project.nvim',
        {
          'https://github.com/nvim-telescope/telescope-smart-history.nvim',
          requires = {
            'tami5/sqlite.lua'
          }
        },
        'nvim-telescope/telescope-frecency.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
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
      'numToStr/Comment.nvim',
      requires = {
        'JoosepAlviste/nvim-ts-context-commentstring'
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
          pre_hook = function(ctx)
            local U = require 'Comment.utils'

            local location = nil
            if ctx.ctype == U.ctype.block then
              location =
                require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location =
                require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return
            require('ts_context_commentstring.internal').calculate_commentstring {
              key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
              location = location
            }
          end,
        }
      end,
    },

    {
      'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
          require'nvim-treesitter.configs'.setup {
            context_commentstring = {enable = true, enable_autocmd = false}
          }
        end
    },

    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('plugins.colorizer')
      end,
    },

    {'mg979/vim-visual-multi'},

    {'dstein64/nvim-scrollview'},

    -- Teal language support
    {'teal-language/vim-teal'},

    { "AndrewRadev/splitjoin.vim", keys = "gS" },

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
      "hrsh7th/nvim-cmp",
      config = function()
        require "plugins.cmp"
      end,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
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

    -- Easier keymapping
    {
      'LionC/nest.nvim',
      config = function()
        require 'plugins.nest'
      end,
    },

    {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          window = {
            width = .85 -- width will be 85% of the editor width
          }
        }
      end
    },

    { 'https://github.com/psliwka/vim-smoothie' },

    { 'https://github.com/voldikss/vim-floaterm' },

    -- { 'https://github.com/justinmk/vim-sneak' },

    { 'https://github.com/ggandor/lightspeed.nvim' },

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
        'tami5/sqlite.lua'
      }
    },

    { 'https://github.com/jparise/vim-graphql' },

    { 'https://github.com/jose-elias-alvarez/typescript.nvim' },

    { 'https://github.com/danymat/neogen',
       config = function()
         require('plugins.neogen')
       end,
    }, -- highlights and allows moving between variable references
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
