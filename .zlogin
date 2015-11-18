#!/bin/zsh
# .zlogin
# Set up keychain (if both keychain and private key are available)

if [[ -f $HOME/.ssh/id_dsa ]]; then
    KEY_DSA=1
    KEY_ALG=id_dsa
elif [[ -f $HOME/.ssh/id_rsa ]]; then
    KEY_RSA=1
    KEY_ALG=id_rsa
else
    KEY=0
fi

if [[ ${KEY} != 0  && -x $(which keychain) ]]; then
    keychain -q ${HOME}/.ssh/${KEY_ALG}
    . ~/.keychain/${HOSTNAME}-sh
fi

# Perform a null command to set exit status to zero at first prompt             

:
