#!/bin/sh
# skel.sh
# Copyblight Calum A. Selkirk 2004
# Distributed under the terms of the GPLv2

# Create a directory called ".skel" within the root of your home directory.
# Within that directory create symbolic links to dotfiles/directories above.
# If you wish only certain files from within "~/directory" to be copied then
# create a directory of the same name within ~/.skel and symlink to the
# required files from there.
#
# eg: (my ~/.skel):
#
# .dir_colors -> ../.dir_colors
# .screenrc -> ../.screenrc
# .ssh (contains a symlink to ~/.ssh/authorized_keys)
# .vim -> ../.vim
# .vimrc -> ../.vimrc
# .zlogin -> ../.zlogin
# .zlogout -> ../.zlogout
# .zprofile -> ../.zprofile
# .zsh (contains symlinks to certain files in ~/.zsh)
# .zshenv -> ../.zshenv
# .zshrc -> ../.zshrc
# bin (contains symlinks to certain shell scripts in ~/bin)

if [[ $1 = "--delete" ]]; then
    RHOST=$2
    DELETE=YES
else
    RHOST=$1
fi

if [[ -z ${RHOST} ]]; then
    echo "Usage: $(basename $0) [--delete] [username@]hostname"
    exit
fi

# Sanity check
if [[ ! -d ${HOME}/.skel ]]; then
    echo "There is no ${HOME}/.skel to distribute to ${RHOST} .. Aborting"
fi

# Why "--delete" you might ask, surely the remote files are overwritten
# when re-running the script? Yes, but files nested within $HOME/dir/dir
# whos parent remains but have been removed from the master ~/.skel/dir/dir
# (that is, locally) will persist as there is nolonger a record of them
# within the master. We could use tars' "--overwrite" and/or "--overwrite-dir"
# but this would remove files that may only exist on the remote machine (and
# are not part of the files provided by .skel). "--delete" will remove these
# non-skel components also, but at least it needs to be called explicitly.
# One solution to this problem may be to keep a record of the files skel.sh
# installs and compare when updating, but this would require either keeping
# copies of the master .skel (as it changes), or logs of the files transferd.

if [[ ${DELETE} = "YES" ]]; then
    cd $HOME/.skel
    # we want .ssh (specificly authorized_keys) to be last in the list ..
    # so we aren't continually asked for the password when rm'ing
    SKEL_FILES=$(/bin/ls -A1 |grep -v .ssh)
    ssh ${RHOST} "rm -fr ${SKEL_FILES}";
    if [[ -n $(/bin/ls -d .ssh) ]]; then
        ssh ${RHOST} "rm -fr .ssh";
    fi
else
    cd ${HOME}/.skel
    tar chf - . | ssh ${RHOST} "tar --no-same-owner -xpvf -" &&
    # change back to the old PWD
    cd ${OLDPWD} 

# Optionally keep a list of hosts (for possible later use when updating).
# Create an empty ~/.skel_hosts for {user@}hostname to be saved. You
# could then update all machines you have previously run skel.sh on with
# the following: "for i in $(cat ~/.skel_hosts); do skel.sh ${i} ; done"
    
    if [[ -f ~/.skel_hosts && -z $(grep ${RHOST} ~/.skel_hosts) ]]; then
        echo ${RHOST} >> ${HOME}/.skel_hosts
    fi
fi
