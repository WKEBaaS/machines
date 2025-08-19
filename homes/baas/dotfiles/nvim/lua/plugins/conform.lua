--- @type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      local supported = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
        "html",
        "yaml",
        "scss",
        "less",
        "svelte",
        "vue",
      }

      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = { "deno_fmt" }
      end

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["kdl"] = { "kdlfmt" },
      })

      vim.inspect(opts.formatters_by_ft)
    end,
  },
}
