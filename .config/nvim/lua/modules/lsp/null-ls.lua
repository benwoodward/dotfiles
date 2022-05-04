local null_ls = require("null-ls")
local b = null_ls.builtins

local diagnostics_code_template = "#{m} [#{c}]"

local with_root_file = function(...)
  local files = {...}
  return function(utils)
    return utils.root_has_file(files)
  end
end

local sources = {
  -- formatting
  b.formatting.prettier,

  -- diagnostics
  b.diagnostics.eslint, -- eslint or eslint_d
  b.diagnostics.write_good,
  b.diagnostics.markdownlint,
  b.diagnostics.shellcheck.with({
    diagnostics_format = diagnostics_code_template,
  }),
  -- code actions
  b.code_actions.eslint, 
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,
  -- hover
  b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
  null_ls.setup({
    -- debug = true,
    sources = sources,
    on_attach = on_attach,
  })
end

return M
