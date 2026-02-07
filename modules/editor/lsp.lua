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

local function get_nix_store_root(full_path)
    local pattern = "/nix/store/[a-z0-9%-\\.]+"
    local start_idx, end_idx = string.find(full_path, pattern)
    if start_idx then
        return string.sub(full_path, start_idx, end_idx)
    else
        return nil
    end
end

local tsserver_path = get_nix_store_root(
    vim.loop.fs_realpath("/run/current-system/sw/bin/vue-language-server")
) .. "/lib/language-tools/packages/language-server"

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
                        location = tsserver_path,
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
    "jsonls",
    "lua_ls",
    "nil_ls",
    "statix",
    "stylelint_lsp",
    "tailwindcss",
    "terraformls",
    "vtsls",
    "vue_ls",
    "yamlls",
})
