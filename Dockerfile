FROM archlinux
LABEL maintainer "briq <990647625@qq.com>"

ENV GOSU_VERSION 1.12

# RUN useradd -d /home/nvim -m -s /bin/sh -U -u 1000 nvim

WORKDIR /home/nvim

COPY pacman_conf/pacman.conf /etc/
COPY pacman_conf/mirrorlist /etc/pacman.d/

RUN pacman -Syy; \
    pacman -Sy --noconfirm --disable-download-timeout neovim yaourt; \
    yaourt -Sy --noconfirm --disable-download-timeout global ripgrep \
        python3 git npm the_silver_searcher yarn clang ctags python-pip \
        ranger ueberzug gcc w3m ffmpegthumbnailer imlib2 fd iputils; \
    \
    # update the vim config
    cd $HOME; \
    mkdir -p .config; \
    git clone https://github.com/ABigBright/vimcfg-private.git .vim; \
    git clone https://github.com/ABigBright/ranger_conf.git .config/ranger; \
    ln -s $HOME/.vim $HOME/.config/nvim; \
    npm config set registry https://registry.npm.taobao.org/ --global; \
    pip config --global set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple; \
    pip install pynvim; \
    yarn global add neovim; \
    \
    # get the gosu binary
    cpu_arch="amd64"; \
    curl -fLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$cpu_arch"; \
	curl -fLo /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$cpu_arch.asc"; \
	\
    # verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    \
    # fullfill gosu binary exec perm
    chmod +x /usr/local/bin/gosu; \
    gosu --version; \
    gosu nobody true; \
    nvim -u $HOME/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"

COPY nvim_entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/nvim_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/nvim_entrypoint.sh"]

