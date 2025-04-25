local sql_ft = { "plsql" }

--- @type NvPluginSpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      for _, ft in ipairs(sql_ft) do
        vim.treesitter.language.register("sql", ft)
      end

      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "sql")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "sqlfluff" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      for _, ft in ipairs(sql_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        table.insert(opts.linters_by_ft[ft], "sqlfluff")
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters.sqlfluff = {
        args = { "format", "--dialect=ansi", "-" },
      }
      for _, ft in ipairs(sql_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "sqlfluff")
      end
    end,
  },
}
