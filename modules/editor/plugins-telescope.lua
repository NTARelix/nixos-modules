vim.pack.add({
    {
        src = "https://github.com/nvim-telescope/telescope-ui-select.nvim",
        rev = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2",
    },
})

require("telescope").setup({
    defaults = {
        layout_config = {
            prompt_position = "top",
        },
        mappings = {
            i = {
                ["<Esc>"] = require("telescope.actions").close,
            },
        },
        sorting_strategy = "ascending",
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

require("telescope").load_extension("ui-select")
