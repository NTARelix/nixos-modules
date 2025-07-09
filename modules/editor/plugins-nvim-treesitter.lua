require("nvim-treesitter").setup()
require("nvim-treesitter.configs").setup({
    modules = {},
    sync_install = false,
    ensure_installed = {},
    ignore_install = {},
    auto_install = false,
    highlight = {
        enable = true,
    },
})

