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
export LC_ALL=C
export EDITOR=/usr/bin/joe
#export EDITOR=/usr/bin/vim

export HISTSIZE=10000
export HISTCONTROL=erasedups
shopt -s histappend
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
export HOSTFILE="$HOME/.hosts"
if which xsel > /dev/null
then
    export CLIPCOPY='xsel -i'
    export CLIPCLIPBOARD='xsel -i --clipboard'
    export CLIPPASTE='xsel -0'
else
    export CLIPCOPY='pbcopy'
    export CLIPCLIPBOARD='pbcopy'
    export CLIPPASTE='pbpaste'
fi

test -s ~/.alias && . ~/.alias || true

# Uncomment this to set bash into vi mode editing. This is probably better
# left to .inputrc, if available.
# set -o vi

export PATH="$PATH:/usr/bin:$HOME/bin:/var/lib/gems/1.8/bin:$TSSBIN"
# Define ANSI colors for prompts.
export red=31
export green=32
export yellow=33

if (echo $HOSTNAME | grep -i 'prep' > /dev/null )
then
	promptcolor=$green
	export MY_ENV_HOME=/prepfsnr/prep
elif (echo $HOSTNAME | grep -i 'prod' > /dev/null)
then
	promptcolor=$red
	export MY_ENV_HOME=/prodfsnr/prod
else
	export MY_ENV_HOME=/prep
	export APPRISS_ENV_HOME=/prep
	promptcolor=$yellow
fi

export PS1="\e]0;\h \w\007 \d \t \u@\[\e[1;${promptcolor}m\]\h\[\e[0m\]: \w\n\$ "
export FTPLOGS=$APPRISS_ENV_HOME/core/services/ftp01/logs

test -s ~/.localrc && . ~/.localrc || true
test -s ~/.bashtemprc && . ~/.bashtemprc || true
# set 'less' so that it does not refresh the screen after 'less' exits.
export LESS='FiX'
bind '"\e[17~":"exit\n"'
