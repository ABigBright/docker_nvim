#!/bin/sh

cd ~
mkdir -p .config
git clone https://github.com/ABigBright/vimcfg-private.git .vim
ln -s ~/.vim ~/.config/nvim
npm config set metrics-registry https://registry.npm.taobao.org/
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
npm install -g neovim
pip install pynvim

