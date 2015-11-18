#!/bin/zsh
# .zprofile

# path

typeset -U path
export path

if [[ -d /usr/local ]]; then
    path=($path /usr/local/bin /usr/local/sbin)
fi

if [[ -d /usr/X11R6/bin && $UID -ne 0 ]]; then
    path=($path /usr/X11R6/bin)
fi

if [[ -d /sw ]]; then
    path=($path /sw/bin /sw/sbin)
fi

if [[ -d $HOME/bin ]]; then
    path=($path $HOME/bin)
fi

# tmpdir

if [[ -d $HOME/tmp ]]; then
    export TMPPREFIX=$HOME/tmp/zsh
    export TMPDIR=$HOME/tmp
else
    export TMPDIR="/tmp"
fi

# Editor/pager/etc

# if [[ -x $(which vim) ]]; then
#     export EDITOR="$(which vim)"
# fi
if [[ -x $(which mate) ]]; then
    export EDITOR="$(which mate) -w"
fi

if [[ -x $(which vless) ]]; then
    export READNULLCMD='vless'
else
    export READNULLCMD='less'
fi

export NULLCMD='cat'
export PAGER='less'
#export LESSCHARSET='latin1'
export LESSCHARSET='utf-8'
export LESS='-i -s -M -g -x4 -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...' 

if [[ -x $(which lesspipe.sh) ]]; then
    export LESSOPEN='|lesspipe.sh %s 2>&-'
fi

export DIRSTACKSIZE='12'

export GREP_COLOR='auto'

export RSYNC_RSH='ssh'
export CVS_RSH='ssh'

export SCREENDIR="$HOME/.screen"

export GDK_USE_XFT=1

# For Mercurial 
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# For a better Python Path
export PYTHONPATH

if [[ -d /Library/Python/2.7/site-packages ]]; then
    PYTHONPATH=($PYTHONPATH /Library/Python/2.7/site-packages )
fi

