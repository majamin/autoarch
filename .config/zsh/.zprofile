#!/bin/sh

# Put .local/bin and all subdirectories in $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

export TERMINAL="st"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="brave"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ONEDRIVE="$HOME/Maja"
export MYDATA="$ONEDRIVE/_data"
export VIDEOS="$HOME/Videos"
export MUSIC="$HOME/Music"
export SCREENSHOT_DIR="${ONEDRIVE:-$HOME}/Images/Screenshots"
export PASSWORD_STORE_DIR="$ONEDRIVE/password-store"
export SUDO_ASKPASS="$HOME/.local/bin/sudopass"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export R_ENVIRON_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Renviron"
export TEXMFHOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/gem/ruby/3.0.0/bin"

export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# Start X if not already running
[[ -n "$(tty)" && -z "$(pgrep -u $USER '\bXorg$')" ]] && exec startx

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/ttymaps.kmap 2>/dev/null
