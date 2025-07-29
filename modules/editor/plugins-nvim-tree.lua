require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
    },
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        --- Convenience wrapper around `vim.keymap.set` that only binds to the NvimTree buffer
        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs string|function
        ---@param desc string
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
                desc = desc,
            })
        end
        local function get_nvimtree_curr_dir()
            local node = api.tree.get_node_under_cursor()
            if node then
                if node.type == "directory" then
                    return node.absolute_path
                else
                    return vim.fn.fnamemodify(node.absolute_path, ":h")
                end
            end
            return vim.fn.getcwd()
        end
        local function open_telescope_live_grep_from_nvimtree_dir()
            local search_dir = get_nvimtree_curr_dir()
            if search_dir then
                require("telescope.builtin").live_grep({ cwd = search_dir })
            end
        end
        api.config.mappings.default_on_attach(bufnr)
        map("n", "gG", open_telescope_live_grep_from_nvimtree_dir, "Find file")
    end,
})
