local u = require("modules.util")

require("neogen").setup({
  enabled = true,
  languages = {
    lua = {
      template = {
        annotation_convention = "emmylua",
      },
    },
  },
})

u.nmap("<Leader>ng", ":lua require'neogen'.generate()<CR>")
