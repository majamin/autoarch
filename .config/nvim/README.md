# README

Hi! This is a helpful guide on how to use this config setup for Neovim.

I primarily use this setup for web development, so many plugins reflect that.

It is completely extensible to any other type of development, but you're on your own for that.

This Neovim config was inspired by [[https://github.com/craftzdog/dotfiles-public/tree/master/.config/nvim]]

The majority of the functionality is helped by Telescope and Neovim LSP.
Defx is used for file browsing,

## How to use

Easiest way is to grab my entire dotfile repo (`git clone "https://github.com/majamin/autoarch"`) and copy the corresponding folder where it needs to go.

*On Linux*: Run `echo $XDG_CONFIG_HOME`.
Copy the entire nvim directory to that folder (be mindful of any existing `nvim` folder and make backups)

*On Windows* and *Mac*: these configs are untested. Sorry!

## First run

Run `nvim` then `:PlugInstall` to install the plugins.

I like light themes. If you want to go dark, simply change `background=light` to `background=dark` in `init.vim` (the colorscheme adjusts everything to suit).

Run `:checkhealth` to understand what Neovim is missing (normal for first-time Neovim use).
The majority of the fixes here include installing certain dependencies (read the messages there carefully).

## Tips

Jumping into someone else's configs can be a nightmare. For my configs, some tips:

  - `F3` and `F4` are spell toggle for standard and basic English (change `spelllang` in `init.vim`)
  - `Tab` and `Shift-Tab` cycles through buffers
  - `<C-q>` closes windows, `<C-b>` closes buffers
  - `Ctrl-h`, `-j`, `-k`, and `-l` moves between windows
  - Run `fk` to get a keybindings menu
  - Run `fh` to get a fuzzy help menu (or `:Telescope help_tags`)
  - Run `ff` to search and open files
  - Run `fw` to browse files (`hjkl` moves around, `q` quits, `Enter` opens)


