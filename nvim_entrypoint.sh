#!/bin/sh

USER=nvim

USER_ID=${USER_ID:-1000} # the host user run this container
GROUP_ID=${GROUP_ID:-1000} # the host user run this container

if [ $USER_ID -eq `id -u` -a $GROUP_ID -eq `id -g` ]; then # host user == container current user
    exec nvim
else
    useradd -d /home/nvim -m -s /bin/sh -U -u $USER_ID -g $GROUP_ID nvim
    cp -a $HOME /home/nvim
    chown -R nvim:nvim /home/nvim
    exec gosu nvim nvim
fi
