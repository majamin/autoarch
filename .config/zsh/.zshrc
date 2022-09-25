HISTFILE="$ZDOTDIR/.history"
HISTSIZE=20000
SAVEHIST=20000

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' cache-path "$ZDOTDIR/cache"
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*:cd:*' ignore-parents parent pwd
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

unsetopt BEEP
setopt globdots

autoload -Uz compinit && compinit
autoload edit-command-line; zle -N edit-command-line
autoload -U colors && colors
PS1="%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}%m %F{#616161}%~ {%j} %{$reset_color%}%% "

# ------------ KEYBINDINGS AND MODES -----------------------------------------
bindkey '^e' edit-command-line # help: CTRL-E ..... edits the command line in vim
bindkey '^l' forward-char
bindkey -s '^o' 'oneliner\n' # help: CTRL-O ..... opens oneliners
bindkey -s '^a' 'tmux attach-session || tmux\n' # help: CTRL-A ..... attaches to any available open tmux session
bindkey -s '^f' 'tmux-sessionizer\n' # help: CTRL-P ..... opens a project in tmux-sessionizer
source "$ZDOTDIR/vimin.zsh" # help: vim movements and cursor ~/.config/zsh/vimin.zsh
[[ -f "/usr/share/nvm/init-nvm.sh" ]] && . "/usr/share/nvm/init-nvm.sh" || echo "nvm executable not present"

# ------------ ALIASES -------------------------------------------------------
alias help='find $ZDOTDIR -maxdepth 1 -type f -not -name "*hist*" | xargs grep -Porh "(?<=# help: ).+"'
alias pacman="sudo pacman"
alias sdn='sudo shutdown -h now' # help: sdn - executes shutdown -h now
alias reboot='sudo reboot' # help: reboot
alias yt="yt-dlp --config-location \"${XDG_CONFIG_HOME:-$HOME/.config}/youtube-dl/video.config\"" # help: yt - downloads videos using yt-dlp using config found in ~/.config/youtube-dl
alias yta="yt-dlp --config-location \"${XDG_CONFIG_HOME:-$HOME/.config}/youtube-dl/audio.config\"" # help: yta - downloads audio only of videos using yt-dlp using config found in ~/.config/youtube-dl
alias oneliner='grep "^(\*)" ~/Maja/Projects/oneliners.txt/oneliners.txt | fzf -e | grep -oP "(?<=: \`).*(?=\`$)"' # oneliner (alias) - greps oneliners.txt and selects a command
alias ls="ls -hN --color=always --group-directories-first" # help: ls - ls has color and groups directories first
alias l="ls" # help: `l` - alias for `ls`
alias ll="ls -SlA1" # help: `ll` is an alias for `ls -SlA1`
alias la="ls -SlaA1" # help: `l` is an alias for `ls -SlaA1`
alias gsu="git status -uno" # help: `gsu` is an alias for `git status -uno`

# ------------ BEHAVIOUR -----------------------------------------------------
source "/usr/share/fzf/completion.zsh"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/myextensions.zsh" # fzf and more ~/.config/zsh/myextensions.zsh
source "/usr/share/fzf/key-bindings.zsh"
# help: CTRL-T ..... Paste the selected file path(s) into the command line
# help: CTRL-R ..... Search command history
# help: ALT-C  ..... Change to the selected directory, default command is `fd`

# ------------ COLORS --------------------------------------------------------
source "$ZDOTDIR/pywal.zsh" # use pywal ~/.config/zsh/pywal.zsh
source "$ZDOTDIR/COLORS" # generated by vivid
zstyle ':completion:*' list-colors "${LS_COLORS}"
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
