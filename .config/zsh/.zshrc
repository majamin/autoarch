#  _______| |__  _ __ ___ 
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__ 
# /___|___/_| |_|_|  \___|
#                         

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

#   ___  ___ ___  ___ _ __ | |_(_) __ _| |___ 
#  / _ \/ __/ __|/ _ \ '_ \| __| |/ _` | / __|
# |  __/\__ \__ \  __/ | | | |_| | (_| | \__ \
#  \___||___/___/\___|_| |_|\__|_|\__,_|_|___/
                                            

setopt autocd
autoload -U compinit
autoload -U promptinit
promptinit
prompt fade blue black

zstyle ':completion:*' menu select
zmodload zsh/complist
stty stop undef		# Disable ctrl-s to freeze terminal.
compinit
_comp_options+=(globdots)

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# __   _(_)      _ __ ___   ___   __| | ___ 
# \ \ / / |_____| '_ ` _ \ / _ \ / _` |/ _ \
#  \ V /| |_____| | | | | | (_) | (_| |  __/
#   \_/ |_|     |_| |_| |_|\___/ \__,_|\___|

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

#   __     __ 
#  / _|___/ _|
# | ||_  / |_ 
# |  _/ /|  _|
# |_|/___|_|  

export FZF_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config/}/fzf"
export FZF_DEFAULT_COMMAND="''find . -type f -not -path '*/\.git/*'''"
export FZF_DEFAULT_OPTS="-m --height 40% --layout reverse --info inline --border --preview \"file {} | awk -F: '{print \$2}'\" --preview-window down:1:noborder"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

[ ! -d "$FZF_CONFIG" ] && \
	mkdir -p "$FZF_CONFIG"
[ ! -f "$FZF_CONFIG/completion.zsh" ] && \
	cp "/usr/share/fzf/completion.zsh" "$FZF_CONFIG/completion.zsh"
[ ! -f "$FZF_CONFIG/key-bindings.zsh" ] && \
	cp "/usr/share/fzf/key-bindings.zsh" "$FZF_CONFIG/key-bindings.zsh"

source "$FZF_CONFIG/completion.zsh"
source "$FZF_CONFIG/key-bindings.zsh"
source "$ZDOTDIR/git-fzf-zsh-functions.sh"
source "$ZDOTDIR/git-key-bindings.zsh"

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
alias yt="youtube-dl --add-metadata -i --restrict-filenames" \
alias yta="yt -x -f bestaudio/best --write-thumbnail" \
alias ffmpeg="ffmpeg -hide_banner"
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

#  _     _       _     _ _       _     _   _             
# | |__ (_) __ _| |__ | (_) __ _| |__ | |_(_)_ __   __ _ 
# | '_ \| |/ _` | '_ \| | |/ _` | '_ \| __| | '_ \ / _` |
# | | | | | (_| | | | | | | (_| | | | | |_| | | | | (_| |
# |_| |_|_|\__, |_| |_|_|_|\__, |_| |_|\__|_|_| |_|\__, |
#          |___/           |___/                   |___/ 

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
