FROM alexeyantropov/ssh-interview:develop.latest

ARG _DAEMONS

COPY daemon.py ${_DAEMONS}/.
COPY start-me.py /bin/start-me

RUN echo '' > /usr/bin/curl && \
    echo '' > /usr/bin/yum && \
    echo '' > /usr/bin/dnf