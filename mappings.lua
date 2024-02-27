---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<C-v>"] = "",
    ["<leader>pt"] = "",
    ["<leader>rn"] = "",
  },
}

M.general = {
  n = {
    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<leader>p"] = {
      function()
        require("telescope").extensions.project.project {}
      end,
      "Projects",
    },
    ["ga"] = {
      function()
        require("telescope.builtin").lsp_definitions { jump_type = "never" }
      end,
      "See definitions without jumping",
    },
    ["<leader>fg"] = {
      ":lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>",
      "Grep in current file",
    },
    ["gC"] = { ":tabnew<cr>", "Create a new tab" },
    ["<C-v>"] = { '"+p', "Paste to clipboard" },
    ["<leader>r"] = { "<Cmd>Telescope frecency workspace=CWD<CR>", "See previous opened files" },
    ["<leader>E"] = {
      "Emoji",
    },
    ["<leader>Ei"] = { "<cmd>IconPickerNormal<cr>", "See emoji" },
    ["<leader>Ey"] = { "<cmd>IconPickerYank<cr>", "See and yank emoji to register" },

    -- DAP Settings
    ["<leader>d"] = { "Debugging" },
    ["<leader>dB"] = {
      function()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
          require("dap").set_breakpoint(input)
        end)
      end,
      "Breakpoint Condition",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle Breakpoint",
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "Start/Continue",
    },
    ["<leader>dC"] = {
      function()
        require("dap").run_to_cursor()
      end,
      "Run to Cursor",
    },
    ["<leader>dg"] = {
      function()
        require("dap").goto_()
      end,
      "Go to line (no execute)",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      "Step Into",
    },
    ["<leader>dj"] = {
      function()
        require("dap").down()
      end,
      "Down",
    },
    ["<leader>dk"] = {
      function()
        require("dap").up()
      end,
      "Up",
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Run Last",
    },
    ["<leader>do"] = {
      function()
        require("dap").step_out()
      end,
      "Step Out",
    },
    ["<leader>dO"] = {
      function()
        require("dap").step_over()
      end,
      "Step Over",
    },
    ["<leader>dp"] = {
      function()
        require("dap").pause()
      end,
      "Pause",
    },
    ["<leader>dr"] = {
      function()
        require("dap").repl.toggle()
      end,
      "Toggle REPL",
    },
    ["<leader>dt"] = {
      function()
        require("dap").terminate()
      end,
      "Terminate",
    },
    ["<leader>du"] = {
      function()
        require("dapui").toggle {}
      end,
      "Toggle ui",
    },

  },
  v = {
    ["<C-c>"] = { '"+y', "Copy to clipboard" },
    ["<C-v>"] = { '"+p', "Paste to clipboard" },
    ["<C-x>"] = { '"+d', "Cut to clipboard" },
  },
  i = {
    ["<C-v>"] = { '<C-r>"', "Paste to clipboard" },
    ["<C-i>"] = { "<cmd>IconPickerInsert<cr>" },
  },
}

-- more keybinds!

return M
