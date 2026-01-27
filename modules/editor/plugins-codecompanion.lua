require("codecompanion").setup({
    adapters = {
        http = {
            ollama = function()
                local ollama_password = ""
                local f = io.open("/etc/local-secrets/ollama-key", "r")
                if f then
                    ollama_password = f:read("*all"):gsub("%s+", "")
                    f:close()
                end
                local credentials = "user:" .. ollama_password
                local base64_auth = vim.base64.encode(credentials)
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "https://llm.kevinkoshiol.com"
                    },
                    headers = {
                        ["Authorization"] = "Basic " .. base64_auth,
                    },
                    parameters = { sync = true },
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
