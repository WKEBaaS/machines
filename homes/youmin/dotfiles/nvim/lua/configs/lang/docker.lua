local function setup_docker()
  local lsp = require "configs.lspconfig"

  require("lspconfig").dockerls.setup {
    on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
    end,
    capabilities = lsp.capabilities,
    on_init = lsp.on_init,
  }
end

local function setup_compose()
  local lsp = require "configs.lspconfig"

  require("lspconfig").docker_compose_language_service.setup {
    on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
    end,
    capabilities = lsp.capabilities,
    on_init = lsp.on_init,
  }
end

--- @type NvPluginSpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "dockerfile" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "dockerls" })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      handlers = {
        ["dockerls"] = setup_docker,
        ["docker_compose_language_service"] = setup_compose,
      },
    },
  },
}
