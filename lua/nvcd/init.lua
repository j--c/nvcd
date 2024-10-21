local is_valid_directory = function(path)
    return (vim.fn.isdirectory(path)) ~= 0
end

local prompt_for_new_wd = function(prompt, cncl_tkn)
    local input_opts = {
        prompt = prompt,
        default = vim.env.HOME,
        completion = "dir" ,
        cancelreturn = cncl_tkn
    }
    return vim.fn.input(input_opts)
end

local scrub_path = function(path)
    local trimmed_path = path:gsub("%s+", "")
    local scrubbed_path = trimmed_path:gsub('~', vim.env.HOME)
    return scrubbed_path
end

M = {}

M.prev_wd = nil

M.change_working_dir_absolute = function(opts)
    local success = false
    local new_wd = opts.new_wd
    local cncl_tkn = 'ak;lakjfa;lu1nxno' -- random string to check if user cancelled change
    if new_wd == nil then
        new_wd = prompt_for_new_wd('Change directory to: ', cncl_tkn)
    end
    if (new_wd == cncl_tkn) then
        print('Operation cancelled!')
    else
        local scrubbed_wd_path = scrub_path(new_wd)
        if is_valid_directory(scrubbed_wd_path) then
            vim.api.nvim_set_current_dir(scrubbed_wd_path)
            print('  Success - Directory changed to: ' .. '"' .. scrubbed_wd_path .. '"')
            success = true
        else
            print('  Error - Invalid directory!')
        end
    end
    return success
end

M.swap_working_dir_absolute = function(opts)
    if M.prev_wd == nil then
        opts.cur_wd = vim.fn.getcwd()
        M.prev_wd = opts.cur_wd
    else
        opts.new_wd = M.prev_wd
        M.prev_wd = nil
    end
    local success = M.change_working_dir_absolute(opts)
    if success == false then
        M.prev_wd = nil
    end
end

return M
