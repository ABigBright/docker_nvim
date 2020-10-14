FROM archlinux
RUN useradd -d /home/briq -m -p "dlsz" -s /bin/sh -U briq
COPY pacman_conf/pacman.conf /etc/
COPY pacman_conf/mirrorlist /etc/pacman.d/
RUN pacman -Syy
RUN pacman -Sy neovim yaourt --noconfirm
RUN yaourt -Sy --noconfirm global ripgrep python3 git npm the_silver_searcher yarn clang ctags python-pip ranger ueberzug
COPY nvim.sh /home/briq/
USER briq
RUN sh /home/briq/nvim.sh

ENTRYPOINT ["nvim"]


