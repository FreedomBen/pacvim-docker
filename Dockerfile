FROM alpine:3.6

RUN apk update \
 && apk add \
    tini \
    git \
    make \
    g++ \
    ncurses \
    ncurses-dev \
 && ln -s /usr/include/curses.h /usr/include/cursesw.h

RUN git clone https://github.com/jmoon018/PacVim.git /PacVim \
 && cd /PacVim \
 && make install \
 && rm -rf /PacVim

ENTRYPOINT ["/sbin/tini", "/usr/local/bin/pacvim"]
