# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hCF --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# install libnotify-bin for this one
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# use kde
alias alert='kdialog --passivepopup "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'

# let make always run in parallel
cpu_count=`nproc`
alias make='make -j $cpu_count'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#export PYTHONPATH=/home/skipper/src/nbconvert/

# adding R path for rpy installation
if [ -d /usr/local/lib64/R/bin ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64/R/bin
elif [ -d ~/.local/lib/R/bin ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib/R/bin:~/.local/lib/R/lib64/R/lib/
    export PATH=$PATH:~/.local/lib/R/bin
fi


# some library code is installed here
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

if [ -d /usr/local/stata11 ]; then
    export PATH=$PATH:/usr/local/stata11:~/src/.dropbox-dist
fi

if [ -d /opt/mongo ]; then
    export PATH=$PATH:/opt/mongo/bin
fi

# postgres

if [ -d /usr/lib/postgresql/9.3/bin ]; then
    export PATH=$PATH:/usr/lib/postgresql/9.3/bin
fi

#export PATH=/home/skipper/src/julia:$PATH
# export manually installed texlive
#export PATH=/usr/local/texlive/2011/bin/x86_64-linux:$PATH

#

# set python startup
export PYTHONSTARTUP=/home/skipper/.pystartup

# set default editor
export EDITOR="gvim -f"

#NLTK Stuff
#export PROVER9HOME="/home/skipper/src/LADR-2009-11A/bin"
#export MALTPARSERHOME="/home/skipper/src/malt-1.2"
#export MEGAHOME="/home/skipper/src/megam_0.92"

export TESSDATA_PREFIX=/home/skipper/src/tesseract-ocr

# multimarkdown stuff, note that this overwrites mmd from mtools
export PATH=/home/skipper/src/peg-multimarkdown/scripts:$PATH

# start doing sensible installations in .local
export PATH=$PATH:/home/skipper/.local/bin

alias pyserv='python -m SimpleHTTPServer 8888'
alias pyftp='python -m pyftpdlib -w'
alias scanftp='sudo python ~/src/scripts/ftpscan_server.py'

#pushd to directory for python package
function pushdp {
pushd `python -c "import os; import $1; print (os.path.dirname($1.__file__))"`
}

function rmpy {
    if [ -z "$1" ]; then 
        echo "Aren't you glad I didn't delete everything?";
    else
        sudo rm -rf /usr/local/lib/python2.7/dist-packages/$1*
    fi
}

function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return 
    echo "("${ref#refs/heads/}")"
}

PS1="[\w] \$(parse_git_branch)\n|\# \$ "
#PS2="\[\033[31;40m\]\333\262\261\260\[\033[0m\]>"
PS2="\[\033[1;33m...\[\033[0m\]"
#PS1="[\w]`__git_ps1`\n|\# \$ "

export DISCO_HOME="/home/skipper/src/disco"

# aliases
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../;'
alias c='clear'
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias apt-get="sudo apt-get"
## pass options to free ## 
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
## get GPU ram on desktop / laptop## 
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias df='df -H'
alias du='du -ch'
alias cpProgress="rsync --progress -ravz"
alias edit=gvim

export WAFDIR=/home/skipper/src/waf-1.7.9

# grunt-cli tab auto-completion
# eval "$(grunt --completion=bash)"

# Search the current directory and all parent directories for a gruntfile.
function _grunt_gruntfile() {
  local curpath="$PWD"
  while [[ "$curpath" ]]; do
    for gruntfile in "$curpath/"{G,g}runtfile.{js,coffee}; do
      if [[ -e "$gruntfile" ]]; then
        echo "$gruntfile"
        return
      fi
    done                                                                         
    curpath="${curpath%/*}"                                                      
  done                                                                           
  return 1                                                                       
}                                                                                
                                                                                 
# Enable bash autocompletion.                                                    
function _grunt_completions() {                                                  
  # The currently-being-completed word.                                          
  local cur="${COMP_WORDS[COMP_CWORD]}"                                          
  # The current gruntfile, if it exists.                                         
  local gruntfile="$(_grunt_gruntfile)"                                          
  # The current grunt version, available tasks, options, etc.                    
  local gruntinfo="$(grunt --version --verbose 2>/dev/null)"                     
  # Options and tasks.                                                           
  local opts="$(echo "$gruntinfo" | awk '/Available options: / {$1=$2=""; print $0}')"
  local compls="$(echo "$gruntinfo" | awk '/Available tasks: / {$1=$2=""; print $0}')"
  # Only add -- or - options if the user has started typing -
  [[ "$cur" == -* ]] && compls="$compls $opts"
  # Tell complete what stuff to show.
  COMPREPLY=($(compgen -W "$compls" -- "$cur"))
}

complete -o default -F _grunt_completions grunt

export CHROME_BIN=chromium-browser

# for stata
export PDFVIEWER=okular

# for R
export R_HISTFILE=~/.Rhistory
export R_HISTSIZE='1500'
# get rid of obnoxious save confirmation
alias R='R --no-save'

# for Rpy2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/R/lib

if [ -d ~/src/scripts/bin/ ]; then
    export PATH=$PATH:~/src/scripts/bin/
fi

alias ubuntuone='ubuntuone-control-panel-qt --with-icon &'

# UK Keyboard remappings
# AltGr -> Alt
xmodmap -e "clear mod5"
xmodmap -e "keycode 108 = Alt_L"

# Bashmarks
if [ -d ~/src/bashmarks/ ]; then
    source ~/src/bashmarks/bashmarks.sh
fi

# last time anacron weekly was run
function lastanacron {
    echo "hourly"
    stat --format "%y" /var/spool/anacron/cron.hourly
    echo "daily"
    stat --format "%y" /var/spool/anacron/cron.daily
    echo "weekly"
    stat --format "%y" /var/spool/anacron/cron.weekly
}

alias version='lsb_release -a'

if [ -d ~/.anacron ]; then
    function lastuseranacron {
    echo "daily"
    stat --format "%y" ~/.anacron/cron.daily
    }
fi

function findends {
    echo
    find . -type f -name *.$1
}

alias nosefast="nosetests -a '!slow'"

export X12PATH="/home/skipper/src/x12arima"
export X13PATH="/home/skipper/src/x13arima"

function wakeremote {
    file="/home/skipper/.macaddress"
    macaddress=$(cat $file)
    wakeonlan -i 192.168.1.3 $macaddress
}

# virtualenvwrapper
source ~/.local/bin/virtualenvwrapper.sh
export WORKON_HOME=/home/skipper/.virtualenvs

# building numpy/scipy reliably
export LAPACK=~/.local/lib/libopenblas.a
export BLAS=~/.local/lib/libopenblas.a
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib

# work stuff
export DP=/home/skipper/datapad
export DP_WEB=$DP/datapad-web
export DP_BADGER=$DP/badger-skipper
export DP_BURROW=$DP/burrow
export SELENIUM_ROOT=$DP/code/selenium

export DB_NAME='test'

export DATAPAD_ENV=/home/skipper/.virtualenvs/datapad

source $HOME/src/scripts/run_stack.sh
source $HOME/.postgres
source $HOME/.aws

export DATAPAD_API_TOKEN="eyJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6IjYyODEwZmJjZDAwMzRmNGRiYmQ2MzQxZjg4YTc0MjQyIn0.qGtLbkxPT2tu3kcF89x4BoXtoPz236XR_hIECfizQxI"

# JAVA/IDE stuff
export JAVA_HOME=~/src/jdk1.8.0_20/
export GROOVY_HOME=~/src/groovy-2.3.6
if [ -d ~/src/idea-IC-135.1230 ]; then
    export PATH=$PATH:~/src/idea-IC-135.1230/bin
fi
if [ -d ~/src/groovy-2.3.6 ]; then
    export PATH=$PATH:~/src/groovy-2.3.6/bin
fi

# https://gist.github.com/clneagu/7990272
check_venv() {
    if [ -e .venv ]; then
        env=`cat .venv`
        if [ "$env" != "${VIRTUAL_ENV##/}" ]; then
            echo "Found .venv in directory. Calling: workon ${env}"
            workon $env
        fi
    fi

}

venv_cd() {
    builtin cd "$@" && check_venv
}

check_venv
alias cd="venv_cd"

function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ne `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
   done
}

function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
   done
}

export SCALA_HOME=~/.local/share/scala
export PATH=$PATH:~/src/scala/bin:~/src/scala-2.11.2/bin:~/src/sbt/bin:~/src/neo4j-community-2.1.5/bin/
