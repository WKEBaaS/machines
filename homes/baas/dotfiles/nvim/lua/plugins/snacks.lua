-- better vim.ui with telescope

--- @type NvPluginSpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#928374" })
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#928374" })
  end,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
    },
    bufdelete = { enabled = true },
    lazygit = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
  },
}
