local progress = require('fidget.progress')
local handles = {}

vim.api.nvim_create_autocmd('User', {
    pattern = 'TaskProgress',
    callback = function(args)
        local data = args.data
        if data.state == 'pending' then
            handles[data.id] = progress.handle.create({
                title = data.title,
                message = data.message,
            })
        elseif data.state == 'resolved' then
            if handles[data.id] then
                handles[data.id]:finish()
                handles[data.id] = nil
            end
            if data.message then
                vim.notify(data.message, vim.log.levels.INFO, { title = data.title })
            end
        elseif data.state == 'rejected' then
            if handles[data.id] then
                handles[data.id]:finish()
                handles[data.id] = nil
            end
            vim.notify(data.message or 'Task failed', vim.log.levels.ERROR, { title = data.title })
        end
    end,
})
