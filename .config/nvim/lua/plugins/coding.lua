return {

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      {'onsails/lspkind.nvim'},
      {"jose-elias-alvarez/null-ls.nvim"},
      {'neovim/nvim-lspconfig'}, -- Required
      {'williamboman/mason.nvim'}, -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'}, -- Required
      {'hrsh7th/cmp-cmdline'}, -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'hrsh7th/cmp-buffer'}, -- Optional
      {'hrsh7th/cmp-path'}, -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'}, -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'}, -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    },
    config = function()
      local null_ls = require('null-ls')
      local lsp = require('lsp-zero')
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      lsp.configure("tsserver", {
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentFormattingRangeProvider = false
        end
      })

      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local lsp_format_on_save = function(bufnr)
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
            filter = function(client)
              return client.name == "null-ls"
            end
          end,
        })
      end

      null_ls.setup({
        debug = false,
        sources = {null_ls.builtins.formatting.prettier},
        on_attach = format_on_save
      })

      lsp.preset('recommended')

      lsp.on_attach(function(client, bufnr)
        lsp_format_on_save(bufnr)
      end)

      lsp.ensure_installed({
        'tsserver',
        'eslint',
        'svelte',
        'html',
        'cssls',
        'emmet_ls',
      })

      lsp.setup_nvim_cmp({
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
          completeopt = "menuone,noinsert,noselect",
          -- keyword_length = 0,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          format = require('lspkind').cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = {
              Codeium = "",
              Copilot = "",
            },
          })},
          formatters = {
            label = require("copilot_cmp.format").format_label_text,
            -- insert_text = require("copilot_cmp.format").format_insert_text,
            insert_text = require("copilot_cmp.format").remove_existing, -- experimental to remove exraneous chars
            preview = require("copilot_cmp.format").deindent,
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping(function(fallback)
              -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
              if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                  cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                else
                  cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
                end
              else
                fallback()
              end
            end, {"i", "s", "c", }),
            ["<C-j>"] = cmp.mapping({
              i = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
            }),
            ["<s-tab>"] = cmp.mapping({
              i = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
            }),
            ["<C-k>"] = cmp.mapping({
              i = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
            }),
            ["<C-e>"] = cmp.mapping({
              i = cmp.mapping.abort(),
            }),
            ["<c-l>"] = cmp.mapping({
              i = cmp.mapping.confirm({select = false}),
            }),
            ["<cr>"] = cmp.mapping({
              i = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}),
            }),
          }),
          sources = {
            {name = "copilot"},
            {name = "codeium"},
            -- { name = 'cmp_tabnine' },
            {name = "luasnip"},
            -- { name = "nvim_lsp" },
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
            {name = "path"},
          },
          experimental = {
            view = {
              -- entries = true,
            entries = {name = 'custom', selection_order = 'near_cursor'}},
            ghost_text = true,
          },
          sorting = {
            priority_weight = 2,
            comparators = {
              require("copilot_cmp.comparators").prioritize,

              -- Below is the default comparitor list and order for nvim-cmp
              cmp.config.compare.offset,
              -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
              cmp.config.compare.exact,
              cmp.config.compare.score,
              cmp.config.compare.recently_used,
              cmp.config.compare.locality,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
        })

        lsp.setup()
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(), -- important!
          sources = {
            {name = 'nvim_lua'},
            {name = 'cmdline'},
          },
        })
        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(), -- important!
          sources = {
            {name = 'buffer'},
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
      "echasnovski/mini.surround",
      keys = function(_, keys)
        -- Populate the keys based on the user's options
        local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
        local opts = require("lazy.core.plugin").values(plugin, "opts", false)
        local mappings = {
          {opts.mappings.add, desc = "Add surrounding", mode = {"n", "v"}},
          {opts.mappings.delete, desc = "Delete surrounding"},
          {opts.mappings.find, desc = "Find right surrounding"},
          {opts.mappings.find_left, desc = "Find left surrounding"},
          {opts.mappings.highlight, desc = "Highlight surrounding"},
          {opts.mappings.replace, desc = "Replace surrounding"},
          {opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`"},
        }
        mappings = vim.tbl_filter(function(m)
          return m[1] and #m[1] > 0
        end, mappings)
        return vim.list_extend(mappings, keys)
      end,
      opts = {
        mappings = {
          add = "gza", -- Add surrounding in Normal and Visual modes
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      },
      config = function(_, opts)
        -- use gz mappings instead of s to prevent conflict with leap
        require("mini.surround").setup(opts)
      end,
    },

    -- comments
    {"JoosepAlviste/nvim-ts-context-commentstring", lazy = true},
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
      dependencies = {"copilot.lua"},
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
        suggestion = {enabled = false},
        panel = {enabled = false},
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
        "nvim-telescope/telescope.nvim"
      }},

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
              require("neotest").run.run({suite = true})
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
              require("neotest").run.run({strategy = "dap"})
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
              require("neotest").output.open({enter = true})
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
              require("neotest").jump.prev({status = "failed"})
            end,
            desc = "Jump to previous failed test",
          },

          {
            "]x",
            function()
              require("neotest").jump.next({status = "failed"})
            end,
            desc = "Jump to next failed test",
          },
        },
        config = function()
          require("neotest").setup({
            adapters = {
              require('neotest-vitest')
            },
          })
        end
      },
    }
