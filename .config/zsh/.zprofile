#!/bin/sh

# zsh profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# Default programs
export TERMINAL="st"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="brave"


[ $(hostname) = "minarch" ] && export ONEDRIVE="/mnt/BarraCuda/OneDrive"
[ $(hostname) = "arch17" ] && export ONEDRIVE="~/OneDrive"

#case "$HOST" in
#	"minarch" )
#		export ONEDRIVE="/mnt/BarraCuda/OneDrive" ;;
#	"arch17" )
#		export ONEDRIVE="~/OneDrive" ;;
#esac

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export MYDATA="$ONEDRIVE/Maja/_data"
export PASSWORD_STORE_DIR="$HOME/OneDrive/password-store"
export SUDO_ASKPASS="$HOME/.local/bin/sudopass"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export R_ENVIRON_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Renviron"
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
#export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Start X if not already running
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null
