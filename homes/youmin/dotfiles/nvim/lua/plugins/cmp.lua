---@type NvPluginSpec
return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<C-s>"] = require("cmp").mapping.complete(),
        ["<C-Space>"] = {},
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sorting = {}
      opts.sorting.comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require "clangd_extensions.cmp_scores",
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      }
    end,
  },
}
