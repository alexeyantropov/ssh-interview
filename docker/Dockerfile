FROM almalinux:8
LABEL maintainer='alexeyantropov@gmail.com'

ARG _USERNAME='user'
ARG _SSHKEYS='/ssh-keys'
ARG _SUDOERS='/etc/sudoers.d/sudoers'
ARG _ENTRYPOINT='/usr/local/bin/entry-point.sh'
ARG _PASSWORD_AUTH='yes'
ARG _DAEMONS

ENV _SSHKEYS=${_SSHKEYS}
ENV _USERNAME=${_USERNAME}
ENV _SUDOERS=${_SUDOERS}
ENV _ENTRYPOINT=${_ENTRYPOINT}
ENV _PASSWORD_AUTH=${_PASSWORD_AUTH}
ENV _DAEMONS=${_DAEMONS}

RUN yum -y --setopt=skip_missing_names_on_install=False install \
    iproute \
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
    telnet \
    tcpdump \
    tmux \
    util-linux \
    /usr/bin/true && \
    useradd -U -m ${_USERNAME} --uid=9999 && \
    mkdir -p ${_SSHKEYS} ${_DAEMONS} && \
    touch /var/log/lastlog

COPY sudoers /etc/sudoers.d/sudoers
COPY entry-point.sh ${_ENTRYPOINT}
COPY dummy-ssh-key ${_SSHKEYS}/.
COPY sshd_config /etc/ssh/sshd_config
COPY bash_profile /home/${_USERNAME}/.bash_profile
COPY dummy-daemon.sh ${_DAEMONS}/.

ENTRYPOINT ${_ENTRYPOINT}
EXPOSE 22/tcp
CMD ['/bin/bash']