return {
  {
    "echasnovski/mini.surround",
    version = false,
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
}
