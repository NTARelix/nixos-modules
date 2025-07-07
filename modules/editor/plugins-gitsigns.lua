local gitsigns = require("gitsigns")

gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 50,
    },
    on_attach = function(bufnr)
        local which_key = require("which-key")
        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, {
                desc = desc,
                buffer = bufnr,
            })
        end
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({"]c", bang = true})
            else
                gitsigns.nav_hunk("next")
            end
        end, "Next hunk")
        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({"[c", bang = true})
            else
                gitsigns.nav_hunk("next")
            end
        end, "Next hunk")
        which_key.add({ "<leader>h", group = "Hunk" })
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset")
        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage")
        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset")
        map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview")
        map("n", "<leader>hd", gitsigns.diffthis, "Diff")
    end,
})

