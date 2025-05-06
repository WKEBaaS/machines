local lua_lsp_settings = {
  Lua = {
    workspace = {
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        "${3rd}/luv/library",
      },
    },
  },
}

vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
vim.lsp.enable "lua_ls"

--- @type NvPluginSpec
return {}
