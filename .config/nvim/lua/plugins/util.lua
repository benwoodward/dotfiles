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
}
