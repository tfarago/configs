# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF -h'
alias la='ls -A'
alias l='ls -CF'

# some useful aliases
alias off='sudo poweroff'
alias cl='clear'
alias g=git

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable prefix + up / down completion
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# --- enhance prompt ----------------------------------------------------------
function _prompt_workingdir () {
    local pwdmaxlen=$(($COLUMNS/5))
    local trunc_symbol="..."
    if [[ $PWD == $HOME* ]]; then
        newPWD="~${PWD#$HOME}" 
    else
        newPWD=${PWD}
    fi
    if [ ${#newPWD} -gt $pwdmaxlen ]; then
        local pwdoffset=$(( ${#newPWD} - $pwdmaxlen + 3 ))
        newPWD="${trunc_symbol}${newPWD:$pwdoffset:$pwdmaxlen}"
    fi
    echo $newPWD
}

function _git_prompt() {
    local git_status="`git status --porcelain 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [ -z "$git_status" ]; then
            local ansi=42
        elif [[ "$git_status" == *" M "* ]]; then
            local ansi=45
        else
            local ansi=43
        fi

        local branch=$(__git_ps1 "%s")

        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

function _colored_host() {
    echo "\[\033[0;33m\]\h\[\033[0m\]"
}

function _prompt_command() {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}⚒ `basename \"$VIRTUAL_ENV\"`${COLOR_NONE} "
    fi

    PS1="`_git_prompt`${PYTHON_VIRTUALENV}"'\[\033[0;33m\]\u\[\033[0m\]@\h:\[\033[0;33m\]$(_prompt_workingdir)\[\033[0m\] '
}

PROMPT_COMMAND=_prompt_command
TERM=xterm-256color
export EDITOR=vim
export WORKON_HOME=~/virtenvs
