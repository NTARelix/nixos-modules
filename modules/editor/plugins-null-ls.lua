local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.diagnostics.trail_space,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.prettierd,
    },
})
