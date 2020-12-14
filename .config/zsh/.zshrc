# ZSHRC

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt autocd
autoload -U compinit
PROMPT='-> '

stty stop undef		# Disable ctrl-s to freeze terminal.

# ====== Completion
	zstyle ':completion:*:*:cdr:*:*' menu selection
	zmodload zsh/complist
	compinit
	_comp_options+=(globdots)

# ====== Recent Directories (cdr command)
	autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
	add-zsh-hook chpwd chpwd_recent_dirs

# ====== Use Alt-h and Alt-l to navigate directories
	cdUndoKey() {
	  popd
	  zle       reset-prompt
	}

	cdParentKey() {
	  pushd ..
	  zle       reset-prompt
	}

	zle -N  cdParentKey
	zle -N  cdUndoKey
	bindkey '^[h' cdParentKey
	bindkey '^[l' cdUndoKey

# ====== Use pacman to suggest a package when command not found
	command_not_found_handler() {
		local pkgs cmd="$1" files=()
		files=(${(f)"$(pacman -F --machinereadable -- "/usr/bin/${cmd}")"})
		if (( ${#files[@]} )); then
			printf '%s may be found in the following packages:\n' "$cmd"
			local res=() repo package version file
			for file in "$files[@]"; do
				res=("${(0)file}")
				repo="$res[1]"
				package="$res[2]"
				version="$res[3]"
				file="$res[4]"
				printf '  %s/%s %s: /%s\n' "$repo" "$package" "$version" "$file"
			done
		else
			printf 'zsh: command not found: %s\n' "$cmd"
			printf 'pacman: no files found: %s\n' "$cmd"
		fi
		return 127
	}

# ====== Edit line (Ctrl + E)
	autoload edit-command-line; zle -N edit-command-line
	bindkey '^e' edit-command-line

# ====== Aliases
	alias sdn="shutdown -h now"
	alias ls="ls -hN --color=auto --group-directories-first"
	alias p="sudo pacman" # quick shortcut to sudo pacman
	alias yt="youtube-dl --config-location ~/.config/youtube-dl/video.config" \
	alias yta="youtube-dl --config-location ~/.config/youtube-dl/audio.config" \
	alias ffmpeg="ffmpeg -hide_banner"
	command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

	notify-me() {
		mpv ~/.local/share/reminders-immediate.mp3 &>/dev/null;
		[[ -z "$1" ]] && notify-send -t 60000 -u critical "Job's done!" || \
		notify-send -t 60000 -u critical "$1"
		}

#   __     __
#  / _|___/ _|
# | ||_  / |_
# |  _/ /|  _|
# |_|/___|_|

# ====== Load
	source "/usr/share/fzf/completion.zsh"
	source "/usr/share/fzf/key-bindings.zsh"

# ====== Ignored paths
	_fzf_compgen_path() {
	  find . -type f \! \( \
		  -path '*/\.git/*' \
		  -o -path '*/\.wine/*' \
		  \) 2>/dev/null
	}

# ====== Ignored directories
	_fzf_compgen_dir() {
	  find . -type d \! \( \
		  -path '*/\.git/*' \
		  -o -path '*/\.wine/*' \
		  \) 2>/dev/null
	}

# ====== Git key bindings
	source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshxtra.zsh" # git widgets and more

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


#  ____ _                    _
# / ___| |__   ___ _ __ _ __(_) ___  ___
#| |   | '_ \ / _ \ '__| '__| |/ _ \/ __|
#| |___| | | |  __/ |  | |  | |  __/\__ \
# \____|_| |_|\___|_|  |_|  |_|\___||___/

# syntax highlighting
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
