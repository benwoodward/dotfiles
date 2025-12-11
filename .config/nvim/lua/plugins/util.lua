return {

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    'https://github.com/farmergreg/vim-lastplace'
  }, -- remember cursor position

  {
    'vladdoster/remember.nvim',
    config = function()
      require('remember')
    end
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  { "wakatime/vim-wakatime" },

  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true
  },
  -- `GistsList` opens the selected gist in a terminal buffer,
  -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
  -- and prevents neovim buffer inception
  {
    "samjwill/nvim-unception",
    lazy = false,
    init = function() vim.g.unception_block_while_host_edits = true end
  },
}
