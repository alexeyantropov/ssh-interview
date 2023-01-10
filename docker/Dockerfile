FROM almalinux:8
LABEL maintainer='alexeyantropov@gmail.com'

ARG _USERNAME='user'
ARG _SSHKEYS='/ssh-keys'
ARG _SUDOERS='/etc/sudoers.d/sudoers'
ARG _ENTRYPOINT='/usr/local/bin/entry-point.sh'
ENV _SSHKEYS=${_SSHKEYS}
ENV _USERNAME=${_USERNAME}
ENV _SUDOERS=${_SUDOERS}
ENV _ENTRYPOINT=${_ENTRYPOINT}

RUN yum -y --setopt=skip_missing_names_on_install=False install \
    iproute \
    net-tools \
    nmap-ncat \
    openssh-server \
    procps-ng \
    sed \
    shadow-utils \
    strace \
    sudo \
    tcpdump \
    tmux \
    util-linux \
    /usr/bin/true && \
    useradd -U -m ${_USERNAME} --uid=9999 && \
    mkdir -p ${_SSHKEYS}

COPY sudoers /etc/sudoers.d/sudoers
COPY entry-point.sh ${_ENTRYPOINT}
COPY dummy-ssh-key ${_SSHKEYS}/.
COPY sshd_config /etc/ssh/sshd_config

ENTRYPOINT ${_ENTRYPOINT}
EXPOSE 22/tcp
CMD ['/bin/bash']