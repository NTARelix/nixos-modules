-- vim.lsp.set_log_level("DEBUG")
require("lazydev").setup()

vim.lsp.config("cssls", {
    init_options = { provideFormatter = false }, -- needed to enable formatting capabilities
})

vim.lsp.config("jsonls", {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config("tailwindcss", {
    settings = {
        tailwindCSS = {
            classFunctions = { "cva", "cx", "cn" },
        },
    },
})

vim.lsp.config("vtsls", {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
    },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "/etc/vue-typescript-plugin",
                        languages = { "vue" },
                        configNamespace = "typescript",
                    },
                },
            },
        },
    },
})

vim.lsp.enable({
    "basedpyright",
    "bashls",
    "cssls",
    "eslint",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "nil_ls",
    "ols",
    "statix",
    "stylelint_lsp",
    "tailwindcss",
    "terraformls",
    "vtsls",
    "vue_ls",
    "yamlls",
})
