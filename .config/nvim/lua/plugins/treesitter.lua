return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {"p00f/nvim-ts-rainbow"},
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'go', 'lua', 'python', 'tsx', 'typescript', 'svelte', 'help', 'vim' },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,

        highlight = { enable = true },
        indent = { enable = true, disable = { 'python' } },
      }
    end,
  },

  { 
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require('mini.ai').setup()
    end
  },
}
