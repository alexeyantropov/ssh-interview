FROM almalinux:8
LABEL maintainer='alexeyantropov@gmail.com'

ARG _USERNAME='user'
ARG _SSHKEYS='/ssh-keys'
ARG _SUDOERS='/etc/sudoers.d/sudoers'
ENV _SSHKEYS=${_SSHKEYS}
ENV _USERNAME=${_USERNAME}
ENV _SUDOERS=${_SUDOERS}

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
COPY entry-point.sh /usr/local/bin/

ENTRYPOINT ['/entry-point.sh']

USER ${_USERNAME}
CMD ['/bin/bash']