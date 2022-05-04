local u = require("modules.util")

local luasnip = require("luasnip")

luasnip.filetype_extend("svelte", {"typescript"})

u.imap("<C-e>", function()
  if luasnip.choice_active() then
    luasnip.change_choice()
  else
    u.input("<C-e>", "n")
  end
end)

u.imap("<C-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif require("neogen").jumpable() then
    u.input("<cmd>lua require'neogen'.jump_next()<CR>")
  end
end)

u.imap("<C-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  elseif require("neogen").jumpable() then
    u.input("<cmd>lua require'neogen'.jump_prev()<CR>")
  end
end)

require("config.snippets").load()
