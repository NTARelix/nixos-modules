-- Options
-------------------------------------------------------------------------------
vim.cmd("colorscheme carbonfox")
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
-------------------------------------------------------------------------------
vim.g.mapleader = " "
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

--- Utility Funcs
-------------------------------------------------------------------------------
local lsp_loaded = false
local function get_lsp()
    if not lsp_loaded then
        lsp_loaded = true
    end
    return require("lspconfig")
end

-- Recursively searches upward for a filename
local function find_path(name, path, debug)
    if debug then print("find_path(" .. name .. ", " .. path .. ", " .. tostring(debug) ..")") end
    local pkg_path = path .. "/" .. name
    local stat = vim.loop.fs_stat(pkg_path)
    if stat then
        if debug then print("  => " .. pkg_path) end
        return pkg_path
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then return nil end
    return find_path(name, parent, debug)
end

local function get_file_content(path)
    local fd = io.open(path, "r")
    if not fd then return false end
    local content = fd:read("*a")
    fd:close()
    return content
end

local function package_has_dep(dep, path)
    local pkg_path = find_path("package.json", path)
    if not pkg_path then return false end
    local pkg_str = get_file_content(pkg_path)
    if not pkg_str then return false end
    local ok, pkg = pcall(vim.fn.json_decode, pkg_str)
    if not ok or not pkg then return false end
    local deps = vim.tbl_extend("force", pkg.dependencies or {}, pkg.devDependencies or {})
    return deps[dep] ~= nil
end

-- Plugins
-------------------------------------------------------------------------------
require("cmp").setup()
require("lualine").setup()
require("nvim-tree").setup()
require("nvim-treesitter").setup()
require("telescope").setup({
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
require("which-key").setup({
    spec = {
        { "<leader>p", group = "Project" },
    },
})

-- Lazy plugins
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(args)
        local cwd = vim.fn.getcwd()
        if not package_has_dep("vue", cwd) then return end
        vim.cmd("packadd nvim-lspconfig")
        require("lspconfig").volar.setup({
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
        })
    end,
    once = true,
})
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(args)
        local cwd = vim.fn.getcwd()
        if find_path(".git", cwd) == nil then return end
        vim.cmd("packadd gitsigns.nvim")
        require("gitsigns").setup()
    end,
})

