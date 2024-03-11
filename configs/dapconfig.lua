local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

local M = {}

M.mason_dap = {
  ensure_installed = { "python" },
  handlers = {
    python = function(source_name)
      local dap = require "dap"

      local trim_whitspaces = function(table)
        for key, str in pairs(table) do
          table[key] = str:gsub("%s+", "")
        end
      end

      local get_dababase_list = function()
        local raw_list_table = utils.get_os_command_output {
          "psql",
          "-c",
          "SELECT datname FROM pg_database WHERE datname <> ALL ('{template0,template1,postgres}') ORDER BY datname",
        }
        table.remove(raw_list_table, 1)
        table.remove(raw_list_table, 1)
        table.remove(raw_list_table)
        table.remove(raw_list_table)
        trim_whitspaces(raw_list_table)
        return raw_list_table
      end

      local get_process = function() end

      local custom_picker = function(prompt_title, results, callback)
        local opts = {}
        return pickers
          .new(opts, {
            prompt_title = prompt_title,
            finder = finders.new_table { results = results },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(buffer_number)
              actions.select_default:replace(function()
                actions.close(buffer_number)
                local selection = action_state.get_selected_entry()
                callback(selection[1])
              end)
              return true
            end,
          })
          :find()
      end

      local database_picker = function(callback)
        custom_picker("Choose the database", get_dababase_list(), callback)
      end

      local ask_test_tags = function(callback)
        vim.ui.input({ prompt = "Test tags" }, function(input)
          callback(input)
        end)
      end

      local ask_modules = function(callback)
        vim.ui.input({ prompt = "Modules to initialize" }, function(input)
          callback(input)
        end)
      end

      local ask_name_database = function(callback)
        vim.ui.input({ prompt = "Name of the database" }, function(input)
          callback(input)
        end)
      end

      local ask_yes_no_question = function(prompt, callback)
        vim.ui.select({ "No", "Yes" }, { prompt = prompt }, function(choice)
          local returned_boolean = false
          if choice == "Yes" then
            returned_boolean = true
          end
          callback(returned_boolean)
        end)
      end

      local ask_if_new_database = function(callback)
        ask_yes_no_question("Do you want to create a new database?", function(answer)
          callback(answer)
        end)
      end

      local ask_if_drop_database = function(database_name, callback)
        ask_yes_no_question("Do you want to drop the database?", function(answer)
          if answer then
            local code = os.execute("psql -c 'drop database \"" .. database_name .. "\"'")
            vim.notify("Return " .. code, "info", { title = "Drop database " .. database_name })
          end
          callback(answer)
        end)
      end

      local ask_format_output = function(callback)
        vim.ui.select(
          { "speedscope", "flamegraph" },
          { prompt = "Which format do you want as output?" },
          function(selection)
            local filetype = "json"
            if selection == "flamegraph" then
              filetype = "svg"
            end
            callback(selection, filetype)
          end
        )
      end

      local get_test_args = function(modules, test_tags, database_name)
        return {
          "--addons-path",
          "~/Documents/repo/odoo/addons,~/Documents/repo/enterprise,~/Documents/repo/internal/default,~/Documents/repo/design-themes",
          "-i",
          modules,
          "--test-tags",
          test_tags,
          "--test-enable",
          "--stop-after-init",
          "--log-level",
          "info",
          "-d",
          database_name,
        }
      end

      local get_normal_arg = function(database_name)
        return {
          "--addons-path",
          "~/Documents/repo/odoo/addons,~/Documents/repo/enterprise,~/Documents/repo/internal/default,~/Documents/repo/design-themes",
          "--log-level",
          "debug_sql",
          "--limit-memory-soft",
          "10097152000",
          "--limit-memory-hard",
          "10097152000",
          "--limit-time-real",
          "7202",
          "--http-port",
          "9000",
          "-d",
          database_name,
        }
      end

      local get_py_spy_args = function(format, filetype, database_name)
        local datetime = os.date "%Y-%m-%d_%H:%M:%S"
        return {
          "-f",
          format,
          "-o",
          string.format("%s_%s_%s.%s", format, database_name, datetime, filetype),
          "--",
          "python3",
          "/home/odoo/Documents/repo/odoo/odoo-bin",
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
          database_name,
        }
      end

      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or "127.0.0.1"
          cb {
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
              source_filetype = "python",
            },
          }
        else
          cb {
            type = "executable",
            command = "/usr/bin/python3",
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          }
        end
      end

      dap.configurations.python = {
        {
          name = "odoo-bin",
          type = "python",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = "/home/odoo/Documents/repo/odoo/odoo-bin",
          args = function()
            return coroutine.create(function(coro)
              ask_if_new_database(function(answer)
                if answer then
                  ask_name_database(function(database_name)
                    coroutine.resume(coro, get_normal_arg(database_name))
                  end)
                else
                  database_picker(function(selection)
                    coroutine.resume(coro, get_normal_arg(selection))
                  end)
                end
              end)
            end)
          end,
        },
        {
          name = "odoo-bin-test",
          type = "python",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = "/home/odoo/Documents/repo/odoo/odoo-bin",
          args = function()
            return coroutine.create(function(coro)
              -- It is not the most lisible code but vim.ui.input/select use callback to work asynchronously
              ask_test_tags(function(tags)
                ask_if_new_database(function(answer)
                  if answer then
                    -- Create new database with modules
                    ask_name_database(function(database_name)
                      ask_modules(function(modules)
                        coroutine.resume(coro, get_test_args(modules, tags, database_name))
                      end)
                    end)
                  else
                    -- Launch existing database with or without new data
                    database_picker(function(database_name)
                      ask_if_drop_database(database_name, function(answer)
                        if answer then
                          ask_modules(function(modules)
                            coroutine.resume(coro, get_test_args(modules, tags, database_name))
                          end)
                        else
                          coroutine.resume(coro, get_test_args("", tags, database_name))
                        end
                      end)
                    end)
                  end
                end)
              end)
            end)
          end,
        },
        -- {
        --   name = "py-spy",
        --   type = "python",
        --   request = "launch",
        --   cwd = "${workspaceFolder}",
        --   program = "py-spy",
        --   args = function()
        --     return coroutine.create(function(coro)
        --       database_picker(function(database_name)
        --         ask_format_output(function(format, filetype)
        --           coroutine.resume(coro, get_py_spy_args(format, filetype, database_name))
        --         end)
        --       end)
        --     end)
        --   end,
        -- },
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}", -- This configuration will launch the current file if used.
        },
      }
    end,
  },
}

return M
