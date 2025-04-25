--- @type NvPluginSpec
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      local supported = {
        javascript = "js",
        typescript = "ts",
        javascriptreact = "jsx",
        typescriptreact = "tsx",
        markdown = "md",
        json = "json",
        jsonc = "jsonc",
        css = "css",
        html = "html",
        yaml = "yaml",
        scss = "scss",
        less = "less",
        svelte = "svelte",
        vue = "vue",
      }

      for ft, _ in pairs(supported) do
        opts.formatters_by_ft[ft] = { "deno_fmt" }
      end
    end,
  },
}
