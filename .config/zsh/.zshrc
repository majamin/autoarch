HISTFILE="$ZDOTDIR/.zsh_history"

#setopt autocd
#autoload -U compinit
#zstyle ':completion:*' menu select
#zmodload zsh/complist
#compinit
#_comp_options+=(globdots)
#bindkey -v
#export KEYTIMEOUT=1
#
## Change cursor shape for different vi modes.
#function zle-keymap-select {
#  if [[ ${KEYMAP} == vicmd ]] ||
#     [[ $1 = 'block' ]]; then
#    echo -ne '\e[1 q'
#  elif [[ ${KEYMAP} == main ]] ||
#       [[ ${KEYMAP} == viins ]] ||
#       [[ ${KEYMAP} = '' ]] ||
#       [[ $1 = 'beam' ]]; then
#    echo -ne '\e[5 q'
#  fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#



# OH MY ZSH time

# Here's the default theme (downloads and installs automatically)

[ -d "$ZSH_CUSTOM/themes" ] && [ ! -d "$ZSH_CUSTOM/themes/typewritten" ] && echo "Installing 'typewritten' zsh theme ..." && git clone https://github.com/reobin/typewritten.git "$ZSH_CUSTOM/themes/typewritten"

[ -d "$ZSH_CUSTOM/themes/typewritten" ] && ln -sf "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme" && ZSH_THEME="typewritten"

# Set default theme
ZSH_THEME="typewritten"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git fzf)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkd="mkdir -pv"
alias p="sudo pacman"
alias czhsrc="vim ${ZDOTDIR}/.zshrc"
alias czpro="vim ${ZDOTDIR}/.zprofile"
alias cxpro="vim ${XDG_CONFIG_HOME:-$HOME/.config}/xprofile"

# Load zsh-syntax-highlighting; should be last.

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
