#!/bin/sh

# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then # root user
    find . \! -user nvim -exec chown nvim '{}' +
    exec gosu nvim "$0" "$@"
fi

exec nvim
