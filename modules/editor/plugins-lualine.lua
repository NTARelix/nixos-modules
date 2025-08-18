require("lualine").setup({
    options = {
        disabled_filetypes = {
            "NvimTree",
        },
    },
    sections = {
        lualine_c = {
            {
                "filename",
                path = 1,
            },
        },
    },
})
