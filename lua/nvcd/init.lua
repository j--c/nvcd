--[[ BEGIN LOCAL FUNCTIONS ]]--

local is_directory = function(path)
    local is_dir = vim.fn.isdirectory(path)
    if is_dir ~= 0 then
        return true
    else
        return false
    end
end

local get_os_slash = function()
    return package.config:sub(1, 1)
end

local path_begins_w_char = function(path, char)
    local first_char = string.sub(path, 1, 1)
    if first_char == char then
        return true
    else
        return false
    end
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

--[[ END LOCAL FUNCTIONS ]]--

M = {}

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

M.change_working_dir = function(table)
    if M.has_previous_wd() then
        print(M.changed_back_message .. M.prev_wd)
        vim.api.nvim_set_current_dir(M.prev_wd)
        M.prev_wd = nil
    else
        local new_wd_path = get_new_wd_path(table)
        print(new_wd_path)
        if new_wd_path ~= nil and is_directory(new_wd_path) then
            vim.api.nvim_set_current_dir(new_wd_path)
            print(M.changed_message .. new_wd_path)
            M.prev_wd = table.cur_wd_path
        else
            print(M.invalid_directory_message)
        end
    end
end


return M
