HISTFILE="$ZDOTDIR/.history"
HISTSIZE=20000
SAVEHIST=20000

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' cache-path "$ZDOTDIR/cache"
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-cache on
zstyle ':completion:*:*:git:*' script ~/.config/zsh/git-completion.bash
zstyle :compinstall filename '~/.config/zsh/.zshrc'
fpath=(~/.config/zsh $fpath)

autoload -Uz compinit && compinit
autoload edit-command-line; zle -N edit-command-line
autoload -U colors && colors

#if [ -f $HOME/.cache/wal/sequences ]; then
#	(cat ~/.cache/wal/sequences &)
#else
#	wal --theme sexy-kasugano &
#fi

PS1="${STY}%F{210}%n@%m%F{190} (%1d)%F{reset} -> "

unsetopt BEEP
setopt globdots
bindkey '^e' edit-command-line
bindkey '^ ' forward-char
bindkey -s '^o' 'oneliner\n'

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
alias oneliner='print -z $(grep "^(\*)" ~/Maja/Projects/oneliners.txt/oneliners.txt | fzf -e | grep -oP "(?<=: \`).*(?=\`$)")'

. "/usr/share/fzf/completion.zsh"
. "/usr/share/fzf/key-bindings.zsh"
. "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "/usr/share/LS_COLORS/dircolors.sh"
. "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-messages --smart-case --glob '!{.git,node_modules,build,.idea}'"
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_DEFAULT_OPTS='
--ansi
--height 50%
--color fg:15,fg+:15,bg+:239,hl+:108
--color info:2,prompt:109,spinner:2,pointer:168,marker:168
'

# change directory to chosen file
cdf () {
	thefile=$(rg -j0 --hidden --no-messages --smart-case --files -g '!{.git,node_modules,build,.idea,.npm,.cache,.bundle,cache}' . | fzf)
	[[ -z $thefile ]] && return 1
	printf '%s\n\e[1;34m%-6s\e[m\n' "You are now in the same directory as" "$thefile"
	cd $(dirname $thefile)
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
