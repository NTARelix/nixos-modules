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
