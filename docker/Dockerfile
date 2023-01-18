FROM almalinux/8-init
LABEL maintainer='alexeyantropov@gmail.com'

ARG _USERNAME='user'
ARG _SSHKEYS='/ssh-keys'
ARG _SUDOERS='/etc/sudoers.d/sudoers'
ARG _ENTRYPOINT='/usr/sbin/entry-point.sh'
ARG _ENTRYPOINT_SERVICE='/usr/lib/systemd/system/entry-point.service'
ARG _ENTRYPOINT_SYSCONFIG='/etc/sysconfig/entry-point'
ARG _PASSWORD_AUTH='yes'

ENV _SSHKEYS=${_SSHKEYS}
ENV _USERNAME=${_USERNAME}
ENV _SUDOERS=${_SUDOERS}
ENV _ENTRYPOINT=${_ENTRYPOINT}
ENV _PASSWORD_AUTH=${_PASSWORD_AUTH}

RUN yum -y --setopt=skip_missing_names_on_install=False install \
    iproute \
    lsof \
    net-tools \
    nmap-ncat \
    openssh-server \
    openssl \
    passwd \
    procps-ng \
    python3-flask \
    python3-requests \
    python36 \
    sed \
    shadow-utils \
    strace \
    sudo \
    tcpdump \
    telnet \
    tmux \
    util-linux \
    /usr/bin/true && \
    useradd -U -m ${_USERNAME} --uid=9999 && \
    mkdir -p ${_SSHKEYS} && \
    touch /var/log/lastlog

COPY entry-point.service ${_ENTRYPOINT_SERVICE}

RUN systemctl enable sshd.service && \
    ln -sf /usr/lib/systemd/system/dummy-daemon.service /etc/systemd/system/multi-user.target.wants/. && \
    ln -sf ${_ENTRYPOINT_SERVICE} /etc/systemd/system/multi-user.target.wants/. && \
    sed s#__ENTRYPOINT__#${_ENTRYPOINT}#g -i ${_ENTRYPOINT_SERVICE} && \
    sed s#__ENTRYPOINT_SYSCONFIG__#${_ENTRYPOINT_SYSCONFIG}#g -i ${_ENTRYPOINT_SERVICE} && \
    /usr/bin/env | egrep '^_' > ${_ENTRYPOINT_SYSCONFIG} && \
    rm -f /etc/systemd/system/*/dnf-makecache.* /usr/lib/systemd/system/dnf-makecache.*  && \
    rm -f /etc/systemd/system/*/systemd-tmpfiles-clean.timer /usr/lib/systemd/system/systemd-tmpfiles-clean.timer && \
    echo 'metadata_timer_sync=0' >> /etc/dnf/dnf.conf && \
    echo '#' >> /etc/dnf/dnf.conf

COPY sudoers /etc/sudoers.d/sudoers
COPY entry-point.sh ${_ENTRYPOINT}
COPY dummy-ssh-key ${_SSHKEYS}/.
COPY sshd_config /etc/ssh/sshd_config
COPY bash_profile /home/${_USERNAME}/.bash_profile
COPY dummy-daemon.sh /sbin/dummy-daemon.sh
COPY dummy-daemon.service /usr/lib/systemd/system/dummy-daemon.service

#STOPSIGNAL SIGSTOP
ENTRYPOINT /usr/lib/systemd/systemd --system --log-level=warning
EXPOSE 22/tcp

CMD ['/bin/bash']