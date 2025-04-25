---@type NvPluginSpec
return {
  { import = "configs.lang.lua" },
  { import = "configs.lang.svelte" },
  { import = "configs.lang.vtsls" },
  { import = "configs.lang.nix" },
  { import = "configs.lang.rust" },
  { import = "configs.lang.docker" },
  { import = "configs.lang.sql" },
  { import = "configs.lang.go" },
  { import = "configs.lang.json" },
  { import = "configs.lang.yaml" },
  { import = "configs.lang.clangd" },

  -- { import = "configs.format.deno" },
  { import = "configs.format.deno" },
  -- { import = "configs.format.prettier" },

  {
    "neovim/nvim-lspconfig",
    -- event = { "VeryLazy", "BufRead" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig",
    },
  },
}
