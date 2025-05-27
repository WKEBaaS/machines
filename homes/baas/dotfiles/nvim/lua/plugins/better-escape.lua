---@type LazySpec
return {
  "max397574/better-escape.nvim",
  opts = {
    mappings = {
      t = {
        j = {
          k = false,
        },
      },
    },
  },
  config = function(_, opts)
    require("better_escape").setup(opts)
  end,
}
