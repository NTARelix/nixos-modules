---Finds a file in the given dir or one of its ancestors
---@param patterns string[] the pattern(s) to search for
---@return fun(self, ctx): boolean a `condition` function that returns true if the file was found; false otherwise
local function create_find_condition(patterns)
    return function(_, ctx)
        return vim.fs.find(function(name, _)
            for _, pattern in ipairs(patterns) do
                if name:match(pattern) then
                    return true
                end
            end
            return false
        end, { upward = true, type = "file", path = ctx.filename })[1] ~= nil
    end
end

require("conform").setup({
    format_after_save = {
        lsp_format = "fallback",
        async = true,
    },
    formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        json = { "prettier" },
        less = { "prettier" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        scss = { "prettier" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        yaml = { "prettier" },
    },
    formatters = {
        eslint_d = {
            condition = create_find_condition({ "^%.eslintrc", "^eslint%.config%." }),
        },
        prettier = {
            condition = create_find_condition({ "^%.prettierrc", "^prettier%.config%." }),
        },
    },
})
