return {

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      {"<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)"},
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {
        'https://github.com/nvim-telescope/telescope-smart-history.nvim',
        dependencies = {
        {'https://github.com/tami5/sqlite.lua'}}},
        {'https://github.com/nvim-telescope/telescope-frecency.nvim'},
        {"nvim-tree/nvim-web-devicons"},
      },
      cmd = "Telescope",
      version = false, -- telescope did only one release, so use HEAD for now
      keys = {
        {"<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer"},
        {"<leader>/", require('telescope.builtin').live_grep, desc = "Find in Files (Grep)"},
        {"<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History"},
        -- {"<leader><space>", require('telescope.builtin').find_files, desc = "Find Files (root dir)"},
        -- find
        {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers"},
        {"<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent"},
        -- -- git
        {"<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits"},
        {"<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status"},
        -- search
        {"<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands"},
        {"<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer"},
        {"<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History"},
        {"<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands"},
        {"<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics"},
        {"<leader>sg", require('telescope.builtin').live_grep, desc = "Grep (root dir)"},
        -- { "<leader>sG", require('telescope.builtin').live_grep({ cwd = false }), desc = "Grep (cwd)" },
        {"<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages"},
        {"<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups"},
        {"<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps"},
        {"<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages"},
        {"<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark"},
        {"<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options"},
        {"<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume"},
        {"<leader>sw", require('telescope.builtin').grep_string, desc = "Word (root dir)"},
        {"<leader>tw", "<cmd>Telescope tailiscope<cr>", desc = "Search Tailwind docs"},

        -- { "<leader>sW", require('telescope.builtin').grep_string({ cwd = false }), desc = "Word (cwd)" },
        -- {
        --   "<leader>ss",
        --   require('telescope.builtin').lsp_document_symbols({
        --     symbols = {
        --       "Class",
        --       "Function",
        --       "Method",
        --       "Constructor",
        --       "Interface",
        --       "Module",
        --       "Struct",
        --       "Trait",
        --       "Field",
        --       "Property",
        --     },
        --   }),
        --   desc = "Goto Symbol",
        -- },
        -- {
        --   "<leader>sS",
        --   require('telescope.builtin').lsp_workspace_symbols({
        --     symbols = {
        --       "Class",
        --       "Function",
        --       "Method",
        --       "Constructor",
        --       "Interface",
        --       "Module",
        --       "Struct",
        --       "Trait",
        --       "Field",
        --       "Property",
        --     },
        --   }),
        --   desc = "Goto Symbol (Workspace)",
        -- },
      },
      opts = {
        defaults = {
          pickers = {
            oldfiles = {
              cwd_only = true,
            }
          },
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
              ["<a-t>"] = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
              end,
              ["<C-n>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-p>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-j>"] = function(...)
                return require("telescope.actions").move_selection_next(...)
              end,
              ["<C-k>"] = function(...)
                return require("telescope.actions").move_selection_previous(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
      },
    },

    -- easily jump to any location and enhanced f/t motions for Leap
    {
      "ggandor/flit.nvim",
      keys = function()
        ---@type LazyKeys[]
        local ret = {}
        for _, key in ipairs({"f", "F", "t", "T"}) do
          ret[#ret + 1] = {key, mode = {"n", "x", "o"}, desc = key}
        end
        return ret
      end,
      opts = {labeled_modes = "nx"},
    },

    {
      "ggandor/leap.nvim",
      keys = {
        {"s", mode = {"n", "x", "o"}, desc = "Leap forward to"},
        {"S", mode = {"n", "x", "o"}, desc = "Leap backward to"},
        {"gs", mode = {"n", "x", "o"}, desc = "Leap from windows"},
      },
      config = function(_, opts)
        local leap = require("leap")
        for k, v in pairs(opts) do
          leap.opts[k] = v
        end
        leap.add_default_mappings(true)
        vim.keymap.del({"x", "o"}, "x")
        vim.keymap.del({"x", "o"}, "X")
      end,
    },

    -- git signs
    {
      "lewis6991/gitsigns.nvim",
      event = {"BufReadPre", "BufNewFile"},
      opts = {
        signs = {
          add = {text = "▎"},
          change = {text = "▎"},
          delete = {text = ""},
          topdelete = {text = ""},
          changedelete = {text = "▎"},
          untracked = {text = "▎"},
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, {buffer = buffer, desc = desc})
          end

          -- stylua: ignore start
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({"n", "v"}, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({"n", "v"}, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghb", function() gs.blame_line({full = true}) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      },
    },

    -- references
    {
      "RRethy/vim-illuminate",
      event = {"BufReadPost", "BufNewFile"},
      opts = {delay = 200},
      config = function(_, opts)
        require("illuminate").configure(opts)

        local function map(key, dir, buffer)
          vim.keymap.set("n", key, function()
            require("illuminate")["goto_" .. dir .. "_reference"](false)
          end, {desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer})
        end

        map("]]", "next")
        map("[[", "prev")

        -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            local buffer = vim.api.nvim_get_current_buf()
            map("]]", "next", buffer)
            map("[[", "prev", buffer)
          end,
        })
      end,
      keys = {
        {"]]", desc = "Next Reference"},
        {"[[", desc = "Prev Reference"},
      },
    },

    -- buffer remove
    {
      "echasnovski/mini.bufremove",
      -- stylua: ignore
      keys = {
        {"<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer"},
        {"<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)"},
      },
    },

    -- better diagnostics list and others
    {
      "folke/trouble.nvim",
      cmd = {"TroubleToggle", "Trouble"},
      opts = {use_diagnostic_signs = true},
      keys = {
        {"<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)"},
        {"<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)"},
        {"<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)"},
        {"<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)"},
        {
          "[q",
          function()
            if require("trouble").is_open() then
              require("trouble").previous({skip_groups = true, jump = true})
            else
              vim.cmd.cprev()
            end
          end,
          desc = "Previous trouble/quickfix item",
        },
        {
          "]q",
          function()
            if require("trouble").is_open() then
              require("trouble").next({skip_groups = true, jump = true})
            else
              vim.cmd.cnext()
            end
          end,
          desc = "Next trouble/quickfix item",
        },
      },
    },

    -- todo comments
    {
      "folke/todo-comments.nvim",
      cmd = {"TodoTrouble", "TodoTelescope"},
      event = {"BufReadPost", "BufNewFile"},
      config = true,
      -- stylua: ignore
      keys = {
        {"]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment"},
        {"[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment"},
        {"<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)"},
        {"<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)"},
        {"<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo"},
      },
    },

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
      dependencies = {
        'https://github.com/tami5/sqlite.lua',
      }
    },

    {
      "jcdickinson/codeium.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "hrsh7th/nvim-cmp",
      },
      config = function()
        require("codeium").setup({})
      end
    },

    {"tpope/vim-abolish"},

    { 
      'junegunn/fzf.vim',
      dependencies = {'junegunn/fzf'},
      config = function()
        vim.cmd [[ command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --hidden --smart-case --no-heading --color=always -g "!.git" -g "!src/lib/types" ' .shellescape(<q-args>), 1, <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%') : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e --black --border --bind ctrl-j:preview-down,ctrl-k:preview-up,ctrl-u:preview-page-up,ctrl-d:preview-page-down,tab:toggle+down,shift-tab:toggle+up'}, 'right:50%', '?'), <bang>0) ]]
      end
    },

    {
      'junegunn/fzf',
      config = function()
      end
    },

    {
      'https://github.com/DanielVolchek/tailiscope.nvim',
      config = function()
        require('telescope').load_extension('tailiscope')
      end
    },

    {
      "chrisgrieser/nvim-recorder",
      opts = {},
      config = function()
        require('recorder').setup({
          	mapping = {
          		startStopRecording = "q",
          		playMacro = "<c-q>",
          		switchSlot = "<leader>q",
          		editMacro = "cq",
          		yankMacro = "yq", -- also decodes it for turning macros to mappings
          		addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
          	},
        })
      end
    },
}
