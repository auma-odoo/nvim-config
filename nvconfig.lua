local options = {

	base64 = {
		theme = "catppuccin",
		theme_toggle = { "catppuccin" },
	},

	nvdash = {
		load_on_startup = true,
	},

	ui = {
		extended_integrations = { "dap", "rainbowdelimiters" },

		statusline = {
			theme = "default",
			separator_style = "default",
		},

		tabufline = {
			enabled = true,
			order = { "treeOffset", "buffers", "tabs", "btns" },
			modules = nil,
		},
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
