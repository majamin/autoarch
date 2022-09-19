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
PS1="${STY}%F{#459ED6}%n@%m%F{#F8BB46} (%1d)%F{#616161} [%j]%F{#EDE7D5} -> "

unsetopt BEEP
setopt globdots
bindkey '^e' edit-command-line # help: CTRL-E ..... edits the command line in vim
bindkey '^ ' forward-char
bindkey -s '^o' 'oneliner\n' # help: CTRL-O ..... opens oneliners
bindkey -s '^a' 'tmux attach-session || tmux\n' # help: CTRL-A ..... attaches to any available open tmux session
bindkey -s '^f' 'tmux-sessionizer\n' # help: CTRL-P ..... opens a project in tmux-sessionizer

alias help='find $ZDOTDIR -maxdepth 1 -type f -not -name "*hist*" | xargs grep -Porh "(?<=# help: ).+"'
alias pacman="sudo pacman"
alias sdn='sudo shutdown -h now' # help: sdn - executes shutdown -h now
alias reboot='sudo reboot' # help: reboot
alias yt="yt-dlp --config-location \"${XDG_CONFIG_HOME:-$HOME/.config}/youtube-dl/video.config\"" # help: yt - downloads videos using yt-dlp using config found in ~/.config/youtube-dl
alias yta="yt-dlp --config-location \"${XDG_CONFIG_HOME:-$HOME/.config}/youtube-dl/audio.config\"" # help: yta - downloads audio only of videos using yt-dlp using config found in ~/.config/youtube-dl
alias oneliner='grep "^(\*)" ~/Maja/Projects/oneliners.txt/oneliners.txt | fzf -e | grep -oP "(?<=: \`).*(?=\`$)"' # oneliner (alias) - greps oneliners.txt and selects a command
alias ls="ls -hN --color=auto --group-directories-first" # help: ls - ls has color and groups directories first
alias l="ls" # help: l - just ls
alias ll="ls -SlA1" # help: ll - ls -SlA1
alias la="ls -SlaA1" # help: l - ls -SlaA1
alias gsu="git status -uno" # help: git status -uno (don't show untracked)

proj() {
	PROJDIR=$(\
		fd . "$HOME/Maja/Projects" --max-depth=2 --type=d --changed-within=3months --print0 | \
		xargs -0 stat --format '%Y,%n' | \
		sort -nr | \
		cut -d, -f2 | \
		fzf
	)
	cd "$PROJDIR"
	PROJFILES=$(find "$PROJDIR" -maxdepth 2 -type f -type f \! \( -path '*/\.git/*' \) -printf "%T@ %p\n" | sort -n | cut -f2- -d" " | xargs file 2>/dev/null | grep "text" | cut -f1 -d":" | tail -n5 | tac)
	if [[ -n "$PROJFILES" ]]; then
		if [[ -e "$PROJDIR/Session.vim" ]]; then
			vim -S "$PROJDIR/Session.vim"
		else
			echo "$PROJFILES" | xargs vim
		fi
	else
		printf "Directory is now %s, but no text files here.\n" "$PROJDIR" && ls
	fi
}

. "$ZDOTDIR/vimin.zsh" # vim movements and cursor ~/.config/zsh/vimin.zsh
. "/usr/share/fzf/completion.zsh"
. "/usr/share/fzf/key-bindings.zsh"
  # help: CTRL-T ..... Paste the selected file path(s) into the command line
  # help: CTRL-R ..... Search command history
  # help: ALT-C  ..... Change to the selected directory, default command is `fd`
. "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
#. "/usr/share/LS_COLORS/dircolors.sh"
. "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "$ZDOTDIR/myextensions.zsh" # fzf and more ~/.config/zsh/myextensions.zsh
. "$ZDOTDIR/colors.zsh" # colors  ~/.config/zsh/colors.zsh

. "/usr/share/nvm/init-nvm.sh"
[[ -e "npm" ]] && npm config set prefix "$NPM_PACKAGES"

#eval `dircolors $ZDOTDIR/mydircolors`

ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue
