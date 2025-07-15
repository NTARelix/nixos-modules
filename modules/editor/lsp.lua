vim.lsp.set_log_level("debug")
require("lazydev").setup()
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
vim.lsp.config.tsgo_ls = {
    cmd = { "tsgo", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
local function get_nix_store_root(full_path)
    local pattern = "/nix/store/[a-z0-9%-\\.]+"
    local start_idx, end_idx = string.find(full_path, pattern)
    if start_idx then
        return string.sub(full_path, start_idx, end_idx)
    else
        return nil
    end
end
vim.lsp.config.vts_ls = {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "vue" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
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
                        location = get_nix_store_root(vim.loop.fs_realpath(
                        "/run/current-system/sw/bin/vue-language-server")) ..
                        "/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
                        languages = { "vue" },
                        configNamespace = "typescript",
                    },
                },
            },
        },
    },
}
vim.lsp.config.vue_ls = {
    cmd = { "vue-language-server", "--stdio" },
    filestypes = { "vue" },
    root_markers = { "package.json", ".git" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    init_options = {
        typescript = {
            tsdk = get_nix_store_root(vim.loop.fs_realpath("/run/current-system/sw/bin/vtsls")) ..
            '/lib/vtsls-language-server/node_modules/typescript/lib/',
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
vim.lsp.enable({ "lua_ls", "nil_ls", "tsgo_ls", "vts_ls", "vue_ls" })
