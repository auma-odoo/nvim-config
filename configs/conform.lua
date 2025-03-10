return {
  lsp_fallback = true,
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },

    sql = { "sqlfmt", "sql_formatter" },

    markdown = { { "prettierd", "prettier" } }
  },
}
