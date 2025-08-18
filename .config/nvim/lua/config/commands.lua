local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, #end_line },
      }
    end
    require("conform").format({
      async = true,
      lsp_format = "fallback",
      range = range,
    })
  end, {
    range = true,
    desc = "Format buffer or visual range using conform.nvim",
  })
end

return M
