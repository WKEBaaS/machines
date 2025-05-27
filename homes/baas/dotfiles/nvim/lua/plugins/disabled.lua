return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local remove = {
        stylua = true,
        shfmt = true,
      }
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not remove[tool]
      end, opts.ensure_installed or {})
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
      },
    },
  },

  { "flash.nvim", enabled = false },
}
