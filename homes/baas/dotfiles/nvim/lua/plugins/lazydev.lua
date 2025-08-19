---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = function(_, opts)
    opts.library = opts.library or {}
    vim.list_extend(opts.library, {
      { path = "lazy.nvim", words = { "LazySpec" } },
    })
  end,
}
