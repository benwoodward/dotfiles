-- TODO: https://github.com/kevinhwang91/nvim-ufo/issues/4
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldcolumn = '5'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- TODO: move these to nest.lua
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.lsp.buf.hover()
    end
end)

-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end,
  preview = {
    win_config = {
      winblend = 0,
      winhighlight = 'NormalFloat:FoldPreview,FloatBorder:FoldPreviewBorder'
    },
    mappings = {
        scrollU = '<C-u>',
        scrollD = '<C-d>'
    },
  }
})
