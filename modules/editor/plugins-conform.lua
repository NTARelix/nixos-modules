---Finds a file in the given dir or one of its ancestors
---@param patterns string[] the pattern(s) to search for
---@return fun(self, ctx): boolean a `condition` function that returns true if the file was found; false otherwise
local function create_find_condition(patterns)
    return function(_, ctx)
        return vim.fs.find(
            function(name, _)
                for _, pattern in ipairs(patterns) do
                    if name:match(pattern) then return true end
                end
                return false
            end,
            { upward = true, type = "file", path = ctx.filename }
        )[1] ~= nil
    end
end

local prettier_formatter = { "prettierd", "eslint_d", stop_after_first = true }

require("conform").setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        javascript = prettier_formatter,
        javascriptreact = prettier_formatter,
        json = { "prettierd" },
        less = { "prettierd" },
        lua = { "stylua" },
        scss = { "prettierd" },
        typescript = prettier_formatter,
        typescriptreact = prettier_formatter,
        vue = prettier_formatter,
        yaml = { "prettierd" },
    },
    formatters = {
        eslint_d = {
            condition = create_find_condition({ "^%.eslintrc", "^eslint%config%." }),
        },
        prettierd = {
            condition = create_find_condition({ "^%.prettierrc", "^prettier%.config%." }),
        },
    },
})
