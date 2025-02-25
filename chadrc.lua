---@type ChadrcConfig
local options = {

	base64 = {
		theme = "catppuccin",
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

return options
