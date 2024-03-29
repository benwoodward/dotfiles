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

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'onsails/lspkind.nvim' },
      { "jose-elias-alvarez/null-ls.nvim" },
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-cmdline' },  -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' },   -- Optional
      { 'hrsh7th/cmp-path' },     -- Optional
      -- { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional

      -- Snippets
      -- { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
      -- {'https://github.com/aca/emmet-ls'}, -- Optional
    },
    config = function()
      local null_ls = require('null-ls')
      local lsp = require('lsp-zero')
      local cmp = require("cmp")
      -- local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local lsp_format_on_save = function(bufnr)
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ timeout_ms = 2000 })
            filter = function(client)
              return client.name == "null-ls"
            end
          end,
        })
      end

      null_ls.setup({
        debug = false,
        sources = { null_ls.builtins.formatting.prettierd },
        on_attach = format_on_save
      })

      lsp.preset('recommended')

      lsp.on_attach(function(client, bufnr)
        -- lsp.default_keymaps({
        --   buffer = bufnr,
        --   -- preserve_mappings = false,
        --   omit = { 'gl' },
        -- })
        lsp_format_on_save(bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        local map = function(mode, lhs, rhs)
          local opts = { remap = false, buffer = bufnr }
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- LSP actions
        --
        -- map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>') -- using lspsage instead
        --
        -- Hover Doc
        -- If there is no hover doc,
        -- there will be a notification stating that
        -- there is no information available.
        -- To disable it just use ":Lspsaga hover_doc ++quiet"
        -- Pressing the key twice will enter the hover window

        map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
        map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        map('n', '<leader>br', '<cmd>lua vim.lsp.buf.rename()<cr>')
        map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        map('x', '<leader>rca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

        -- Diagnostics
        -- map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>') -- using lspsaga instead
        map('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>')
        -- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        -- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      end)

      local root_pattern = require('lspconfig.util').root_pattern

      lsp.configure('tailwindcss', {
        root_dir = root_pattern(
          'tailwind.config.js',
          'tailwind.config.cjs',
          'tailwind.config.ts'
        )
      })

      lsp.configure('svelte', {
        settings = {
          svelte = {
            plugin = {
              svelte = {
                defaultScriptLanguage = 'ts',
                compilerWarnings = {
                  -- ["css-unused-selector"] = 'ignore',d
                  -- ["a11y-missing-attribute"] = 'ignore',
                  -- ["a11y-missing-content "] = 'ignore',
                  -- ["unused-export-let"] = 'ignore',
                }
              },
              css = {
                completions = {
                  emmet = false,
                },
              },
            }
          },
          emmet = {
            showExpandedAbbreviation = 'never'
          }
        },
      })

      lsp.setup_nvim_cmp({
        preselect = 'item',
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
          completeopt = 'menu,menuone,noinsert',
          keyword_length = 0,
        },
        -- snippet = {
        --   expand = function(args)
        --     luasnip.lsp_expand(args.body)
        --   end,
        -- },
        formatting = {
          format = require('lspkind').cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = {
              Codeium = "",
              Copilot = "",
            },
          })
        },
        formatters = {
          label = require("copilot_cmp.format").format_label_text,
          -- insert_text = require("copilot_cmp.format").format_insert_text,
          insert_text = require("copilot_cmp.format").remove_existing, -- experimental to remove exraneous chars
          preview = require("copilot_cmp.format").deindent,
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-j>"] = cmp.mapping({
            i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          }),
          ["<c-k>"] = cmp.mapping({
            i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          }),
          ["<c-e>"] = cmp.mapping({
            i = cmp.mapping.scroll_docs(2),
          }),
          ["<c-y>"] = cmp.mapping({
            i = cmp.mapping.scroll_docs(-2),
          }),
          ["<c-l>"] = cmp.mapping({
            i = cmp.mapping.confirm({ select = false }),
          }),
          ["<s-cr>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          }),
        }),
        sources = {
          { name = 'copilot' },
          -- { name = 'cmp_tabnine' },
          -- {name = "luasnip"},
          {
            name = "buffer",
            option = {
              -- complete from visible buffers
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          { name = "path" },
          { name = "nvim_lsp", trigger_characters = { '-', ':', '/', } },
          -- {name = 'emmet-ls'},
        },
        experimental = {
          view = {
            -- entries = true,
            entries = { name = 'custom', selection_order = 'near_cursor' }
          },
          ghost_text = true,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            function(entry1, entry2)
              if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
              if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
            end,
            require("copilot_cmp.comparators").prioritize,
            require("copilot_cmp.comparators").score,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        performance = {
          trigger_debounce_time = 500,
          throttle = 550,
          fetching_timeout = 80,
        },
      })

      lsp.setup()
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(), -- important!
        sources = {
          { name = 'nvim_lua' },
          { name = 'cmdline' },
        },
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(), -- important!
        sources = {
          { name = 'buffer' },
        },
      })
    end
  },

  -- snippets
  -- {
  --   "L3MON4D3/LuaSnip",
  --   build = (not jit.os:find("Windows"))
  --       and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
  --     or nil,
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     config = function()
  --       require("luasnip.loaders.from_vscode").lazy_load()
  --     end,
  --   },
  --   opts = {
  --     history = true,
  --     delete_check_events = "TextChanged",
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     {
  --       "<tab>",
  --       function()
  --         return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
  --       end,
  --       expr = true, silent = true, mode = "i",
  --     },
  --     { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
  --     { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  --   },
  -- },

  -- auto pairs
  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   config = function(_, opts)
  --     require("mini.pairs").setup(opts)
  --   end,
  -- },

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
  -- {
  --   "echasnovski/mini.surround",
  --   keys = function(_, keys)
  --     -- Populate the keys based on the user's options
  --     local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
  --     local opts = require("lazy.core.plugin").values(plugin, "opts", false)
  --     local mappings = {
  --       { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
  --       { opts.mappings.delete,         desc = "Delete surrounding" },
  --       { opts.mappings.find,           desc = "Find right surrounding" },
  --       { opts.mappings.find_left,      desc = "Find left surrounding" },
  --       { opts.mappings.highlight,      desc = "Highlight surrounding" },
  --       { opts.mappings.replace,        desc = "Replace surrounding" },
  --       { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
  --     }
  --     mappings = vim.tbl_filter(function(m)
  --       return m[1] and #m[1] > 0
  --     end, mappings)
  --     return vim.list_extend(mappings, keys)
  --   end,
  --   opts = {
  --     mappings = {
  --       add = "ca",            -- Add surrounding in Normal and Visual modes
  --       delete = "cd",         -- Delete surrounding
  --       find = "cf",           -- Find surrounding (to the right)
  --       find_left = "cF",      -- Find surrounding (to the left)
  --       highlight = "ch",      -- Highlight surrounding
  --       replace = "cr",        -- Replace surrounding
  --       update_n_lines = "cn", -- Update `n_lines`
  --     },
  --   },
  --   config = function(_, opts)
  --     -- use gz mappings instead of s to prevent conflict with leap
  --     require("mini.surround").setup(opts)
  --   end,
  -- },

  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          on_attach = function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter()
            end
          end
        end,
      })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    }
  },

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
