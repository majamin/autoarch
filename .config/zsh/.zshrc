HISTFILE="$ZDOTDIR/.history"
HISTSIZE=10000
SAVEHIST=10000

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' cache-path "$ZDOTDIR/cache"
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-cache on
zstyle :compinstall filename '~/.config/zsh/.zshrc'

autoload -Uz compinit
autoload edit-command-line; zle -N edit-command-line

compinit

PROMPT="${STY}-> "
setopt globdots
bindkey '^e' edit-command-line
bindkey '^ ' autosuggest-execute

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

alias pacman="sudo pacman"
alias ls="ls -hN --color=auto --group-directories-first"
alias yt="youtube-dl --config-location \"${XDG_CONFIG_HOME:-$HOME/.config}/youtube-dl/video.config\""
alias yta="youtube-dl --config-location \"${XDG_CONFIG_HOME:-$HOME/.config}/youtube-dl/audio.config\""

. "/usr/share/fzf/completion.zsh"
. "/usr/share/fzf/key-bindings.zsh"
. "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "/usr/share/LS_COLORS/dircolors.sh"
. "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
