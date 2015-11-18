#!/bin/zsh
# .zshenv

# Set variables sanely for assorted versions

if [[ -o rcs ]]; then
    : ${VERSION:="$ZSH_NAME $ZSH_VERSION"}
    : ${MACHTYPE:+${HOSTTYPE::=$MACHTYPE-$OSTYPE}}
    : ${MACHTYPE:=${HOSTTYPE%%-*}}
    : ${OSTYPE:=${HOSTTYPE#*-}}
fi
