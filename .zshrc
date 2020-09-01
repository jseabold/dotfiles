# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python common-aliases git-extras jsontools urltools tmux)
export ZSH_TMUX_AUTOSTART=true

# User configuration


source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# hit v to edit command line in vim
# http://dougblack.io/words/zsh-vi-mode.html

# Key Bindings
# Lookup in /etc/termcap or /etc/terminfo else, you can get the right keycode
# by typing ^v and then type the key or key combination you want to use.
# "man zshzle" for the list of available actionss

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^f' forward-word            # C-Right
bindkey '^b' backward-word           # C-Left
bindkey '^A' beginning-of-line       # Home
bindkey '^E' end-of-line             # End

export KEYTIMEOUT=1

function source_file {
    if [[ -a $HOME/$1 ]]; then
        source $HOME/$1
    fi
}

source_file .awskeys
source_file .aliases
source_file .functions
source_file .exports
source_file .workrc
source_file .git_key
source_file .go
source_file .dockerfunc
source_file .localpaths
source_file .apikeys
source_file .work

# THIS will hide the user information in the prompt
export DEFAULT_USER=$USER
PROMPT='%{%f%b%k%}$(build_prompt)
| $ '

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

if [[ "$PAGER" = less ]]
then
    # start blink
    export LESS_TERMCAP_mb=$'\e[1;32m'
    # start bold
    export LESS_TERMCAP_md=$'\e[1;32m'
    # turn off bold, blink, and underline
    export LESS_TERMCAP_me=$'\e[0m'
    # stop standout
    export LESS_TERMCAP_se=$'\e[0m'
    # start standout
    export LESS_TERMCAP_so=$'\e[01;33m'
    # stop underline
    export LESS_TERMCAP_ue=$'\e[0m'
    # start underline
    export LESS_TERMCAP_us=$'\e[1;4;31m'
fi

bindkey -v
