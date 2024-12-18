require("nvchad.options")

local wo = vim.wo
local o = vim.o

wo.conceallevel = 2
wo.relativenumber = true
o.cursorlineopt = "both"
o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "gitcommit",
	command = "setlocal spell spelllang=en_us",
})
