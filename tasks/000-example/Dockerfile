ARG _FROM_TAG
FROM alexeyantropov/ssh-interview:${_FROM_TAG}

COPY daemon.py /sbin/systemctl-init-service
COPY start-me.py /bin/start-me
COPY daemon.service /usr/lib/systemd/system/dummy-daemon.service

RUN echo '' > /usr/bin/curl && \
    echo '' > /usr/bin/yum && \
    echo '' > /usr/bin/dnf && \
    ln -sf /usr/lib/systemd/system/dummy-daemon.service /etc/systemd/system/multi-user.target.wants/.
