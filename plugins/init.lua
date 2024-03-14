return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
     opts = function()
      require "configs.treesitter"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      require "configs.nvimtree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "dharmx/telescope-media.nvim",
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup { disable_legacy_commands = true }
    end,
    lazy = false,
  },

  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
    opts = {
      visual_selection_highlight_mode = "reverse",
      status_window = { icons = { nvim = "" } },
    },
    config = function(_, opts)
      require("kitty-scrollback").setup(opts)
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
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
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart { "xdg-open", url }
      end,
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  {
    "rcarriga/nvim-notify",
    -- init = function()
    --     vim.notify = require("notify")
    -- end,
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {
          layouts = {
            {
              elements = {
                {
                  id = "scopes",
                  size = 0.25,
                },
                {
                  id = "breakpoints",
                  size = 0.25,
                },
                {
                  id = "stacks",
                  size = 0.25,
                },
                {
                  id = "watches",
                  size = 0.25,
                },
              },
              position = "left",
              size = 40,
            },
            {
              elements = {
                {
                  id = "repl",
                  size = 0.75,
                },
                {
                  id = "console",
                  size = 0.25,
                },
              },
              position = "bottom",
              size = 10,
            },
          },
        },
        config = function(_, opts)
          local dap, dapui = require "dap", require "dapui"

          local Config = {
            icons = {
              dap = {
                Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
                Breakpoint = " ",
                BreakpointCondition = " ",
                BreakpointRejected = { " ", "DiagnosticError" },
                LogPoint = ".>",
              },
            },
          }

          vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

          for name, sign in pairs(Config.icons.dap) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
              "Dap" .. name,
              { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
          end

          dapui.setup(opts)

          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          "williamboman/mason.nvim",
        },
        cmd = { "DapInstall", "DapUninstall" },
        opts = function()
          require "configs.dapconfig"
        end,
      },
    },
    lazy = false,
  },

  {
    "tpope/vim-dadbod",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "jsborjesson/vim-uppercase-sql",
    },
    init = function()
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/db_ui"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_execute_on_save = false
      vim.g.db_ui_use_nvim_notify = true

      vim.api.nvim_create_autocmd("FileType", {
        pattern = sql_ft,
        callback = function()
          ---@diagnostic disable-next-line: missing-fields
          local cmp = require "cmp"
          local global_sources = cmp.get_config().sources
          local buffer_sources = {}

          -- add globally defined sources (see separate nvim-cmp config)
          -- this makes e.g. luasnip snippets available since luasnip is configured globally
          if global_sources then
            for _, source in ipairs(global_sources) do
              table.insert(buffer_sources, { name = source.name })
            end
          end

          -- add vim-dadbod-completion source
          table.insert(buffer_sources, { name = "vim-dadbod-completion" })

          -- update sources for the current buffer
          cmp.setup.buffer { sources = buffer_sources }
        end,
      })
    end,
  },

  {
    "linrongbin16/gitlinker.nvim",
    cmd = { "GitLink" },
    opts = {},
    config = function(_, opts)
      require("gitlinker").setup(opts)
    end,
  },

  {
    "chrishrb/gx.nvim",
    keys = {},
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

}
