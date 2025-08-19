---@type LazySpec
return {
  "flash.nvim",
  enabled = true,
    -- Remove LazyVim's default flash keymaps
    -- stylua: ignore
    keys = function() return {} end,
  config = function(_, opts)
    require("flash").setup(opts)
    vim.keymap.set("n", "f", require("flash").jump, { desc = "Flash" })
    vim.keymap.set("n", "F", require("flash").treesitter, { desc = "Flash Treesitter" })
  end,
}
