# My Nvim config 

## Introduction

This config is my current one used with **NVChad 2.5**: [nvchad.com](https://nvchad.com/). NvChad is not mendatory but it add all the basic plugin and has a good interface.

To install it (not tested):
```bash
git clone https://github.com/NvChad/starter ~/.config/nvim
cd ~/.config/nvim/
rm -rf lua/ && mkdir lua
cd ./lua
git clone https://github.com/auma-odoo/nvim-config.git && nvim
```

## Plugins

You have two plugins file, one for UI plugins and one for the other plugins.

You can update the plugin with `:Lazy` and add LSP, formatter, linter with `:Mason`. I added some in the [mason.lua](configs\mason.lua) and in [treesitter.lua](configs/treesitter.lua) file that you can change and remove locally.

If you don't use [kitty](https://sw.kovidgoyal.net/kitty/), you can remove `kitty-scrollback.nvim`. For more info on this plugin: [mikesmithgh/kitty-scrollback.nvim](https://github.com/mikesmithgh/kitty-scrollback.nvim).
I also added `obsidian.nvim` for my local wiki. You can remove it if you don't use it. For more info: [epwalsh/obsidian.nvim](https://github.com/epwalsh/obsidian.nvim).

## Debugging

I added a custom debugger for Odoo. The config is in [dapconfig.lua](configs/dapconfig.lua) and you can find the custom config for the UI in [dapuiconfig.lua](configs/dapuiconfig.lua). To access it, you can use the vim command `:Dap...`, or the custom mappings in `<leader>d` (by default, `<leader>` is `space`). 

## Mappings

All the mapping use the default mapping in vim (only in NvChad 2.5 and more): `vim.keymap.set`.

I added `Ctrl+C`, `Ctrl+V` and `Ctrl+X` in the mappings, all the debugging mappings and some more. You can find everything in [mappings.lua](mappings.lua) file.
