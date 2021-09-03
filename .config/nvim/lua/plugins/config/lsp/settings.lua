-- vim: ts=2 sw=2 et:

local api       = vim.api
local lspconfig = require('lspconfig')
local util      = require('lspconfig.util')

require('plugins.config.lsp.diagnostic')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
  true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local custom_attach = function(client, bufnr)
  local basics = require('lsp_basics')
  basics.make_lsp_commands(client, bufnr)
  basics.make_lsp_mappings(client, bufnr)

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup CodeLens
      au!
      au InsertEnter,InsertLeave * lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end
end

local custom_attach_svelte = function(client, bufnr)
  local basics = require('lsp_basics')
  basics.make_lsp_commands(client, bufnr)
  basics.make_lsp_mappings(client, bufnr)

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup CodeLens
      au!
      au InsertEnter,InsertLeave * lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end

  vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")

  -- client.server_capabilities.completionProvider.triggerCharacters = {
  --   ".", "\"", "'", "`", "/", "@", "*",
  --   "#", "$", "+", "^", "(", "[", "-", ":",
  -- }
end

local servers = {
  tailwindcss = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb"
      },
    },
    on_new_config = function(new_config)
          if not new_config.settings then
            new_config.settings = {}
          end
          if not new_config.settings.editor then
            new_config.settings.editor = {}
          end
          if not new_config.settings.editor.tabSize then
            -- set tab size for hover
            new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
          end
        end,
    root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts', 'package.json', 'node_modules', '.git'),
    settings = {
      tailwindCSS = {
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning"
        },
        validate = true
      },
    },
  },
  tsserver = {
    on_attach = custom_attach,
    init_options = { documentFormatting = false },
    filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'},
    root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')
  },
  ["null-ls"] = {
    on_attach = custom_attach_svelte,
    filetypes = { 'svelte', 'html' },
    root_dir = util.root_pattern('package.json', '.git'),
    handlers = {
      ["textDocument/publishDiagnostics"] = is_using_eslint,
    },
    settings = {
      svelte = {
        plugin = {
          html   = { completions = { enable = true, emmet = false } },
          svelte = { completions = { enable = true, emmet = false } },
          css    = { completions = { enable = true, emmet = true  } },
        },
      },
    },
  },
}

require('plugins.config.null-ls').setup()
require'lspconfig'.tailwindcss.setup{}

for server, config in pairs(servers) do
  local client = lspconfig[server]

  client.setup(vim.tbl_extend("force", {
    flags = { debounce_text_changes = 150 },
    capabilities = capabilities,
  }, config))
end

