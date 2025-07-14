vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.bufnr, name = "null-ls" })
        if #clients > 0 then
            vim.lsp.buf.format({ bufnr = args.bufnr })
        end
    end,
})
