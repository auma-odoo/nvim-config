return {
  colorscheme = "kanagawa",
  -- lsp = {
  --   servers = {
  --     "odoo_lsp",
  --   },
  --   config = {
  --     odoo_lsp = function()
  --       return {
  --         cmd = { "odoo-lsp" },
  --         filetypes = { "javascript", "xml", "python" },
  --         root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json", ".git"),
  --       }
  --     end,
  --   },
  -- },
  mappings = {
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
    },
    v = {
      ["<C-c>"] = { '"+y', desc = "Copy to clipboard" },
      ["<C-v>"] = { '"+p', desc = "Paste to clipboard" },
      ["<C-x>"] = { '"+d', desc = "Cut to clipboard" },
    },
    i = {
      ["<C-v>"] = { '<C-r>"+p', desc = "Paste to clipboard" },
    },
  },
}
