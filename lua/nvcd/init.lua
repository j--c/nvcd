M = {}

M._stack = {}

M.change_working_dir = function(new_dir)
    M._stack.prev_wd = vim.fn['getcwd']()
    vim.api.nvim_set_current_dir(new_dir)
end

M.load_nvim_config = function()
    if not M._stack.prev_wd then
        M.change_working_dir('~/.config/nvim')
        vim.cmd.Ex(vim.fn['getcwd']())
    else
        M.change_working_dir(M._stack.prev_wd)
        M._stack.prev_wd = nil
        vim.cmd('pwd')
    end
end

return M
