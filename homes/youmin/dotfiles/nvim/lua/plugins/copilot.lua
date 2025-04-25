---@type NvPluginSpec
return {
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    event = { "InsertEnter" },
    cmd = { "Copilot" },
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept_word = false,
          accept_line = "<M-S-l>",
        },
      },
      filetypes = {
        yaml = true,
      },
    },
  },
}
