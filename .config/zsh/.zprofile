#!/bin/sh

# zsh profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
export PATH="$PATH:$HOME/.local/src/youtube-dl-music"

# Default programs
export TERMINAL="st"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="brave"

# Host-specific environment variables
[ $(hostname) = "thinkarch" ] && export ONEDRIVE="$HOME/Maja"
[ $(hostname) = "arch17" ] && export ONEDRIVE="$HOME/OneDrive"
[ $(hostname) = "archlinux" ] && export ONEDRIVE="$HOME/OneDrive"

[ $(hostname) = "thinkarch" ] && export VIDEOS="$HOME/Videos"
[ $(hostname) = "arch17" ] && export VIDEOS="$HOME/Videos"
[ $(hostname) = "archlinux" ] && export VIDEOS="$HOME/Videos"

[ $(hostname) = "thinkarch" ] && export MUSIC="$HOME/Music"
[ $(hostname) = "arch17" ] && export MUSIC="$HOME/Music"
[ $(hostname) = "archlinux" ] && export MUSIC="$HOME/Music"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export MYDATA="$ONEDRIVE/Maja/_data"
export PASSWORD_STORE_DIR="$ONEDRIVE/Maja/password-store"
export SUDO_ASKPASS="$HOME/.local/bin/sudopass"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export R_ENVIRON_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Renviron"
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
#export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Start X if not already running
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx &> /dev/null

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null
