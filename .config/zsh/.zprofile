#!/bin/sh

# zsh profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

# Default programs
export TERMINAL="st"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="brave"

# Cloud-based
export ONEDRIVE="$HOME/Maja"

export VIDEOS="$HOME/Videos"
export MUSIC="$HOME/Music"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export MYDATA="$ONEDRIVE/_data"
export PASSWORD_STORE_DIR="$ONEDRIVE/password-store"
export LPASS_CLIPBOARD_COMMAND="xclip -selection clipboard -in -l 1"
export LPASS_CLIPBOARD_COMMAND="xsel -t 5000 --input --clipboard"
export SUDO_ASKPASS="$HOME/.local/bin/sudopass"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export R_ENVIRON_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Renviron"
export FZF_DEFAULT_OPTS="-m --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all --layout=reverse --inline-info"
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

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
#export AWT_TOOLKIT="MToolkit wmname LG3D"	#May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"

# Start X if not already running
[[ -n "$(tty)" && -z "$(pgrep -u $USER '\bXorg$')" ]] && exec startx &> /dev/null

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/ttymaps.kmap 2>/dev/null

