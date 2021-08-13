local wk = require "which-key"

-- TODO: Configure this

wk.register({
  f = {
    name = "+Telescope",
    f = "Frecency",
    b = "Buffer Fuzzy",
    g = "Git Commits",
    t = "Builtins",
    l = {
      name = "+LSP",
      s = "Workspace Symbols",
    },
    m = {
      name = "+NPM",
      s = "Scripts",
      p = "Packages",
    }
  },
  g = {
    name = "+LSP",
    f = "Formatting",
    a = "Code Action",
    d = "Symbol Definition(s)",
    r = "Symbol Reference(s)",
    R = "Rename Symbol",
    D = "Show Line Diagnostic",
    l = "Run codelense",
    ["]"] = "Next Diagnostic",
    ["["] = "Prev Diagnostic",
  },
  h = {
    name = "+GitSigns",
    b = "Blame Line",
    R = "Reset Buffer",
    p = "Preview Hunk",
    r = "Reset Hunk",
    s = "Stage Hunk",
    u = "Undo Hunk",
  },
  i = "Start Incremental Selection",
  v = "Open Scratch Split",
  n = "Disable Matching Highlight",
  a = "Swap With Next Parameter",
  A = "Swap With Prev Parameter",
  w = "Hop To Arbitrary Word",
}, {
  prefix = "<leader>",
})

wk.register {
  gc = "Comments",
  gy = "Copy Github Link",
  gJ = "Join Multiline",
  gS = "Split Into Multiline",
}

wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = false },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      z = true,
      g = true,
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»",
    separator = "➜ ",
    group = "+",
  },
  window = {
    border = "none",
    position = "bottom",
    margin = { 0, 0, 0, 0 }, -- TRBL
    padding = { 4, 2, 4, 2 }, -- TRBL
  },
  layout = {
    -- min and max height of the columns
    height = {
      min = 4,
      max = 25,
    },
    -- min and max width of the columns
    width = {
      min = 20,
      max = 50,
    },
    -- spacing between columns
    spacing = 8,
  },
  -- enable this to hide mappings for which you didn't specify a label
  ignore_missing = false,
  -- hide mapping boilerplate
  hidden = {
    "<silent>",
    "<cmd>",
    "<Cmd>",
    "<CR>",
    "call",
    "lua",
    "^:",
    "^ ",
  },
  -- show help message on the command line when the popup is visible
  show_help = true,
  triggers = "auto", -- automatically setup triggers
  triggers_blacklist = {
    i = { "," },
  },
}
