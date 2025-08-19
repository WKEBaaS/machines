---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local remove = {
        stylua = true,
      }
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not remove[tool]
      end, opts.ensure_installed or {})
    end,
  },

  -- Disable some LazyVim lsp default configurations
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
        marksman = {
          mason = false,
        },
        nil_ls = {
          mason = false,
        },
        ruff = {
          mason = false,
        },
      },
    },
  },
}
