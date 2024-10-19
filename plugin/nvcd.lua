vim.api.nvim_create_user_command(
    "SwapCwdNvimConfig",
    function()
        require 'nvcd'.swap_working_dir_absolute({
            new_wd = '~/.config/nvim'
        })
    end,
    {}
)

vim.api.nvim_create_user_command(
    "SwapCwdCustom",
    function()
        require 'nvcd'.swap_working_dir_absolute({
            new_wd = nil
        })
    end,
    {}
)

vim.api.nvim_create_user_command(
    "ChangeCwdCustom",
    function()
        require 'nvcd'.swap_working_dir_absolute({
            new_wd = nil
        })
    end,
    {}
)
