local null_ls = require("null-ls")
local utils = require("null-ls.utils")
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
  b.diagnostics.write_good,
  b.diagnostics.markdownlint,
  b.diagnostics.shellcheck.with({
    diagnostics_format = diagnostics_code_template,
  }),
  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,
  -- hover
  b.hover.dictionary,
}

local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "textDocument/formatting",
    {textDocument = {uri = vim.uri_from_bufnr(bufnr)}},
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("silent noautocmd update")
        end)
      end
    end
  )
end

-- utils
local folder_has_file = function(folder,...)
  local patterns = vim.tbl_flatten({ ... })
  for _, name in ipairs(patterns) do
    if utils.path.exists(utils.path.join(folder, name)) then
      return true
    end
  end
  return false
end

local function prettierIsConfigured(root)
  return folder_has_file(root,
    {
    ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.json5",
    ".prettierrc.js", ".prettierrc.cjs", "prettier.config.js", "prettier.config.cjs",
    ".prettierrc.toml"
    }
  )
end

local function eslintIsConfigured(root)
  return folder_has_file(root, ".eslintrc")
end

function _G.null_ls_autoToggleServices()
  local status = vim.b.bufferLspInfo
  if not status then return end

  if  status.hasEslint then
    null_ls.enable({ name = "eslint_d", method = null_ls.methods.DIAGNOSTICS })
  else
    null_ls.disable({ name = "eslint_d", method = null_ls.methods.DIAGNOSTICS })
  end

  if status.hasPrettier then
    null_ls.enable("prettier")
    null_ls.disable({ name = "eslint_d", method = null_ls.methods.FORMATTING })
  elseif status.hasEslint then
    null_ls.disable("prettier")
    null_ls.enable({ name = "eslint_d", method = null_ls.methods.FORMATTING })
  else
    null_ls.disable("prettier")
    null_ls.disable({ name = "eslint_d", method = null_ls.methods.FORMATTING })
  end
end


-- global function for vim autocommand
function _G.null_ls_CalculateBufferLspInfo()
  local root = utils.root_pattern(".null-ls-root", "Makefile", ".git")(vim.fn.expand('%:p'))
  if not root then return false end
  return {
    hasPrettier = prettierIsConfigured(root),
    hasEslint = eslintIsConfigured(root)
  }
end


-- register autocommand to update info when buffer opened
vim.api.nvim_command('autocmd BufReadPre,FileReadPre * lua vim.b.bufferLspInfo = null_ls_CalculateBufferLspInfo()')
-- register autocommand to toggle services on buffer enter
vim.api.nvim_command('autocmd BufEnter * lua null_ls_autoToggleServices()')

local M = {}
M.setup = function(on_attach)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  -- On neovim v0.8+, when calling vim.lsp.buf.format as done in the examples above, you may want to filter the available formatters so that only null-ls formatters are applied,
  -- Otherwise, when calling vim.lsp.buf.format, other formatters from other clients attached to the buffer may attempt to perform a format.
  -- local callback = function()
  --   vim.lsp.buf.format({
  --     bufnr = bufnr,
  --     filter = function(clients)
  --       return vim.tbl_filter(
  --         function(client) return client.name == "null-ls" end,
  --         clients
  --       )
  --     end
  --   })
  -- end,

  null_ls.setup({
    -- debug = true,
    sources = sources,
    on_attach = function(client, bufnr)
      null_ls_autoToggleServices()

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePost", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            async_formatting(bufnr)
          end,
        })
      end
    end,
  })
end

return M
