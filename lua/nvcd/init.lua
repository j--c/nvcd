local is_valid_directory = function(path)
    return (vim.fn.isdirectory(path)) ~= 0
end

local prompt_for_new_wd = function(prompt, cncl_tkn)
    local input_opts = {
        prompt = prompt,
        default = vim.env.HOME,
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
    local new_wd = opts.new_wd
    if new_wd == nil then
        new_wd = prompt_for_new_wd('Change directory to: ', opts.cncl_tkn)
    end
    if (new_wd == opts.cncl_tkn) then
        print('Operation cancelled!')
    else
        local scrubbed_wd_path = scrub_path(new_wd)
        if is_valid_directory(scrubbed_wd_path) then
            vim.api.nvim_set_current_dir(scrubbed_wd_path)
            print('Directory changed to: ' .. '"' .. scrubbed_wd_path .. '"')
        else
            print('Invalid directory!')
        end
    end
end

M.swap_working_dir = function(opts)
    if M.prev_wd == nil then
        opts.cur_wd = vim.fn.getcwd()
        M.prev_wd = opts.cur_wd
    else
        opts.new_wd = M.prev_wd
        M.prev_wd = nil
    end
    M.change_working_dir_absolute(opts)
end

return M

--[[ 

local is_directory = function(path)
    return (vim.fn.isdirectory(path)) ~= 0
end

local get_os_slash = function()
    return package.config:sub(1, 1)
end

local path_begins_w_char = function(path, char)
    return (string.sub(path, 1, 1)) == char
end

local path_begins_w_path_separator = function(path)
    return path_begins_w_char(path, get_os_slash())
end

local path_begins_w_tilde = function(path)
    return path_begins_w_char(path, '~')
end

local replace_tilde_w_home_in_path = function(path)
    if path_begins_w_tilde(path) then
        return path:gsub('~', vim.env.HOME)
    else
        return path
    end
end

local get_new_wd_path = function(table)
    local new_wd_path = replace_tilde_w_home_in_path(table.new_wd_path)
    if table.relative then
        if path_begins_w_path_separator(new_wd_path) then
            new_wd_path = string.sub(new_wd_path, 2, string.len(new_wd_path))
        end
        new_wd_path = (table.cur_wd_path .. get_os_slash() .. new_wd_path)
    end
    return new_wd_path
end
M = {}

M.prompt_message = 'Change directory to: '
M.changed_message = 'Working directory set to: '
M.changed_back_message = 'Working directory set back to: '
M.invalid_directory_message = 'The path you set is not a directory.'

M.prev_wd = nil

M.has_previous_wd = function()
    if M.prev_wd ~= nil and is_directory(M.prev_wd) then
        return true
    else
        return false
    end
end

M.get_path_from_user = function()
    local user_path = ''
    if M.has_previous_wd() == false then
        user_path = vim.fn.input(M.prompt_message .. '> ')
    end
    return user_path
end

M.change_working_dir = function(table)

    print(path_begins_w_char('/home/jc/dev', '/'))
    if M.has_previous_wd() then
        print(M.changed_back_message .. M.prev_wd)
        vim.api.nvim_set_current_dir(M.prev_wd)
        M.prev_wd = nil
    else
        local new_wd_path = get_new_wd_path(table)
        if new_wd_path ~= nil and is_directory(new_wd_path) then
            vim.api.nvim_set_current_dir(new_wd_path)
            print(M.changed_message .. new_wd_path)
            M.prev_wd = table.cur_wd_path
        else
            print(M.invalid_directory_message)
        end
    end
end

local get_os_slash = function()
    return package.config:sub(1, 1)
end

local path_begins_w_char = function(path, char)
    return (string.sub(path, 1, 1)) == char
end

local path_begins_w_path_separator = function(path)
    return path_begins_w_char(path, get_os_slash())
end

local path_begins_w_tilde = function(path)
    return path_begins_w_char(path, '~')
end

local replace_ilde_w_home_in_path = function(path)
    return path:gsub('~', vim.env.HOME)
end
M.change_working_dir({})

]]--
