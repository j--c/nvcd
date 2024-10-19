vim.api.nvim_create_user_command(
    "SwapNvimConfig",
    function()
        require 'nvcd'.swap_working_dir({
            cncl_tkn = '12093uajn',
            new_wd = '~/.config/nvim'
        })
    end,
    {}
)

vim.api.nvim_create_user_command(
    "SwapNvimCustom",
    function()
        require 'nvcd'.swap_working_dir({
            cncl_tkn = '12093uajn',
            new_wd = nil
        })
    end,
    {}
)
