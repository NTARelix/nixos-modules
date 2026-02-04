require("codecompanion").setup({
    adapters = {
        http = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = 'cmd: cat /etc/local-secrets/ollama-url',
                        base64_auth = 'cmd: echo -n "user:$(cat /etc/local-secrets/ollama-key)" | base64',
                    },
                    headers = {
                        ["Authorization"] = "Basic ${base64_auth}",
                    },
                    parameters = {
                        sync = true,
                    },
                })
            end
        }
    },
    interactions = {
        chat = {
            adapter = "ollama",
            model = "qwen3-coder:30b",
        },
    },
    extensions = {
        spinner = {},
    },
})
