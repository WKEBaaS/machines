---@type LazySpec
return {
  "AckslD/nvim-trevJ.lua",
  event = "VeryLazy",
  keys = {
    {
      "<leader>j",
      function()
        require("trevj").format_at_cursor()
      end,
      desc = "Format at cursor",
    },
  },
}
