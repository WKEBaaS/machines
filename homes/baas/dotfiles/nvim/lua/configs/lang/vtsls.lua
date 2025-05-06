vim.lsp.config("vtsls", {
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
})
vim.lsp.enable "vtsls"

--- @type NvPluginSpec
return {
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "vtsls" })
    end,
  },
}
