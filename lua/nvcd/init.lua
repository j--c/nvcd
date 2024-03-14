M = {}

M.last_wd = nil


M.change_working_dir = function(new_dir)
    local cur_wd = vim.fn['getcwd']()
    local wd_msg = 'working dir set to: '

    if M.last_wd == nil then
        -- no last working dir specified 
        if new_dir ~= nil then
            -- new working dir specified 
            M.last_wd = cur_wd
            vim.api.nvim_set_current_dir(new_dir)
            print(wd_msg .. new_dir)
        else
            -- no new working dir specified 
            vim.api.nvim_set_current_dir(cur_wd)
            print(wd_msg .. cur_wd)
        end
    else
        -- last working dir specified 
        vim.api.nvim_set_current_dir(M.last_wd)
        print(wd_msg .. M.last_wd)
        M.last_wd = nil
    end
end


return M
