local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.diagnostics.trail_space,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.prettierd.with({
            condition = function(utils)
                return utils.root_has_file({
                    ".prettierrc",
                    ".prettierrc.json",
                    ".prettierrc.json5",
                    ".prettierrc.yaml",
                    ".prettierrc.yml",
                    ".prettierrc.toml",
                    ".prettierrc.js",
                    ".prettierrc.ts",
                    ".prettierrc.cjs",
                    ".prettierrc.cts",
                    ".prettierrc.mjs",
                    ".prettierrc.mts",
                    "prettier.config.js",
                    "prettier.config.ts",
                    "prettier.config.cjs",
                    "prettier.config.cts",
                    "prettier.config.mjs",
                    "prettier.config.mts",
                })
            end,
        }),
    },
})
