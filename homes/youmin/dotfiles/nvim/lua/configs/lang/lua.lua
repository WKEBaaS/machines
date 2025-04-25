local function setup()
  local mylsp = require "configs.lspconfig"

  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  require("lspconfig").lua_ls.setup {
    on_attach = mylsp.on_attach,
    capabilities = mylsp.capabilities,
    on_init = mylsp.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }
end

--- @type NvPluginSpec
return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "stylua" } },
  },
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "lua_ls" })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      handlers = {
        ["lua_ls"] = setup,
      },
    },
  },
}
