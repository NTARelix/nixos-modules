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
})
