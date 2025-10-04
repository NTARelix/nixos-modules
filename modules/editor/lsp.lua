-- vim.lsp.set_log_level("DEBUG")
require("lazydev").setup()

vim.lsp.config.css_ls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = false }, -- needed to enable formatting capabilities
    root_markers = { 'package.json', '.git' },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
}
vim.lsp.config.eslint_ls = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = { "astro", "htmlangular", "javascript", "javascript.jsx", "javascriptreact", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" },
    root_markers = { "package.json", ".git" },
    workspace_required = true,
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(0, "LspEslintFixAll", function()
            client:request_sync("workspace/executeCommand", {
                command = "eslint.applyAllFixes",
                arguments = {
                    uri = vim.uri_from_bufnr(bufnr),
                    version = vim.lsp.util.buf_versions[bufnr],
                },
            }, nil, bufnr)
        end, {})
    end,
    settings = {
        validate = "on",
        packageManager = nil,
        useESLintClass = false,
        experimental = { useFlatConfig = false },
        codeActionOnSave = { enable = false, mode = "all" },
        format = true,
        quiet = false,
        onIgnoredFiles = "off",
        rulesCustomizations = {},
        run = "onType",
        problems = { shortenToSingleLine = false },
        nodePath = "",
        workingDirectory = { mode = "location" },
        codeAction = {
            disableRuleComment = { enable = true, location = "separateLine" },
            showDocumentation = { enable = true },
        },
    },
    before_init = function(_, config)
        local root_dir = config.root_dir
        if root_dir then
            config.settings = config.settings or {}
            config.settings.workspaceFolder = { uri = root_dir, name = vim.fn.fnamemodify(root_dir, ":t") }
        end
        local flat_config_files = {
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            "eslint.config.ts",
            "eslint.config.mts",
            "eslint.config.cts",
        }
        for _, file in ipairs(flat_config_files) do
            if vim.fn.filereadable(root_dir .. "/" .. file) == 1 then
                config.settings.experimental = config.settings.experimental or {}
                config.settings.experimental.useFlatConfig = true
            end
        end
        local pnp_cjs = root_dir .. "/.pnp.cjs"
        local pnp_js = root_dir .. "/pnp.js"
        if vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js) then
            local cmd = config.cmd
            config.cmd = vim.list_extend({ "yarn", "exec" }, cmd)
        end
    end,
    handlers = {
        ["eslint/openDoc"] = function(_, result)
            if result then
                vim.ui.open(result.url)
            end
            return {}
        end,
        ["eslint/confirmESLintExecution"] = function(_, result)
            if not result then
                return
            end
            return 4
        end,
        ["eslint/probeFailed"] = function()
            vim.notify("[lsp] ESLint probe failed.", vim.log.levels.WARN)
            return {}
        end,
        ["eslint/noLibrary"] = function()
            vim.notify("[lsp] Unable to find ESLint library.", vim.log.levels.WARN)
            return {}
        end,
        ["textDocument/formatting"] = function(_, result, ctx, config)
            vim.api.nvim_command("LspEslintFixAll")
        end,
    },
}
require("lspconfig").jsonls.setup({
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})
vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
}
vim.lsp.config.nil_ls = {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
vim.lsp.config.tailwindcss_ls = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
    },
    root_markers = { "package.json", ".git" },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
            },
            classAttributes = {
                'class',
                'className',
                'class:list',
                'classList',
            },
            classFunctions = {
                "clsx",
                "cn",
                "cva",
                "tw",
                "tw\\.[a-z-]+",
            },
        },
    },
}
-- vim.lsp.config.tsgo_ls = {
--     cmd = { "tsgo", "--lsp", "--stdio" },
--     filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
--     root_markers = { "package.json", "tsconfig.json", ".git" },
--     capabilities = vim.lsp.protocol.make_client_capabilities(),
--     on_init = function(client)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--     end,
-- }
local function get_nix_store_root(full_path)
    local pattern = "/nix/store/[a-z0-9%-\\.]+"
    local start_idx, end_idx = string.find(full_path, pattern)
    if start_idx then
        return string.sub(full_path, start_idx, end_idx)
    else
        return nil
    end
end
local tsserver_path = get_nix_store_root(vim.loop.fs_realpath(
        "/run/current-system/sw/bin/vue-language-server")) ..
    "/lib/language-tools/packages/language-server"
vim.lsp.config.vts_ls = {
    cmd = { "vtsls", "--stdio" },
    -- filetypes = { "vue" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(client, bufnr)
        local function goto_source_definition()
            local position_params = vim.lsp.util.make_position_params(0, "utf-8")
            client:exec_cmd(
                {
                    title = "Go to source definition",
                    command = "typescript.goToSourceDefinition",
                    arguments = { vim.uri_from_bufnr(bufnr), position_params.position },
                },
                { buffer = bufnr },
                function(error, result)
                    if error then
                        print("error:", error)
                    elseif result then
                        -- print("results:", vim.inspect(result))
                        vim.lsp.util.show_document(result[1], "utf-8", { focus = true, reuse_win = true })
                    else
                        print("no error and no result!")
                    end
                end
            )
        end
        vim.keymap.set("n", "<leader>ls", goto_source_definition, { desc = "Go to source definition", buffer = bufnr })
    end,
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    -- Likely to change when nixpkgs updates to vue-language-server v3.x
                    -- https://github.com/neovim/nvim-lspconfig/blob/ecb74c22b4a6c41162153f77e73d4ef645fedfa0/lsp/ts_ls.lua
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
}
local ts_path = get_nix_store_root(vim.loop.fs_realpath("/run/current-system/sw/bin/vtsls")) ..
    '/lib/vtsls-language-server/node_modules/typescript/lib/'
vim.lsp.config.vue_ls = {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json", ".git" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    init_options = {
        typescript = {
            tsdk = ts_path,
        },
    },
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        client.handlers["tsserver/request"] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vts_ls" })
            if #clients == 0 then
                vim.notify("Could not find `vts_ls` lsp client, required by `vue_ls`.", vim.log.levels.ERROR)
                return
            end
            local ts_client = clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd(
                {
                    title = "vue_request_forward",
                    command = "typescript.tsserverRequest",
                    arguments = {
                        command,
                        payload,
                    },
                },
                { bufnr = context.bufnr },
                function(_, r)
                    local response_data = { { id, r.body } }
                    client:notify("tsserver/response", response_data)
                end
            )
        end
    end,
}
vim.lsp.enable({
    "bashls",
    "eslint_ls",
    "jsonls",
    "lua_ls",
    "nil_ls",
    "tailwindcss_ls",
    "terraformls",
    -- "tsgo_ls",
    "vts_ls",
    "vue_ls",
})
