vim.lsp.config("vtsls", {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
})
vim.lsp.config("vue_ls", {
    on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
            if #clients == 0 then
                vim.notify("Could not find `vtsls` lsp client, vue_lsp would not work without it.", vim.log.levels.ERROR)
                return
            end
            local ts_client = clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd(
                {
                    title = "",
                    command = "",
                    arguments = { command, payload },
                },
                { bufnr = context.bufnr },
                function(_, r)
                    local response_data = { { id, r.body } }
                    client:notify("tsserver/response", response_data)
                end
            )
        end
    end,
})
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
vim.lsp.enable({ "lua_ls", "vtsls", "vue_ls" })

