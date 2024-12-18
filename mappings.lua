require("nvchad.mappings")

local map = vim.keymap.set
local nomap = vim.keymap.del

nomap("n","<leader>th")

-- Global mappings
map("n", "gR", function()
	require("trouble").toggle("lsp_references")
end, { desc = "Open LSP references" })

map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Telescope
map("n", "<leader>P", function()
	require("telescope").extensions.project.project({})
end, { desc = "Projects" })

map("n", "<leader>fg", function()
	require("telescope").extensions.live_grep_args.live_grep_args({})
end, { desc = "Grep (args)" })

map("n", "<leader>fr", function()
	require("telescope.builtin").resume({})
end, { desc = "Resume last telescope" })

map("n", "<leader>ft", function()
	require("nvchad.themes").open()
end, { desc = "List nvchad themes" })

map("n", "<leader>N", function()
	require("telescope").extensions.notify.notify()
end, { desc = "See notification" })

-- Copy/Paste to registry "
map({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut to clipboard" })
map("i", "<C-v>", '<C-r>"', { desc = "Paste from clipboard" })

-- Git link
map({ "n", "v" }, "<leader>gl", "<cmd>GitLink<cr>", { desc = "Copy git permlink to clipboard" })
map({ "n", "v" }, "<leader>gL", "<cmd>GitLink!<cr>", { desc = "Open git permlink in browser" })
map({ "n", "v" }, "<leader>gm", "<cmd>GitLink blame<cr>", { desc = "Copy git blame link to clipboard" })
map({ "n", "v" }, "<leader>gM", "<cmd>GitLink! blame<cr>", { desc = "Open git blame link in browser" })

-- Git blame
map("n", "<leader>gT", "<cmd>GitBlameToggle<cr>", { desc = "Git blame line toggle" })

-- Emoji
map("i", "<C-i>", "<cmd>IconPickerInsert<cr>", {})
map("n", "<leader>Ei", "<cmd>IconPickerNormal<cr>", { desc = "See emoji" })
map("n", "<leader>Ey", "<cmd>IconPickerYank<cr>", { desc = "See and yank emoji to register" })

-- Sessions
map("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "Save current session" })
map("n", "<leader>sl", "<cmd>SessionLoad<cr>", { desc = "Load local session" })
map("n", "<leader>sL", "<cmd>SessionLoadLast<cr>", { desc = "Load last session" })
map("n", "<leader>sS", "<cmd>Telescope persisted<cr>", { desc = "Search sessions" })

-- Scratch
map("n", "<leader>tn", "<cmd>Scratch<cr>", { desc = "Create new scratch file" })
map("n", "<leader>to", "<cmd>ScratchOpen<cr>", { desc = "Open existing scratch file" })

-- DAP Settings
map("n", "<leader>dB", function()
	vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
		require("dap").set_breakpoint(input)
	end)
end, { desc = "Breakpoint Condition" })

map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Start/Continue" })

map("n", "<leader>dg", function()
	require("dap").goto_()
end, { desc = "Go to line (no execute)" })

map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step Into" })

map("n", "<leader>dj", function()
	require("dap").down()
end, { desc = "Down" })

map("n", "<leader>dk", function()
	require("dap").up()
end, { desc = "Up" })

map("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "Run Last" })

map("n", "<leader>do", function()
	require("dap").step_out()
end, { desc = "Step Out" })

map("n", "<leader>dO", function()
	require("dap").step_over()
end, { desc = "Step Over" })

map("n", "<leader>dp", function()
	require("dap").pause()
end, { desc = "Pause" })

map("n", "<leader>dr", function()
	require("dap").repl.toggle()
end, { desc = "Toggle REPL" })

map("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "Terminate" })

map("n", "<leader>ds", function()
	require("dap").set_exception_breakpoints()
end, { desc = "Set Exception Breakpoint" })

map("n", "<leader>du", function()
	require("dapui").toggle({})
end, { desc = "Toggle ui" })

map("n", "<leader>dR", function()
	require("dapui").setup(require("configs.dapuiconfig"))
end, { desc = "Reset ui" })

-- Indent Object
map({ "x", "o" }, "ai", function()
	require("treesitter_indent_object.textobj").select_indent_outer()
end, { desc = "Select context-aware indent (outer)" })

map({ "x", "o" }, "aI", function()
	require("treesitter_indent_object.textobj").select_indent_outer(true)
end, { desc = "Select context-aware indent (outer, line-wise)" })

map({ "x", "o" }, "ii", function()
	require("treesitter_indent_object.textobj").select_indent_inner()
end, { desc = "Select context-aware indent (inner, partial range)" })

map({ "x", "o" }, "iI", function()
	require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
end, { desc = "Select context-aware indent (inner, entire range) in line-wise visual mode" })
