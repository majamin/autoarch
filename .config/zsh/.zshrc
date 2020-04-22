HISTFILE="$ZDOTDIR/.zsh_history"

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
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
