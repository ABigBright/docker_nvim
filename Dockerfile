FROM archlinux
RUN useradd -d /home/briq -m -p "dlsz" -s /bin/sh -U briq
COPY pacman_conf/pacman.conf /etc/
COPY pacman_conf/mirrorlist /etc/pacman.d/
RUN pacman -Syy
RUN pacman -Sy --noconfirm --disable-download-timeout neovim yaourt
RUN yaourt -Sy --noconfirm --disable-download-timeout global ripgrep python3 git npm the_silver_searcher yarn clang ctags python-pip ranger ueberzug gcc w3m ffmpegthumbnailer imlib2 fd
COPY nvim.sh /home/briq/
RUN chmod +x /home/briq/nvim.sh
USER briq
RUN sh /home/briq/nvim.sh

ENTRYPOINT ["nvim"]


