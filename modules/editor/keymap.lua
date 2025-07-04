-- Leader
vim.g.mapleader = " "

-- Helpers
function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
        noremap = true,
        silent = true,
        desc = desc,
    })
end

-- Modes
map("n", "<leader>z", [[:NvimTreeToggle<cr>]], "Distraction free")

require("which-key").add({ "<leader>f", group = "File" })
map("n", "<leader>fs", [[<cmd>Telescope find_files<cr>]], "Search")
map("n", "<leader>fn", [[<cmd>echo 'not yet implemented'<cr>]], "New")
map("n", "<C-s>", [[:w<cr>]], "Save")
map("i", "<C-s>", [[<esc>:w<cr>gi]], "Save")
map("n", "<leader><leader>", [[:so %<CR>]], "Source")

require("which-key").add({ "<leader>t", group = "Text" })
map("n", "<leader>ts", [[<cmd>Telescope live_grep<cr>]], "Search")
map("n", "<leader>tr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace")

require("which-key").add({ "<leader>b", group = "Buffer" })
map("n", "<leader>bf", vim.lsp.buf.format, "Format")
map("n", "<leader>bs", [[<cmd>Telescope buffers<cr>]], "Search")

map("n", "<leader>g", [[:LazyGit<cr>]], "Git")
map("n", "<leader>h", [[<cmd>Telescope help_tags<cr>]], "Help")

-- Manipulation
map("v", "J", [[:m '>+1<CR>gv=gv]], "Swap ↓")
map("v", "K", [[:m '<-2<CR>gv=gv]], "Swap ↑")
map("n", "J", [[mzJ`z]], "Join")
map({"n", "v"}, "<leader>d", [["_d]], "Delete")
map("x", "<leader>p", [["_dP]], "Paste")

-- Overwrite defaults
map("n", "<C-d>", [[<C-d>zz]], "Scroll down")
map("n", "<C-u>", [[<C-u>zz]], "Scroll up")
map("n", "n", [[nzzzv]], "Next")
map("n", "N", [[Nzzzv]], "Prev")
map("n", "Q", [[<nop>]])

