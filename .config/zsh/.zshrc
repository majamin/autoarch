#  _______| |__  _ __ ___ 
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__ 
# /___|___/_| |_|_|  \___|
#                         

HISTFILE="$ZDOTDIR/.zsh_history"

#        _                                        _     
#   ___ | |__        _ __ ___  _   _      _______| |__  
#  / _ \| '_ \ _____| '_ ` _ \| | | |____|_  / __| '_ \ 
# | (_) | | | |_____| | | | | | |_| |_____/ /\__ \ | | |
#  \___/|_| |_|     |_| |_| |_|\__, |    /___|___/_| |_|
#                              |___/                    

# Installs oh-my-zsh if it's not already installed
[ -z "$ZSH" ] && \
	export ZSH="$HOME/.config/oh-my-zsh" && \
	mkdir -p "$ZSH" && \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Here's the default theme (downloads and installs automatically)
[ -d "$ZSH_CUSTOM/themes" ] && [ ! -d "$ZSH_CUSTOM/themes/typewritten" ] && echo "Installing 'typewritten' zsh theme ..." && git clone https://github.com/reobin/typewritten.git "$ZSH_CUSTOM/themes/typewritten"
[ -d "$ZSH_CUSTOM/themes/typewritten" ] && ln -sf "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme" && ZSH_THEME="typewritten"
#ZSH_THEME="typewritten"

ZSH_THEME="robbyrussell"
plugins=(git vi-mode fzf)

source $ZSH/oh-my-zsh.sh



setopt autocd
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
bindkey -v
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


#   __ _| (_) __ _ ___  ___  ___ 
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
#                                

alias sdn="shutdown -h now"
alias cp="cp -iv" # allows verbose and interactive copying
alias mv="mv -iv" # allows verbose and intearctive moving
alias rm="rm -v" # allows verbose removal
alias mkdir="mkdir -pv" # allows verbose and recursive directory creation
alias p="sudo pacman" # quick shortcut to sudo pacman


#  _     _       _     _ _       _     _   _             
# | |__ (_) __ _| |__ | (_) __ _| |__ | |_(_)_ __   __ _ 
# | '_ \| |/ _` | '_ \| | |/ _` | '_ \| __| | '_ \ / _` |
# | | | | | (_| | | | | | | (_| | | | | |_| | | | | (_| |
# |_| |_|_|\__, |_| |_|_|_|\__, |_| |_|\__|_|_| |_|\__, |
#          |___/           |___/                   |___/ 

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
