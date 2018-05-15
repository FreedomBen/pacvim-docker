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

RUN git clone https://github.com/jmoon018/PacVim.git /root/pacvim \
 && cd /root/pacvim \
 && make install \
 && rm -rf /root/pacvim

RUN addgroup -g 1000 docker \
 && adduser -u 1000 -G docker -s /bin/sh -D docker

USER docker

ENTRYPOINT ["/sbin/tini", "/usr/local/bin/pacvim"]
