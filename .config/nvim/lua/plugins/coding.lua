return {
  {
    'https://github.com/dmmulroy/tsc.nvim',
    config = function()
      require('tsc').setup()
    end
  },

  {
    'https://github.com/monaqa/dial.nvim'
  },

  {
    'https://github.com/gbprod/substitute.nvim'
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  -- copilot
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = { "copilot.lua" },
  --   opts = {},
  --   config = function(_, opts)
  --     local copilot_cmp = require("copilot_cmp")
  --     copilot_cmp.setup(opts)
  --     -- attach cmp source whenever copilot attaches
  --     -- fixes lazy-loading issues with the copilot cmp source
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       callback = function(args)
  --         local buffer = args.buf
  --         local client = vim.lsp.get_client_by_id(args.data.client_id)
  --         on_attach = function(client)
  --           if client.name == "copilot" then
  --             copilot_cmp._on_insert_enter()
  --           end
  --         end
  --       end,
  --     })
  --   end,
  -- },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --   },
  -- },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'marilari88/neotest-vitest',
    },
    keys = {
      {
        "<leader>tp",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "[T]est [P]roject",
      },

      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "[T]est - [A]ttach to current run",
      },

      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "[T]est - Run test with [d]ebugging",
      },

      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "[T]est [F]ile",
      },

      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "[T]est - Show [o]utput",
      },

      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "[T]est - Open [s]ummary window",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "[T]est - [S]top current run",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "[T]est - Run neares[t]",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run_last()
        end,
        desc = "[T]est - re-run las[t]",
      },

      -- `f/F` textobject is taken by `function` in LSP
      {
        "[x",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Jump to previous failed test",
      },

      {
        "]x",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Jump to next failed test",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require('neotest-vitest') },
      })
    end
  },
}
