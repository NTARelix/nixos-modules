-- Globals
vim.g.mapleader = " "

-- Options
vim.opt.list = true
vim.opt.listchars = {
    tab = "»·",
    multispace = "·",
    lead = "·",
    leadmultispace = "|···",
    trail = "·",
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120"

-- Generic Keybinds
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste" })
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<cr>", { desc = "View" })
vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Find" })
vim.keymap.set("n", "<leader>pg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>ph", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Swap ↓" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Swap ↑" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join" })
vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "Save" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>gi", { desc = "Save" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace all" })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader><leader>", ":so %<CR>", { desc = "Source" })

-- Plugins
local gitsigns = require("gitsigns")
local cmp = require("cmp")
local lspconfig = require("lspconfig")
local nvim_tree = require("nvim-tree")
local nvim_treesitter = require("nvim-treesitter")
local telescope = require("telescope")
local which_key = require("which-key")

gitsigns.setup()
cmp.setup()
nvim_tree.setup()
nvim_treesitter.setup()
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Esc>"] = require("telescope.actions").close,
      },
    },
  },
})
lspconfig.ts_ls.setup({})
lspconfig.volar.setup({
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
})
which_key.setup({
    spec = {
        { "<leader>p", group = "Project" },
    },
})

