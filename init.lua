-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.wo.conceallevel = 2
vim.wo.relativenumber = true

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  desc = "prevent colorscheme clearing self-defined DAP marker colors",
  callback = function()
      local sign_column_hl = vim.api.nvim_get_hl(0, { name = 'SignColumn' })
      local sign_column_bg =  (sign_column_hl.bg ~= nil) and ('#%06x'):format(sign_column_hl.bg) or 'bg'
      local sign_column_ctermbg = (sign_column_hl.ctermbg ~= nil) and sign_column_hl.ctermbg or 'Black'

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#c23127', bg = sign_column_bg, ctermbg = sign_column_ctermbg })
  end
})

-- DAP Breakpoint signs
-- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "➡", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })


