require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del

del("n", "<C-n>")

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Nix Justfile                                     │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<f1>", "<cmd>! just home<CR>", { desc = "Nix just home-manager" })
map("n", "<f2>", "<cmd>! just darwin<CR>", { desc = "Nix just darwin" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Override NvChad Mappings                         │
--     ╰───────────────────────────────────────────────────────────────────╯
-- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { remap = true })
map("n", "<leader>e", "<leader>fe", { desc = "Toggle neo-tree", remap = true })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Telescope                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "telescope diagnostics" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Editor                                           │
--     ╰───────────────────────────────────────────────────────────────────╯
map("i", "jk", "<ESC>", { nowait = true, desc = "Editor jk to escape" })
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
--     │                  Clipboard: Normal/Visual mode                    │
--     ╰───────────────────────────────────────────────────────────────────╯
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Editor Yank to system clipboard" })
map({ "n", "x" }, "<leader>Y", '"+yy', { desc = "Editor Yank line to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Editor Paste from system clipboard" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Editor Paste from system clipboard before cursor" })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Editor Delete to system clipboard" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  LSP                                              │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "lsp toggle inlay hints" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Tabufline                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
-- map("n", "<tab>", "<cmd>tabnext<CR>", { desc = "buffer goto next tab" })
-- map("n", "<S-tab>", "<cmd>tabprevious<CR>", { desc = "buffer goto next tab" })

map("n", "<leader>bO", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "buffer Close other buffer" })

map("n", "<leader>bo", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer Close all buffer" })

map("n", "<S-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                   Terminal                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
map({ "n", "t" }, "<A-1>", function()
  require("nvchad.term").toggle { cmd = "k9s", pos = "float", id = "k9sTerm" }
end, { desc = "terminal toggle floating k9s term" })
