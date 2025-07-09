vim.lsp.set_log_level("debug")
require("lazydev").setup()
vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
}

vim.lsp.enable("lua_ls")

