local function setup()
  local utils = require "utils"
  local lsp = require "configs.lspconfig"

  require("lspconfig").vtsls.setup {
    on_attach = function(client, bufnr)
      lsp.on_attach(client, bufnr)
    end,
    capabilities = lsp.capabilities,
    on_init = lsp.on_init,
    tsserver = {
      globalPlugins = {
        {
          name = "typescript-svelte-plugin",
          location = vim.fn.stdpath "data"
            .. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
          enableForWorkspaceTypeScriptVersions = true,
        },
      },
    },
  }
end

--- @type NvPluginSpec
return {
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "vtsls" })
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      handlers = {
        ["vtsls"] = setup,
      },
    },
  },
}

-- utils.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
--   {
--     name = "typescript-svelte-plugin",
--     location = vim.fn.stdpath "data"
--       .. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
--     enableForWorkspaceTypeScriptVersions = true,
--   },
-- })
