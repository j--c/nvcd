# nvcd
Simple plugin to help you more easily change the Neovim working directory.

## Getting Started

### Required Dependencies 
None

### Installation 

Using packer.nvim:
```
    use ('j--c/nvcd')
```
Using vim-plug:
```
    Plug 'j--c/nvcd'
```
Using dein:
```
    call dein#add('nvim-lua/plenary.nvim')
```

### Usage 
Using Lua:<br>

#### swap_working_dir_absolute
Swap between your current directory and a new directory you specify. Your current directory will be remembered, and will get swapped back the next time swap_working_dir is called. <br>

You can specify a new directory in the call.
```
    require 'nvcd'.swap_working_dir_absolute({
        cncl_tkn = '12093uajn',
        new_wd = '~/.config/nvim'
    })
```

If you don't specify the new directory in the function call, nvcd will prompt you. 
```
    require 'nvcd'.swap_working_dir_absolute({
        cncl_tkn = '12093uajn',
        new_wd = nil
    })
```

#### change_working_dir_absolute
Change the neovim working directory.<br>

You can specify a directory in the call.
```
    require 'nvcd'.swap_working_dir_absolute({
        cncl_tkn = '12093uajn',
        new_wd = '~/.config/nvim'
    })
```

If you don't specify the new directory in the function call, nvcd will prompt you. 
```
    require 'nvcd'.swap_working_dir_absolute({
        cncl_tkn = '12093uajn',
        new_wd = nil
    })
```
