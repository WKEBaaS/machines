vim.lsp.config("svelte", {
  on_attach = function(client, bufnr)
    require("configs.lspconfig").on_attach(client, bufnr)
    vim.keymap.set(
      "n",
      "<leader>co",
      require("utils").lsp.action["source.organizeImports"],
      { buffer = bufnr, desc = "Organize Imports" }
    )
  end,
})
vim.lsp.enable "svelte"

--- @type NvPluginSpec
return {
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
}
