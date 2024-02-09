return {
  n = {
    ["<leader>ga"] = { ":Telescope repo cached_list<cr>", desc = "List Git repos" },
    ["<leader>z"] = { ":lua require'telescope'.extensions.project.project{}<cr>", desc = "Projects" },
    ["ga"] = {
      ":lua require'telescope.builtin'.lsp_definitions{ jump_type = \"never\" }<cr>",
      desc = "See definitions without jumping",
    },
    ["gC"] = { ":tabnew<cr>", desc = "Create a new tab" },
    ["<C-v>"] = { '"+p', desc = "Paste to clipboard" },
    ["<leader>r"] = { "<Cmd>Telescope frecency workspace=CWD<CR>", desc = "Previous opened files" },
    ["<leader>E"] = {
      name = " Emoji",
    },
    ["<leader>Ei"] = { "<cmd>IconPickerNormal<cr>", desc = "See emoji" },
    ["<leader>Ey"] = { "<cmd>IconPickerYank<cr>", desc = "See and yank emoji to register" },
  },
  v = {
    ["<C-c>"] = { '"+y', desc = "Copy to clipboard" },
    ["<C-v>"] = { '"+p', desc = "Paste to clipboard" },
    ["<C-x>"] = { '"+d', desc = "Cut to clipboard" },
  },
  i = {
    ["<C-v>"] = { '<C-r>"', desc = "Paste to clipboard" },
    ["<C-i>"] = { "<cmd>IconPickerInsert<cr>" },
  },
}
