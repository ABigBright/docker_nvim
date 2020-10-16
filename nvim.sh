#!/bin/sh

cd /home/briq
mkdir -p .config
git clone https://github.com/ABigBright/vimcfg-private.git .vim
git clone https://github.com/ABigBright/ranger_conf.git .config/ranger
ln -s /home/briq/.vim /home/briq/.config/nvim
npm config set registry https://registry.npm.taobao.org/
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install pynvim
yarn global add neovim
