local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

function trim_whitspaces(table)
  for key, str in pairs(table) do
    table[key] = str:gsub("%s+", "")
  end
end

function get_dababase_list()
  local raw_list_table = utils.get_os_command_output {
    "psql",
    "-c",
    "SELECT datname FROM pg_database WHERE datname <> ALL ('{template0,template1,postgres}')",
  }
  table.remove(raw_list_table, 1)
  table.remove(raw_list_table, 1)
  table.remove(raw_list_table)
  table.remove(raw_list_table)
  trim_whitspaces(raw_list_table)
  return raw_list_table
end

return {
  { "rebelot/kanagawa.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = { -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/Documents/odoo-obsidian/",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
      highlight = {
        enable = true,
      },
    },
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tree_sitter_markdown = {
        install_info = {
          url = "~/Documents/repo/tree-sitter-markdown", -- local path or git repo
          files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
          -- optional entries:
          branch = "main", -- default branch in case of git repo if different from master
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
        filetype = "md", -- if filetype does not match the parser name
      }
    end,
  },
  { "sindrets/diffview.nvim" },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function() require("telescope").load_extension "frecency" end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "python" },
      handlers = {
        python = function(source_name)
          local dap = require "dap"
          dap.adapters.python = {
            type = "executable",
            command = "/usr/bin/python3",
            args = {
              "-m",
              "debugpy.adapter",
            },
          }

          dap.configurations.python = {
            {
              name = "odoo-bin",
              type = "python",
              request = "launch",
              cwd = "${workspaceFolder}",
              program = "/home/odoo/Documents/repo/odoo/odoo-bin",
              args = {
                "--addons-path",
                "~/Documents/repo/odoo/addons,~/Documents/repo/enterprise,~/Documents/repo/internal/default,~/Documents/repo/design-themes",
                "--log-level",
                "debug_sql",
                "--limit-memory-soft",
                "1097152000",
                "--limit-memory-hard",
                "1097152000",
                "--limit-time-real",
                "7202",
                "--http-port",
                "9000",
                "-d",
                function()
                  return coroutine.create(function(coro)
                    local opts = {}
                    pickers
                      .new(opts, {
                        prompt_title = "Name of the database",
                        finder = finders.new_table { results = get_dababase_list() },
                        sorter = conf.generic_sorter(opts),
                        attach_mappings = function(buffer_number)
                          actions.select_default:replace(function()
                            actions.close(buffer_number)
                            local selection = action_state.get_selected_entry()
                            coroutine.resume(coro, selection[1])
                          end)
                          return true
                        end,
                      })
                      :find()
                  end)
                end,
              },
            },
            {
              type = "python",
              request = "launch",
              name = "Launch file",
              program = "${file}", -- This configuration will launch the current file if used.
            },
          }
        end,
      },
    },
  },
}
