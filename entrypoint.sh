#!/bin/sh

USER=nvim

USER_ID=${USER_ID:-1000} # the host user run this container

if [ $USER_ID -eq `id -u` ]; then
    exec nvim
else
    useradd -m -s /bin/bash -u $USER_ID $USER
    mkdir -p /home/$USER/.config
    ln -s $HOME/.vim /home/$USER/.config/nvim
    chown -R $USER:$USER /home/$USER/.config/nvim
    exec gosu $USER nvim
fi
