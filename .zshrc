#!/bin/zsh
# .zshrc

# OPTIONS

setopt \
        always_last_prompt \
        append_history \
        auto_list \
        auto_menu \
        auto_param_keys \
        auto_param_slash \
        auto_pushd \
        auto_remove_slash \
        bad_pattern \
        bang_hist \
        brace_ccl \
        cdable_vars \
        complete_aliases \
        complete_in_word \
        correct_all \
        csh_junkie_history \
        equals \
        extended_glob \
        extended_history \
        function_argzero \
        glob \
        glob_complete \
        glob_subst \
        hash_cmds \
        hash_dirs \
        hash_list_all \
        hist_allow_clobber \
        hist_beep \
        hist_expire_dups_first \
        hist_ignore_all_dups \
        hist_ignore_dups \
        hist_ignore_space \
        hist_reduce_blanks \
        hist_verify \
        ignore_eof \
        inc_append_history \
        interactive_comments \
        list_packed \
        list_types \
        long_list_jobs \
        magic_equal_subst \
        multios \
     NO_all_export \
     NO_always_to_end \
     NO_auto_cd \
     NO_auto_name_dirs \
     NO_auto_resume \
     NO_bad_pattern \
     NO_beep \
     NO_bsd_echo \
     NO_chase_links \
     NO_clobber \
     NO_correct \
     NO_csh_junkie_loops \
     NO_csh_junkie_quotes \
     NO_csh_null_glob \
     NO_glob_assign \
     NO_glob_dots \
     NO_hist_no_functions \
     NO_hist_no_store \
     NO_hist_save_no_dups \
     NO_hup \
     NO_ignore_braces \
     NO_ignore_eof \
     NO_list_ambiguous \
     NO_list_beep \
     NO_mail_warning \
     NO_mark_dirs \
        nomatch \
     NO_menu_complete \
     NO_nomatch \
     NO_null_glob \
     NO_overstrike \
     NO_print_exit_value \
     NO_prompt_cr \
     NO_pushd_minus \
        pushd_silent \
     NO_rc_quotes \
     NO_rm_star_silent \
     NO_rm_star_wait \
     NO_sh_file_expansion \
     NO_sh_word_split \
     NO_single_line_zle \
     NO_sun_keyboard_hack \
        notify \
        numeric_glob_sort \
        path_dirs \
        posix_builtins \
        prompt_subst \
        pushd_ignore_dups \
        pushd_to_home \
        rc_expand_param \
        sh_option_letters \
        short_loops \
        unset \
     NO_verbose \
        zle 

# ZDOTDIR

zdotdir=${ZDOTDIR:-$HOME}

# FPATH

fpath=(${zdotdir}/{.zsh/*.zwc,.zsh/{functions,scripts}}(N) ${fpath})

# Autoload functions that have the executable bit on.
# (All functions are under ~/.zsh/functions and not in this file)

for dirname in ${fpath}; do
  fns=( ${dirname}/*~*~(N.x:t) )
  (( ${#fns} )) && autoload ${fns}
done

typeset -gU fpath

# INFOPATH

typeset -U infopath

infopath=(/usr/share/info(N) ${infopath})

# MANPATH

typeset -U manpath

manpath=(/usr/X11R6/man /usr/share/man /usr/local/share/man)
manpath=(${manpath} /usr/local/man)

# Test for finks' "/sw" (OS X) 
if [[ -d /sw/share/man ]]; then
    manpath=(${manpath} /sw/share/man)
fi

# Test for a man dir in $HOME
if [[ -d $HOME/man ]]; then
    manpath=($manpath $HOME/man)
fi

# WORDCHARS

# Word delimiter characters in line editor.

WORDCHARS=''

# COLUMNS 

export COLUMNS

# HISTORY

HISTFILE=~/.zshhistory
HISTSIZE=4000
SAVEHIST=4000

# LISTMAX

# Maximum size of completion listing.
# Only ask if line would scroll off screen.

LISTMAX=0

# run-help

if [[ -d /usr/share/zsh_help ]]; then
    unalias run-help
    autoload run-help
    HELPDIR="/usr/share/zsh_help"
    alias run-help=' run-help'
elif [[ -d $HOME/.zsh/zsh_help ]]; then
    unalias run-help
    autoload run-help
    HELPDIR="${HOME}/.zsh/zsh_help"
    alias run-help=' run-help'
fi

# PROMPTS (local and ssh/remote)

THIS_TTY=tty$(ps aux | grep $$ | grep zsh | awk '{ print $7 }')
SESS_SRC=$(who | grep ${THIS_TTY} | awk '{ print $6 }')

SSH_FLAG=0
SSH_IP=$(builtin print ${SSH_CLIENT} | awk '{ print $1 }')

SSH_FLAG=0
SSH_IP=$(builtin print ${SSH_CLIENT} | awk '{ print $1 }')

if [ ${SSH_IP} ] ; then
  SSH_FLAG=1
fi

SSH2_IP=$(builtin print ${SSH2_CLIENT} | awk '{ print $1 }')

if [ ${SSH2_IP} ] ; then
  SSH_FLAG=1
fi 

if [ ${SSH_FLAG} -eq 1 ] ; then
  CONN=ssh
elif [ -z ${SESS_SRC} ] ; then
  CONN=local
elif [ ${SESS_SRC} = "(:0.0)" -o ${SESS_SRC} == "" ] ; then
  CONN=local
fi

if [ ${UID} == "0" ] ; then
  USR=priv
else
  USR=nopriv
fi

# SET PROMPT

# Color Definitions:

# RED="%{\e[1;31m%}"
# GREEN="%{\e[1;32m%}"
# YELLOW="%{\e[1;33m%}"
# BLUE="%{\e[1;34m%}"
# PINK="%{\e[1;35m%}"
# CYAN="%{\e[1;36m%}"
# WHITE="%{\e[1;37m%}"
# END="%{\e[0m%}"

if [ ${CONN} == local -a ${USR} == nopriv ] ; then
    PS1=$'[%{\e[1;33m%}%n%{\e[0m%}@%{\e[1;33m%}%m%{\e[0m%}: %{\e[1;34m%}%3~%{\e[0m%}]%# '
    RPS1=$'%{\e[1;31m%} %{\e[0m%}[%{\e[1;31m%}%B%h%b%{\e[1;31m%}%{\e[0m%}]' 
elif [ ${CONN} == local -a ${USR} == priv ] ; then
    PS1=$'[%{\e[1;31m%}%n%{\e[0m%}@%{\e[1;31m%}%m%{\e[0m%}: %{\e[1;34m%}%3~%{\e[0m%}]%# '
    RPS1=$'%{\e[1;31m%} %{\e[0m%}[%{\e[1;31m%}%B%h%b%{\e[1;31m%}%{\e[0m%}]' 
elif [ ${CONN} == ssh -a ${USR} == nopriv ] ; then
    PS1=$'[%{\e[1;33m%}%n%{\e[0m%}@%{\e[1;36m%}%m%{\e[0m%}: %{\e[1;34m%}%3~%{\e[0m%}]%# '
    RPS1=$'%{\e[1;31m%} %{\e[0m%}[%{\e[1;31m%}%B%h%b%{\e[1;31m%}%{\e[0m%}]' 
elif [ ${CONN} == ssh -a ${USR} == priv ] ; then
    PS1=$'[%{\e[1;31m%}%n%{\e[0m%}@%{\e[1;36m%}%m%{\e[0m%}: %{\e[1;34m%}%3~%{\e[0m%}]%# '
    RPS1=$'%{\e[1;31m%} %{\e[0m%}[%{\e[1;31m%}%B%h%b%{\e[1;31m%}%{\e[0m%}]' 
else
    PS1='%n@%m %B%3~%b %# '
fi

SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '

# COMPLETIONS

# New advanced completion system

autoload -U compinit
compinit -C # Don't perform security check

# General completion

zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:*' special-dirs ..

# Completion caching

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/${HOST}

# Expand partial paths

zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Don't complete backup files as executables

zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Ignore completion functions (until the _ignored completer)

zstyle ':completion:*:functions' ignored-patterns '_*'

# Separate matches into groups

zstyle ':completion:*:matches' group 'yes'

# Describe each match group.

zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format

zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# Simulate Adams old dabbrev-expand 3.0.5 patch 

zstyle ':completion:*:history-words' stop verbose
zstyle ':completion:*:history-words' remove-all-dups yes

# Match uppercase from lowercase.
# WARNING: this completion can cause a race condition if parsing a
# directory with many files in (the array created overloads the array
# buffer?). This I have witnessed with zsh-4.{2,3}.x listing a Gentoo
# Distfiles mirror. FIXME: report this as a bug to zsh-dev
#
# Note that I'm enabiling this for OS X (Darwin) machines as their
# directory/folder naming converntion is to use uppercase for the first
# letter, and I <b>hate</b> to have to do the extra shift key (gahhh).


if [[ $(uname -s) == "Darwin" ]]; then
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
fi

# Don't put already completed items in rm complete

zstyle ':completion:*:rm:*' ignore-line yes

# cd "../" should never present the current working directory in the
# completion returned.

zstyle ':completion:*:cd:*' ignore-parents parent pwd

# zrecompile

autoload zrecompile 

#  LS_COLORS

if [[ -x =dircolors && -f $HOME/.dir_colors ]]; then
    export SHELL='/bin/zsh' &&
    eval $(dircolors --sh ~/.dir_colors)
fi

zmodload -i zsh/complist

# Completion colours

zstyle ':completion:*' list-colors "${LS_COLORS}"

# Colourize kill

zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b) #([0-9]#)*=0=01;31'

# PRE KEYBINDINGS

# Improve Word Navigation

_my_extended_wordchars="*?_-.[]~=&;!#$%^(){}<>:@,\\"
_my_extended_wordchars_space="${_my_extended_wordchars} "
_my_extended_wordchars_slash="${_my_extended_wordchars}/"

# ".. is the current position \-quoted ?

is_backslash_quoted () {
    test "${BUFFER[$CURSOR-1,CURSOR-1]}" = "\\"
}

unquote-forward-word () {
    while is_backslash_quoted
      do zle .forward-word
    done
}

unquote-backward-word () {
    while is_backslash_quoted
      do zle .backward-word
    done
}

backward-to-space () {
    local WORDCHARS="${_my_extended_wordchars_slash}"
    zle .backward-word
    unquote-backward-word
}

forward-to-space () {
     local WORDCHARS="${_my_extended_wordchars_slash}"
     zle .forward-word
     unquote-forward-word
}

backward-to-/ () {
    local WORDCHARS="${_my_extended_wordchars}"
    zle .backward-word
    unquote-backward-word
}

forward-to-/ () {
     local WORDCHARS="${_my_extended_wordchars}"
     zle .forward-word
     unquote-forward-word
}

# KEYBINDINGS

bindkey -e

zle -N backward-to-space
zle -N forward-to-space

zle -N backward-to-/
zle -N forward-to-/

# backward-to-space: ALT-B
bindkey "^[B"  backward-to-space

# forward-to-space: ALT-F
bindkey "^[F"  forward-to-space

# backword-to-/ : ALT-b
bindkey "^[^b" backward-to-/

# forward-to-/ : ALT-f
bindkey "^[^f" forward-to/

# expand-cmd-path: ALT-e .. Expand current command to full path.
bindkey '^[e' expand-cmd-path

# vi-find-prev-char: CNTL-b .. Move back char vi style.
bindkey '^[^b' vi-find-prev-char

# reverse-menu-complete: ALT-tab
bindkey '^[^I' reverse-menu-complete

# history-beginning-search-backward: ALT-p
bindkey '^[p' history-beginning-search-backward

# history-beginning-search-forward: ALT-n
bindkey '^[n' history-beginning-search-forward 

# backward-kill-word: CNTL-w
bindkey '^W' backward-kill-word

# emacs-forward-word: ALT-f
bindkey '\ef' emacs-forward-word
bindkey -s '^[/' '\eb!?\ef?:%\e!'

# find-next-char: CNTL-x CNTL-f <char>
bindkey -s '^[^f' '^X^F'

# copy-prev-word: CNTL-x c
bindkey '^Xc' copy-prev-word

# Incremental backward search of the command history: CNTL-r
bindkey '^R' history-incremental-search-backward

# Command line editing in $EDITOR: ALT+v 
autoload edit-command-line
zle -N edit-command-line
bindkey -M emacs '^[v' edit-command-line

# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'

# ALIASES

# Listing
# gahh .. what a pigs arse

if [[ -x /sw/bin/ls ]]; then
    GNU_LS='/sw/bin/ls' 
elif [[ $(uname -s) == "Linux" ]]; then
    GNU_LS='=ls'
fi

if [[ -z ${GNU_LS} ]]; then 
    # use BSD's "/bin/ls"
    alias ls='ls -FG $@' # colourize and give file desciptors
    alias lsp='CLICOLOR_FORCE="yes" /bin/ls -alFhG | less -R' # ls paged
    alias lsr='CLICOLOR_FORCE="yes" /bin/ls -lRGF "$@" |less -R' # recursive
    alias lsl=' builtin print \"Sorry .. no support for the -X switch\"'
    alias lsd='ls -d *(-/DN) "$@"' # list directories only
    alias lsh='ls -d .*' # show only hidden files
    alias l='ls -lh' # long .. filesize human readable
    alias ll='ls -alFh' # full/long
    alias lf='ls -aCF' # all (short format)
    alias la='ls -a' # all, including dotfiles (short)
    alias lx='ls -lXB $@' # sort by extension
else
    alias ls='${GNU_LS} -F --color=auto $@' # colourize and give file desciptors
    alias lsp='${GNU_LS} -alFh --color=yes | less -R' # ls paged
    alias lsr='${GNU_LS} -lR --color=yes "$@" |less -R' # recursive/piped
    alias lsl='ls -svX --si' # filesize (human readable) and filename
    alias lsd='ls -d *(-/DN) "$@"' # list directories only
    alias lsh='ls -d .*' # show only hidden files
    alias l='ls -lh' # long .. filesize human readable
    alias ll='ls -alFh' # full/long
    alias lf='ls -aCF' # all (short format)  
    alias la='ls -a' # all, including dotfiles (short)
    alias lx='ls -lXB $@' # sort by extension
fi

# tree

if [[ -x =tree ]]; then
    alias lspp='tree -pfiugFD -L 1 | less -R'
    alias lst='tree -CsAF "$@" | less -R' # directory tree (colorized) piped 
                                          # to less
    alias tree='tree -Cs "$@"' 
fi

# Changing Directory

alias cdl='cd $1 && ls'

# Global Aliases: WARNING

alias -g ...=' ../..'
alias -g ....=' ../../..'
alias -g .....=' ../../../..'
alias -g ......=' ../../../../..'
alias cd..=' cd ..'
alias cd...=' cd ../..'
alias cd....=' cd ../../..'
alias cd.....=' cd ../../../..'
alias cd/=' cd /'

alias 1=' cd -'
alias 2=' cd +2'
alias 3=' cd +3'
alias 4=' cd +4'
alias 5=' cd +5'
alias 6=' cd +6'
alias 7=' cd +7'
alias 8=' cd +8'
alias 9=' cd +9'
 
# Making/Renaming/Removing (No correction)

autoload zmv

alias mmv='noglob zmv -W'
alias md='nocorrect mkdir -p'
alias rd='nocorrect rmdir' 
alias mv='nocorrect mv -i'
alias cp='nocorrect cp -i -p'
alias rm='nocorrect rm'
alias srm='nocorrect srm -i'

# Disk Usage

alias duh=' du -hs'
alias dfh=' df -h'

# Job/process control

alias j=' jobs -l'
alias pa=' ps -aux'
alias paw=' ps -auxw'

# BSD's "ps" doesn't support the -f switch 

if [[ $(uname -s) == "Linux" ]]; then
    alias p=' ps -fu ${USER}'
    alias psu=' ps -fu $@'
    alias gps=' ps -ef | grep $@'
else
    alias p=' ps -u ${USER}'
    alias psu=' ps -u $@'
    alias gps=' ps -e | grep $@'
fi    

# Shell/Environment

alias h=' history -$LINES' 
alias gh=' history 1 | grep $@'
# TIP execute last command: !!
# TIP execute history with: !n 
#alias dirs=' dirs -v'
alias d=' dirs -v'
alias pu=' pushd'
alias po=' popd'
alias pwd=' pwd -r' 

alias ts=' typeset'
compdef _vars_eq ts

#  Paging with less/head/tail 

alias v=' less -R'
alias tf=' less +F'

# WARNING: Global aliases : Use with caution.

alias -g L='| less'
alias -g LR='| less -R'
alias -g H='| head -20'
alias -g T='| tail -20'

# Sorting & Counting

alias -g C='| wc -l'
alias -g S='| sort'
alias -g SU='| sort -u'
alias -g SN='| sort -n'
alias -g SNR='| sort -nr'

# grep

alias grep='egrep'

# man/apropos/whereis

alias man=' nocorrect man'
alias ap=' apropos'
alias wi=' whereis'

# Date (format: 0000-00-00 .. Year-Month-Day)
alias dat='date +%F'

# Doesn't work with BSD's which.

if [[ $(uname -s) == "Linux" ]]; then
    alias which='alias |/usr/bin/which \
                        --tty-only \
                        --read-alias \
                        --show-dot \
                        --show-tilde'
fi

# screen 

if [[ ${TERM} == screen ]]; then
    alias sX=screen -X "$1" `pwd`/"$2"
    alias SX=screen -X "$@"
fi

# Directories (global) WARNING GLOBAL ALIASES

if [[ -f /etc/gentoo-release ]]; then
    alias -g US='/usr/src'
    alias -g ULS='/usr/local/src'
    alias -g UP='/usr/portage'
    alias -g ULP='/usr/local/portage' 
fi

# Common Filenames

alias -g NUL="> /dev/null 2>&1"
alias -g VL=/var/log

# Test for metalog (and add as common filename global)

if [[ -f /var/log/messages/current ]]; then
    alias -g VM=/var/log/messages/current
fi

# Some root aliases/unaliases

if [[ $UID -eq 0 ]]; then
    alias rm=' nocorrect rm -i'
    alias srm=' nocorrect srm -i'
    alias shuth=' /sbin/shutdown -h now'
    alias shutr=' /sbin/shutdown -r now'
    alias mount='nocorrect mount'
fi

# MISC

# Search these places for perl include files.
#export PERL5LIB="${HOME}/lib/perl5:${HOME}/lib/perl5/site_perl"

# gnome-terminal weirdness
 
if [[ -n ${COLORTERM} && ! ${UID} -eq 0 ]]; then
    eval $(resize)
fi

# Source local aliases/rc (if it exists)

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# vim:ft=zsh
