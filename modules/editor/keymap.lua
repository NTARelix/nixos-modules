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
map("n", "<leader>fo", [[<cmd>Telescope find_files<cr>]], "Open")
map("n", "<leader>fO", [[<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>]], "Open (all)")
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
map("n", "<leader>bd", [[:bd<cr>]], "Delete")

require("which-key").add({ "<leader>l", group = "LSP" })
map("n", "<leader>ld", [[<cmd>Telescope lsp_definitions<cr>]], "Definition(s)")
map("n", "<leader>lt", [[<cmd>Telescope lsp_type_definitions<cr>]], "Type Definition(s)")
map("n", "<leader>li", [[<cmd>Telescope lsp_implementations<cr>]], "Implementation")
map("n", "<leader>ln", vim.lsp.buf.rename, "Rename")
map("n", "<leader>lr", [[<cmd>Telescope lsp_references<cr>]], "References")
map("n", "K", vim.lsp.buf.hover, "LSP Hover")

require("which-key").add({ "<leader>g", group = "Git" })
map("n", "<leader>gs", [[<cmd>Telescope git_status<cr>]], "Status")
map("n", "<leader>gb", [[<cmd>Telescope git_branches<cr>]], "Branch")
map("n", "<leader>gh", [[<cmd>Telescope git_stash<cr>]], "Stash")
map("n", "<leader>gl", [[<cmd>Telescope git_commits<cr>]], "Log")
map("n", "<leader>gc", [[:Git commit<cr>]], "Commit")
map("n", "<leader>gr", [[:Git rebase -i<cr>]], "Rebase")
map("n", "<leader>gp", [[:Git pull<cr>]], "Pull")
map("n", "<leader>gP", [[:Git push<cr>]], "Push")

-- Single-key mappings
map("n", "<leader>h", [[<cmd>Telescope help_tags<cr>]], "Help")
map("n", "<leader>q", [[:wqa<cr>]], "Help")

-- Window movement
map("n", "<c-h>", [[<c-w>h]], "Focus left")
map("n", "<c-j>", [[<c-w>j]], "Focus down")
map("n", "<c-k>", [[<c-w>k]], "Focus up")
map("n", "<c-l>", [[<c-w>l]], "Focus right")

-- Window resize
map("n", "<c-up>", [[<cmd>resize -2<cr>]], "")
map("n", "<c-down>", [[<cmd>resize +2<cr>]], "")
map("n", "<c-left>", [[<cmd>vertical resize -2<cr>]], "")
map("n", "<c-right>", [[<cmd>vertical resize +2<cr>]], "")

-- Buffer manipulation
map("n", "<tab>", [[:bn<cr>]], "Next buffer")
map("n", "<s-tab>", [[:bp<cr>]], "Previous buffer")

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
map("v", ">", [[>gv]], "Indent")
map("v", "<", [[<gv]], "Dedent")
map("n", "Q", [[<nop>]])

