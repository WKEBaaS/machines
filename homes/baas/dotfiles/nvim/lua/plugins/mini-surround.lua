---@type LazySpec
return {
  {
    "echasnovski/mini.surround",
    version = false,
    enabled = false,
    keys = {
      { "S", mode = "x" },
      { "ds", mode = "n" },
      { "cs", mode = "n" },
    },
    opts = {
      mappings = {
        add = "S",
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
