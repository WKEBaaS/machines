require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Delete NvChad Defaults                           │
--     ╰───────────────────────────────────────────────────────────────────╯
del("n", "<C-n>")
del("i", "<C-h>")
del("i", "<C-l>")
del("i", "<C-j>")
del("i", "<C-k>")

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                   Mini.Nvim                                       │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>E", function()
  require("mini.files").open(vim.uv.cwd(), true)
end, { desc = "File Explorer (cwd)" })
map("n", "<leader>e", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
  if vim.fn.filereadable(buf_name) == 1 then
    -- Pass the full file path to highlight the file
    require("mini.files").open(buf_name, true)
  elseif vim.fn.isdirectory(dir_name) == 1 then
    -- If the directory exists but the file doesn't, open the directory
    require("mini.files").open(dir_name, true)
  else
    -- If neither exists, fallback to the current working directory
    require("mini.files").open(vim.uv.cwd(), true)
  end
end, { desc = "File Explorer" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Override NvChad Mappings                         │
--     ╰───────────────────────────────────────────────────────────────────╯
-- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { remap = true })

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
map("n", "<leader>fc", function()
  Snacks.picker.files { cwd = vim.fn.stdpath "config" }
end, { desc = "Snacks picker find config files" })
-- Other
-- stylua: ignore
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Snacks zen mode" })

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
map({ "n", "x" }, "y", '"+y', { desc = "Editor Yank to system clipboard" })
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
map("n", "]d", function()
  vim.diagnostic.jump { float = true, count = 1 }
end, { desc = "Next diagnostic" })
map("n", "[d", function()
  vim.diagnostic.jump { float = true, count = -1 }
end, { desc = "Prev diagnostic" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                  Tabufline                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
map("n", "<leader>b", "", { desc = "Buffer +buffer" })
map("n", "<leader>bO", Snacks.bufdelete.other, { desc = "Buffer Close other buffer" })
map("n", "<leader>bo", Snacks.bufdelete.all, { desc = "Buffer Close all buffer" })

map("n", "<S-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
map("n", "<S-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

--     ╭───────────────────────────────────────────────────────────────────╮
--     │                   Terminal                                        │
--     ╰───────────────────────────────────────────────────────────────────╯
-- stylua: ignore start
map("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "Terminal lazygit" })
-- stylua: ignore end
map({ "n", "t" }, "<M-9>", function()
  require("nvchad.term").toggle { pos = "float", id = "k9s", cmd = "k9s" }
end, { desc = "Terminal k9s" })
-- Code Runner
map("n", "<M-r>", function()
  require("nvchad.term").runner {
    id = "runner",
    pos = "sp",

    cmd = function()
      local file = vim.fn.expand "%"

      local ft_cmds = {
        python = "python3 " .. file,
        cpp = "clear && g++ -o out " .. file .. " && ./out",
        go = "go run .",
      }

      return ft_cmds[vim.bo.ft]
    end,
  }
end, { desc = "Terminal code runner" })
