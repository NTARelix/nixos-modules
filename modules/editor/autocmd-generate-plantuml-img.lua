local next_id = 0

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.md',
    callback = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false);
        local content = table.concat(lines, '\n')
        for name, block in content:gmatch('@startuml%s+([%w_.-]+)\n(.-)@enduml') do
            local output_file = vim.fn.expand('%:p:h') .. '/' .. name .. '.png'
            local full_diagram = '@startuml\n' .. block .. '\n@enduml'
            local task_id = next_id
            next_id = next_id + 1
            local task_title = 'PlantUML'
            vim.api.nvim_exec_autocmds('User', {
                pattern = 'TaskProgress',
                data = {
                    id = task_id,
                    title = task_title,
                    state = 'pending',
                    message = 'generating ' .. name .. '.png...',
                },
            })
            local server_url = 'http://localhost:8080/plantuml/png/'
            vim.system({
                'curl',
                '-s',
                '--data-raw',
                full_diagram,
                server_url,
                '-o',
                output_file,
            }, {}, function(out)
                vim.schedule(function()
                    if out.code == 0 then
                        vim.api.nvim_exec_autocmds('User', {
                            pattern = 'TaskProgress',
                            data = {
                                id = task_id,
                                title = task_title,
                                state = 'resolved',
                                message = name .. '.png generated.',
                            },
                        })
                    else
                        print(out.stderr)
                        vim.api.nvim_exec_autocmds('User', {
                            pattern = 'TaskProgress',
                            data = {
                                id = task_id,
                                title = task_title,
                                state = 'rejected',
                                message = name .. '.png failed to generate. See :messages for stderr.',
                            },
                        })
                    end
                end)
            end
            )
        end
    end,
})
