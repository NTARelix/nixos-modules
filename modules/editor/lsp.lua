vim.lsp.set_log_level("debug")
require("lazydev").setup()
vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
}
vim.lsp.config.nil_ls = {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
}
vim.lsp.config.tsgo_ls = {
    cmd = { "tsgo", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
}
vim.lsp.enable({ "lua_ls", "nil_ls", "tsgo_ls" })

