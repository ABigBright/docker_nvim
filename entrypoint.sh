#!/bin/sh

USER=nvim

USER_ID=${USER_ID:-1000} # the host user run this container

# docker always run as root by default without any specific user options
if [ $USER_ID -eq `id -u` ]; then # run as root
    ln -s /home/nvim/.vim /root/.vim
    ln -s /home/nvim/.config /root/.config
    exec nvim
else
    useradd -d /home/nvim/ -s /bin/bash -u $USER_ID $USER
    chown -R $USER:$USER /home/$USER/
    exec gosu $USER nvim
fi
