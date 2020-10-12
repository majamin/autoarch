# ZSHRC

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

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

#   __     __
#  / _|___/ _|
# | ||_  / |_
# |  _/ /|  _|
# |_|/___|_|

source "/usr/share/fzf/completion.zsh"
source "/usr/share/fzf/key-bindings.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshxtra.zsh" # git widgets and more

# ignored paths
_fzf_compgen_path() {
  find . -type f \! \( -path '*/\.wine/*' -o -path '*/\.git/*' \) 2>/dev/null
}

# ignored directories
_fzf_compgen_dir() {
  find . -type d \! \( -path '*/\.wine/*' -o -path '*/\.git/*' \) 2>/dev/null
}

zle -N fzf-gf-widget
bindkey '^g^f' fzf-gf-widget

zle -N fzf-gb-widget
bindkey '^g^b' fzf-gb-widget

zle -N fzf-gt-widget
bindkey '^g^t' fzf-gt-widget

zle -N fzf-gh-widget
bindkey '^g^h' fzf-gh-widget

zle -N fzf-gr-widget
bindkey '^g^r' fzf-gr-widget


#   ____      _
# / ___|___ | | ___  _ __ ___
#| |   / _ \| |/ _ \| '__/ __|
#| |__| (_) | | (_) | |  \__ \
# \____\___/|_|\___/|_|  |___/

# pywal
(cat ~/.cache/wal/sequences &)

# syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
