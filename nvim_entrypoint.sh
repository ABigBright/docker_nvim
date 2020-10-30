#!/bin/sh

USER=nvim

USER_ID=${USER_ID:-0} # the host user run this container

if [ $USER_ID -eq `id -u` ]; then # host user == container current user
    exec nvim
else
    useradd -d /home/nvim -m -s /bin/sh -U -u $USER_ID nvim
    cd $HOME && cp -a . /home/nvim/
    chown -R nvim:nvim /home/nvim
    exec gosu nvim nvim
fi
