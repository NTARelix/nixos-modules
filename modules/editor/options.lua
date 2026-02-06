vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120"
vim.opt.winblend = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.listchars = {
    tab = "»·",
    multispace = "·",
    lead = "·",
    leadmultispace = "|···",
    trail = "·",
    nbsp = "⍽",
}
local bg_color = "#0c0c0c"
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg_color })
local function update_lead()
    local lc = vim.opt_local.listchars:get()
    local lms = vim.fn.str2list(lc.leadmultispace)
    local space = vim.fn.str2list(lc.multispace)
    local lead = { lms[1] }
    for i = 1, vim.bo.tabstop - 1 do
        lead[#lead + 1] = space[i % #space + 1]
    end
    vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
end
vim.api.nvim_create_autocmd(
    "OptionSet",
    { pattern = { "listchars", "tabstop", "filetype" }, callback = update_lead }
)
vim.api.nvim_create_autocmd("BufEnter", { callback = update_lead })
vim.api.nvim_create_autocmd("VimEnter", { callback = update_lead, once = true })
