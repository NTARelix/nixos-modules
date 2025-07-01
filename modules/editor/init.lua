-- Globals
vim.g.mapleader = " "

-- Options
vim.opt.list = true
vim.opt.listchars = {
  tab = "»·",
  multispace = "·",
  lead = "·",
  leadmultispace = "|·",
  trail = "·",
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
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

-- Generic Keybinds
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>gi", { desc = "Save" })

-- gitsigns
require("gitsigns").setup()

-- nvim-tree
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- nvim-treesitter
require("nvim-treesitter").setup()

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
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

