-- Leader
vim.g.mapleader = " "

-- Modes
vim.keymap.set("n", "<leader>z", ":NvimTreeToggle<cr>", { desc = "Distraction free" })

require("which-key").add({ "<leader>f", group = "Files" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope find_files<cr>", { desc = "Search" })
vim.keymap.set("n", "<leader>fn", "<cmd>echo 'not yet implemented'<cr>", { desc = "New" })
vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "Save" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>gi", { desc = "Save" })
vim.keymap.set("n", "<leader><leader>", ":so %<CR>", { desc = "Source" })

-- Text
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope live_grep<cr>", { desc = "Search" })
vim.keymap.set("n", "<leader>tr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace" })

-- Buffers
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "<leader>bs", "<cmd>Telescope buffers<cr>", { desc = "Search" })

-- Help
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- Manipulation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Swap ↓" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Swap ↑" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste" })

-- Overwrite defaults
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev" })
vim.keymap.set("n", "Q", "<nop>")

