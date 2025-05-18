--- @type NvPluginSpec
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "ui/nvchad_types", mod = { "ui" } },
        { path = "lazy.nvim", mods = { "lazy" } },

        { path = "snacks.nvim", words = { "Snacks", "snacks.nvim" } },
        { path = "blink.cmp", words = { "blink.cmp" } },
        { pay = "nvim.cmp", words = { "nvim.cmp" } },

        { path = "copilot.lua", words = { "copilot.lua" } },
        { path = "CopilotChat.nvim", words = { "CopilotChat.nvim" } },
      },
    },
  },
}
