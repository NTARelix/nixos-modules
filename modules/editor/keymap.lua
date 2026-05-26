-- Locals
local border = "rounded"

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Helpers

--- Convenience wrapper around `vim.keymap.set`
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc string
local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
        noremap = true,
        silent = true,
        desc = desc,
    })
end

-- Modes
require("which-key").add({ "<leader>f", group = "File" })
map("n", "<leader>f", [[<cmd>Telescope find_files<cr>]], "Open")
map("n", "<leader><leader>", [[:restart<CR>]], "Restart")

require("which-key").add({ "<leader>l", group = "LSP" })
map("n", "<leader>la", vim.lsp.buf.code_action, "Action")
map("n", "<leader>lt", [[<cmd>Telescope lsp_type_definitions<cr>]], "Type Definition(s)")
map("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Toggle inlay hints")
map("n", "<leader>li", [[<cmd>Telescope lsp_implementations<cr>]], "Implementation")
map("n", "<leader>ln", vim.lsp.buf.rename, "Rename")
map("n", "<leader>lr", [[<cmd>Telescope lsp_references<cr>]], "References")
map("n", "<leader>ls", [[<cmd>Telescope lsp_symbols<cr>]], "Symbols")
map("n", "<m-k>", vim.lsp.buf.signature_help, "LSP Hover Signature")

require("which-key").add({ "g", group = "Go to" })
map("n", "gd", require("telescope.builtin").lsp_definitions, "Definitions")

require("which-key").add({ "<leader>g", group = "Git" })
map("n", "<leader>gd", [[:CodeDiff<cr>]], "Diff")
map("n", "<leader>gb", require("telescope.builtin").git_branches, "Branch")
map("n", "<leader>gh", require("telescope.builtin").git_stash, "Stash")
map("n", "<leader>gl", require("telescope.builtin").git_commits, "Log")
map("n", "<leader>gp", [[:Git pull<cr>]], "Pull")
map("n", "<leader>gP", [[:Git push<cr>]], "Push")

require("which-key").add({ "<leader>h", group = "Hunk" })
map("n", "<leader>hs", require("gitsigns").stage_hunk, "Stage")
map("n", "<leader>hr", require("gitsigns").reset_hunk, "Reset")
map("v", "<leader>hs", function()
    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, "Stage")
map("v", "<leader>hr", function()
    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, "Reset")
map("n", "<leader>hS", require("gitsigns").stage_buffer, "Stage buffer")
map("n", "<leader>hR", require("gitsigns").reset_buffer, "Reset buffer")
map("n", "<leader>hp", require("gitsigns").preview_hunk, "Preview")
map("n", "<leader>hd", require("gitsigns").diffthis, "Diff")
map("n", "]c", function()
    if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
    else
        require("gitsigns").nav_hunk("next")
    end
end, "Next change")
map("n", "[c", function()
    if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
    else
        require("gitsigns").nav_hunk("prev")
    end
end, "Previous change")

-- Single-key mappings
map("n", "<leader>b", [[<cmd>bprev | bdelete #<cr>]], "Close buffer")
map("n", "<leader>z", [[:NvimTreeToggle<cr>]], "Toggle tree")
map("n", "<leader>d", vim.diagnostic.open_float, "Show")
map("n", "<leader>/", require("telescope.builtin").live_grep, "Search")
map("n", "<leader>?", require("telescope.builtin").help_tags, "Help")
map("v", "<leader>=", function()
    vim.cmd('normal! "zy')
    local raw_input = vim.fn.getreg("z")
    local clean_input = raw_input:gsub("%s+", "")
    local output = vim.fn.system("bc <<< " .. vim.fn.shellescape(clean_input))
    local result = output:match("[^%c\n\r]+") or ""
    if result:find("error") or result == "" then
        print("bc Error: " .. result)
    else
        vim.fn.setreg("z", result)
        vim.cmd('normal! gv"zp')
    end
end, "Calculate")

-- Window movement
map("n", "<c-h>", [[<c-w>h]], "Focus left")
map("n", "<c-j>", [[<c-w>j]], "Focus down")
map("n", "<c-k>", [[<c-w>k]], "Focus up")
map("n", "<c-l>", [[<c-w>l]], "Focus right")

-- Scrolling
map("n", "<m-j>", [[jzz]], "Scroll down")
map("n", "<m-k>", [[kzz]], "Scroll up")

-- Window resize
map("n", "<c-up>", [[<cmd>resize -2<cr>]], "")
map("n", "<c-down>", [[<cmd>resize +2<cr>]], "")
map("n", "<c-left>", [[<cmd>vertical resize -2<cr>]], "")
map("n", "<c-right>", [[<cmd>vertical resize +2<cr>]], "")

-- Buffer manipulation
map("n", "<tab>", [[:bn<cr>]], "Next buffer")
map("n", "<s-tab>", [[:bp<cr>]], "Previous buffer")

-- Text Manipulation
map("v", "J", [[:m '>+1<CR>gv=gv]], "Swap ↓")
map("v", "K", [[:m '<-2<CR>gv=gv]], "Swap ↑")
map("n", "J", [[mzJ`z]], "Join")
map("v", "<leader>d", [["_d]], "Delete")
map("x", "<leader>p", [["_dP]], "Paste")

-- Overwrite defaults
map("n", "<C-d>", [[<C-d>zz]], "Scroll down")
map("n", "<C-u>", [[<C-u>zz]], "Scroll up")
map("n", "n", [[nzzzv]], "Next")
map("n", "N", [[Nzzzv]], "Prev")
map("v", ">", [[>gv]], "Indent")
map("v", "<", [[<gv]], "Dedent")
vim.keymap.del("x", "Q")
