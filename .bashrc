# Barton's .bashrc, a heavily hacked version of:
# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias la='ls -A'
alias l='ls -CF'
alias vim='/usr/bin/vi'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export LC_ALL=C
export EDITOR=/usr/bin/vi

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=erasedups

# append to the history file, don't overwrite it
shopt -s histappend
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
export HOSTFILE="$HOME/.hosts"
if which xsel > /dev/null
then
    export CLIPCOPY='xsel -i'
    export CLIPCLIPBOARD='xsel -i --clipboard'
    export CLIPPASTE='xsel -o'
else
    export CLIPCOPY='pbcopy'
    export CLIPCLIPBOARD='pbcopy'
    export CLIPPASTE='pbpaste'
fi

test -s ~/.alias && . ~/.alias || true

# Uncomment this to set bash into vi mode editing. This is probably better
# left to .inputrc, if available.
# set -o vi

# Define ANSI colors for prompts.
export red=31
export green=32
export yellow=33

if ( echo $HOSTNAME | grep -i 'prep' > /dev/null )
then
	promptcolor=$green
	export MY_ENV_HOME=/prepfsnr/prep
elif (echo $HOSTNAME | grep -i 'prod' > /dev/null)
then
	promptcolor=$red
	export MY_ENV_HOME=/prodfsnr/prod
else
	export MY_ENV_HOME=/prep
	promptcolor=$yellow
fi

export PS1="\e]0;\h \w\007 \d \t \u@\[\e[1;${promptcolor}m\]\h\[\e[0m\]: \w\n\$ "

test -s ~/.localrc && . ~/.localrc || true
test -s ~/.bashtemprc && . ~/.bashtemprc || true

# set 'less' so that it does not refresh the screen after 'less' exits.
export LESS='FiX'
bind '"\e[17~":"exit\n"'
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

PATH=$PATH:/usr/bin:$HOME/bin:$HOME/.rvm/bin:$HOME/altbin # Add RVM to PATH for scripting

export MAIL=/var/spool/mail/barton

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

stty stop undef
stty start undef

PERL_MB_OPT="--install_base \"/home/barton/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/barton/perl5"; export PERL_MM_OPT;
