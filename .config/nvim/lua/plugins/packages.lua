-- vim: ts=2 sw=2 et:

return require('packer').startup(
  function()
    use {'wbthomason/packer.nvim'}

    use {
      disable = true,
      'gruvbox-community/gruvbox',
      config = function()
        vim.o.background            = "dark"
        vim.g.gruvbox_italics       = true
        vim.g.gruvbox_contrast_dark = "hard"
        vim.cmd [[colorscheme gruvbox]]
      end,
    }

    use {
      disable = true,
      'drewtempelmeyer/palenight.vim',
      config = function()
        vim.cmd [[colorscheme palenight]]
      end,
    }

    use {
      disable = true,
      'marko-cerovac/material.nvim',
      config = function()
        vim.g.material_style            = 'palenight'
        vim.g.material_italic_comments  = true
        vim.g.material_italic_keywords  = false
        vim.g.material_italic_functions = false
        vim.g.material_italic_variables = false
        vim.g.material_contrast         = true
        vim.g.material_borders          = true
        -- Load the colorscheme
        require('material').set()
      end,
    }

    use {
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
    }

    use {'kyazdani42/nvim-web-devicons'}

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.config.lsp')
      end,
      requires = {
        'jose-elias-alvarez/null-ls.nvim'
      },
    }

    use {'nanotee/nvim-lsp-basics'}

    use {
      'folke/trouble.nvim',
      requires = {
        'nvim-web-devicons'
      },
      config = function()
        require('plugins.config.trouble')
      end,
    }

    -- TreeSitter
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'p00f/nvim-ts-rainbow',
        -- 'polarmutex/contextprint.nvim',
        'theHamsta/nvim-treesitter-pairs',
        'nvim-treesitter/playground'
      },
      run = ':TSUpdate',
      config = function()
        require('plugins.config.treesitter')
      end,
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('plugins.config.gitsigns')
      end,
    }

    use {
      'sindrets/diffview.nvim',
      requires = {'nvim-web-devicons'},
      config = function()
        require('plugins.config.diffview')
      end,
    }

    use {'euclidianAce/BetterLua.vim'}

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-project.nvim',
      },
      config = function()
        require('plugins.config.telescope')
      end,
    }

    use {
      'terrortylor/nvim-comment',
      config = function()
        require('plugins.config.comment')
      end,
    }

    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('plugins.config.colorizer')
      end,
    }

    use {'mg979/vim-visual-multi'}

    use {'dstein64/nvim-scrollview'}

    -- Teal language support
    use {'teal-language/vim-teal'}

    use { "AndrewRadev/splitjoin.vim", keys = "gS" }

    use {
      'folke/which-key.nvim',
      config = function()
        require('plugins.config.which-key')
      end,
    }

    use {
      'ruifm/gitlinker.nvim',
      key = "gy",
      config = function()
        require('gitlinker').setup {
          mappings = "gy",
        }
      end,
    }

    use {
      'L3MON4D3/LuaSnip',
      config = function()
        require 'plugins.config.luasnip'
      end,
    }

    use {
      'hrsh7th/nvim-cmp',
      config = function()
        require 'plugins.config.cmp'
      end,
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
      },
    }

    use { 'saadparwaiz1/cmp_luasnip' }

  end
)
