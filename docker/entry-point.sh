#!/bin/bash

echo $0

for i in _SSHKEYS _USERNAME _SUDOERS; do
    env | egrep -q "^${i}="
    retval=$?
    if test $retval -ne 0; then
        echo "The env variable $i is not set!"
        exit 1
    fi
done

# fail when smth is wrong
set -e

# the ssh-keys installation
mkdir -p /home/${_USERNAME}/.ssh
$authorized_keys_file="/home/${_USERNAME}/.ssh/authorized_keys"
touch $authorized_keys_file
chmod -R 700 /home/${_USERNAME}/.ssh

for k in ${_SSHKEYS}/*; do
    cat $k >> $authorized_keys_file
done

# sudoers fix
sed s/__USER__/${_USERNAME}/g -i ${_SUDOERS}
