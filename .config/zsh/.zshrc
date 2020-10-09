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
prompt off

zstyle ':completion:*' menu select
zmodload zsh/complist
stty stop undef		# Disable ctrl-s to freeze terminal.
compinit
_comp_options+=(globdots)

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#   __     __
#  / _|___/ _|
# | ||_  / |_
# |  _/ /|  _|
# |_|/___|_|

export FZF_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config/}/fzf"
export FZF_DEFAULT_COMMAND="''find . -type f -not -path '*/\.git/*'''"
export FZF_DEFAULT_OPTS="-m --height 40% --layout reverse --info inline --border --preview \"file {} | awk -F: '{print \$2}'\" --preview-window down:1:noborder"
#export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

[ ! -d "$FZF_CONFIG" ] && \
	mkdir -p "$FZF_CONFIG"
[ ! -f "$FZF_CONFIG/completion.zsh" ] && \
	cp "/usr/share/fzf/completion.zsh" "$FZF_CONFIG/completion.zsh"
[ ! -f "$FZF_CONFIG/key-bindings.zsh" ] && \
	cp "/usr/share/fzf/key-bindings.zsh" "$FZF_CONFIG/key-bindings.zsh"

source "$FZF_CONFIG/completion.zsh"
source "$FZF_CONFIG/key-bindings.zsh"
source "$ZDOTDIR/functions"
#source "$ZDOTDIR/git-key-bindings.zsh"

#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
#

alias sdn="shutdown -h now"
alias ls="ls -hN --color=auto --group-directories-first"
alias cp="cp -iv" # allows verbose and interactive copying
alias mv="mv -iv" # allows verbose and intearctive moving
alias rm="rm -v" # allows verbose removal
alias mkdir="mkdir -pv" # allows verbose and recursive directory creation
alias p="sudo pacman" # quick shortcut to sudo pacman
alias yt="youtube-dl --config-location ~/.config/youtube-dl/video.config" \
alias yta="youtube-dl --config-location ~/.config/youtube-dl/audio.config" \
alias ffmpeg="ffmpeg -hide_banner"
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

# Pywal: terminal colours
(cat ~/.cache/wal/sequences &)

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
