-- local utils = require "utils"

local function setup()
  local lsp = require "configs.lspconfig"

  require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
    end,
    capabilities = lsp.capabilities,
    on_init = lsp.on_init,
  }
  local clangd_ext_opts = require("lazy.core.config").spec.plugins["clangd_extensions.nvim"]
  require("clangd_extensions").setup(clangd_ext_opts or {})
end

--- @type NvPluginSpec
return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "codelldb" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cpp" })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      handlers = {
        ["clangd"] = setup,
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sorting.comparators, 1, require "clangd_extensions.cmp_scores")
    end,
  },
}
