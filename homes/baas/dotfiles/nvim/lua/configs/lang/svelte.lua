local function setup()
  local utils = require "utils"
  local lsp = require "configs.lspconfig"

  require("lspconfig").svelte.setup {
    on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
      vim.keymap.set(
        "n",
        "<leader>co",
        utils.lsp.action["source.organizeImports"],
        { buffer = bufnr, desc = "Organize Imports" }
      )
    end,
    capabilities = lsp.capabilities,
    on_init = lsp.on_init,
  }
end

--- @type NvPluginSpec
return {
  -- {
  --   "conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       ["svelte"] = { "prettier" },
  --     },
  --   },
  -- },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = { ensure_installed = { "prettier" } },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "svelte", "typescript", "javascript" })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "svelte" })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      handlers = {
        ["svelte"] = setup,
      },
    },
  },
}
