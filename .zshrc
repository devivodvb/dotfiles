# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source "$HOME/.dotfiles/path.zsh"
source "$HOME/.dotfiles/aliases.zsh"

# Path to your oh-my-zsh installation.
export ZSH="/Users/$(whoami)/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(npm, git, history, git flow, github, brew, bundler, osx, textmate, sublime, tmux, tmuxinator, z, autojump, cp, symfony2, composer, laravel, zsh-autosuggestions, zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export DEFAULT_USER="$(whoami)"
export EDITOR=/usr/bin/vim

source "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time nvm rvm background_jobs ip ram battery)

precmd() { print "" }

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

performance() {
    curl -w "@curl-format.txt" -o /dev/null -s "$1"
}

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -s "$HOME/.autojump/etc/profile.d/autojump.sh" ]] && source "$HOME/.autojump/etc/profile.d/autojump.sh"

autoload -U compinit && compinit -u

for each in ~/.dotfiles.d/*.sh ; do source $each ; done
