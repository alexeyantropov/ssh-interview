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

VOLUME ${_SSHKEYS}

RUN /usr/bin/true && \
    yum -y --setopt=skip_missing_names_on_install=False install \
    tmux \
    shadow-utils \
    sudo \
    util-linux \
    sed \
    openssh-server && \
    useradd -U -m ${_USERNAME} --uid=9999 && \
    /usr/bin/true

COPY sudoers /etc/sudoers.d/sudoers
COPY entry-point.sh ${_ENTRYPOINT}

ENTRYPOINT [${_ENTRYPOINT}]

USER ${_USERNAME}
CMD ['/bin/bash']