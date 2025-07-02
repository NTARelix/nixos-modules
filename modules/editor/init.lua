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
vim.opt.colorcolumn = "80"

-- Generic Keybinds
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "delete" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste" })
vim.keymap.set("n", "<leader>pv", "<cmd>Telescope find_files<cr>", { desc = "find" })
vim.keymap.set("n", "<leader>pg", "<cmd>Telescope live_grep<cr>", { desc = "grep" })
vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<cr>", { desc = "buffers" })
vim.keymap.set("n", "<leader>ph", "<cmd>Telescope help_tags<cr>", { desc = "help_tags" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "swap ↓" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "swap ↑" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "join" })
vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "save" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>gi", { desc = "save" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "prev" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace all" })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader><leader>", ":so %<CR>", { desc = "source" })

-- gitsigns
require("gitsigns").setup()

-- nvim-cmp
require("cmp").setup()

-- nvim-tree
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- nvim-treesitter
require("nvim-treesitter").setup()

-- telescope
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Esc>"] = require("telescope.actions").close,
      },
    },
  },
}

-- typescript-language-server
require('lspconfig').ts_ls.setup({})

-- vue-language-server
require('lspconfig').volar.setup({
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
})

--vim.lsp.enable('typescript-language-server')
--vim.lsp.config('typescript-language-server', {
--  settings = {
--    ["typescript-language-server"] = {},
--  },
--})

--vim.lsp.enable('vue-language-server')
--vim.lsp.config('vue-language-server', {
--  settings = {
--    ["vue-language-server"] = {},
--  },
--})

