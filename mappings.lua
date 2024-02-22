---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<C-v>"] = "",
    ["<leader>pt"] = "",
  },
}

M.general = {
  n = {
    --  format with conform
    ["[b"] = { ":bp<cr>" },
    ["]b"] = { ":bn<cr>" },
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<leader>p"] = { ":lua require'telescope'.extensions.project.project{}<cr>", "Projects" },
    ["ga"] = {
      ":lua require'telescope.builtin'.lsp_definitions{ jump_type = \"never\" }<cr>",
      "See definitions without jumping",
    },
    ["gC"] = { ":tabnew<cr>", "Create a new tab" },
    ["<C-v>"] = { '"+p', "Paste to clipboard" },
    ["<leader>r"] = { "<Cmd>Telescope frecency workspace=CWD<CR>", "See previous opened files" },
    ["<leader>E"] = {
      "Emoji",
    },
    ["<leader>Ei"] = { "<cmd>IconPickerNormal<cr>", "See emoji" },
    ["<leader>Ey"] = { "<cmd>IconPickerYank<cr>", "See and yank emoji to register" },
  },
  v = {
    ["<C-c>"] = { '"+y',  "Copy to clipboard" },
    ["<C-v>"] = { '"+p',  "Paste to clipboard" },
    ["<C-x>"] = { '"+d',  "Cut to clipboard" },
  },
  i = {
    ["<C-v>"] = { '<C-r>"',  "Paste to clipboard" },
    ["<C-i>"] = { "<cmd>IconPickerInsert<cr>" },
  },
}

-- more keybinds!

return M
