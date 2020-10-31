#!/bin/sh

USER=nvim

USER_ID=${USER_ID:-1000} # the host user run this container

if [ $USER_ID -eq `id -u` -a 1000 -eq `id -u` ]; then # host user == container current user, and container user is nvim
    exec nvim
else
    exec gosu nvim nvim
fi
