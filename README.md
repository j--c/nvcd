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

<br>

#### Swap the current Neovim working directory

Swap between your current directory and a new directory you specify. Your current directory will be remembered, and will get swapped back the next time swap_working_dir is called. <br>

<br>

You can specify a new directory in the call.
```
    require 'nvcd'.swap_working_dir_absolute({
        new_wd = '~/.config/nvim'
    })
```

<br>

If you don't specify the new directory in the function call, nvcd will prompt you. 
```
    require 'nvcd'.swap_working_dir_absolute({
        new_wd = nil
    })
```

<br>

You can also use this command.
```
    :SwapCwdCustom
```

<br>

I also created a command to swap the working directory form my neovim config.
```
    :SwapCwdNvimConfig
```


#### Change the current Neovim working directory

Change the current Neovim working directory.  The current directory is not remembered.<br>

<br>

You can specify a directory in the call.
```
    require 'nvcd'.swap_working_dir_absolute({
        new_wd = '~/.config/nvim'
    })
```

<br>

If you don't specify the new directory in the function call, nvcd will prompt you. 
```
    require 'nvcd'.swap_working_dir_absolute({
        new_wd = nil
    })
```

<br>

You can also use this command.
```
    :SwapCwdCustom
```
