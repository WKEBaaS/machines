-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                    LazyVim                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
del("n", "<leader>n")
map("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
map("x", "<leader>/", "gc", { remap = true, desc = "Comment selection" })

map("i", "<C-s>", function()
  require("blink-cmp").show()
end, { desc = "Blink completion" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                   Snacks                                          │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>f;", Snacks.picker.command_history, { desc = "Snacks picker command history" })
map("n", "<leader>fn", Snacks.picker.notifications, { desc = "Snacks picker notifications" })
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Snacks picker buffers" })
map("n", "<leader>fd", Snacks.picker.diagnostics, { desc = "Snacks picker diagnostics" })
map("n", "<leader>fw", Snacks.picker.grep, { desc = "Snacks picker grep" })
map("n", "<leader>ff", Snacks.picker.files, { desc = "Snacks picker find files" })
map("n", "<leader>fp", Snacks.picker.projects, { desc = "Snacks picker find projects" })
map("n", "<leader>fk", Snacks.picker.keymaps, { desc = "Snacks picker keymaps" })
map("n", "<leader>fo", Snacks.picker.lsp_symbols, { desc = "Snacks picker lsp symbols" })
map("n", "<leader>fc", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Snacks picker find config files" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                   Terminal                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map({ "n", "t" }, "<M-i>", function()
  Snacks.terminal(nil, {
    win = {
      border = "single",
      position = "float",
    },
  })
end, { desc = "Snacks float terminal" })
map({ "n", "t" }, "<M-h>", function()
  Snacks.terminal("zsh", {
    win = {
      position = "bottom",
    },
  })
end, { desc = "Snacks bottom terminal" })

-- Other
-- stylua: ignore
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Snacks zen mode" })
--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Editor                                           │
--     ╰───────────────────────────────────────────────────────────────────╯
-- map("i", "jk", "<ESC>", { nowait = true, desc = "Editor jk to escape" })
-- map("i", "kj", "<ESC>", { nowait = true, desc = "Editor jk to escape" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ">", ">>", { nowait = true, desc = "Editor Indent forward easily" })
map("n", "<", "<<", { nowait = true, desc = "Editor Indent backword easily" })
map("x", ">", ">gv", { nowait = true, desc = "Editor Indent forward easily" })
map("x", "<", "<gv", { nowait = true, desc = "Editor Indent backword easily" })
map("i", "<C-a>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-d>", "<Del>", { desc = "delete character" })
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Editor move selected block up and stay in visual mode" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Editor move selected down and stay in visual mode" })
map("x", "<M-j>", ":move '>+1<CR>gv-gv", { desc = "Editor move selected block up and stay in visual mode" })
map("x", "<M-k>", ":move '<-2<CR>gv-gv", { desc = "Editor move selected down and stay in visual mode" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Cursor Movement                                  │
--     ╰───────────────────────────────────────────────────────────────────╯
map({ "n", "x" }, "gh", "g0", { desc = "Editor Go to begging" })
map({ "n", "x" }, "gl", "g$", { desc = "Editor Go to end of line" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Tabufline                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>b", "", { desc = "Buffer +buffer" })
map("n", "<leader>bO", Snacks.bufdelete.other, { desc = "Buffer Close other buffer" })
map("n", "<leader>bo", Snacks.bufdelete.all, { desc = "Buffer Close all buffer" })
map("n", "<leader>bb", Snacks.bufdelete.delete, { desc = "Buffer Close current buffer" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Clipboard: Normal/Visual mode                    │
--     ╰───────────────────────────────────────────────────────────────────╯
map({ "n", "x" }, "y", '"+y', { desc = "Editor Yank to system clipboard" })
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Editor Yank to system clipboard" })
map({ "n", "x" }, "<leader>Y", '"+yy', { desc = "Editor Yank line to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Editor Paste from system clipboard" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Editor Paste from system clipboard before cursor" })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Editor Delete to system clipboard" })

map("n", "<leader>l", "", { desc = "+Lazy" })
map("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Lazy" })
map("n", "<leader>lg", function()
  Snacks.lazygit()
end, { desc = "Lazy lazygit" })
