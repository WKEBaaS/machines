-- local function restore_nvim_tree()
--   require("nvim-tree.api").tree.open { focus = false }
-- end

---@type NvPluginSpec
return {
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      { "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session Search session" },
      { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Session Save session" },
      { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Session Toggle autosave" },
    },
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- post_restore_cmds = { restore_nvim_tree },
    },
    config = function(_, opts)
      -- vim.keymap.set('n', '<leader>wr', '<cmd>SessionSearch<CR>', { noremap = true, silent = true })
      -- vim.keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { noremap = true, silent = true })
      -- vim.keymap.set('n', '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', { noremap = true, silent = true })
      require("auto-session").setup(opts)
    end,
  },
}
