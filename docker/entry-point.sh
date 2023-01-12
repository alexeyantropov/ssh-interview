#!/bin/bash -x
for i in _SSHKEYS _USERNAME _SUDOERS _PASSWORD_AUTH _DAEMONS; do
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
authorized_keys_file="/home/${_USERNAME}/.ssh/authorized_keys"
touch $authorized_keys_file
chmod -R 700 /home/${_USERNAME}
chown -R ${_USERNAME}:${_USERNAME} /home/${_USERNAME}

for k in ${_SSHKEYS}/*; do
    cat $k >> $authorized_keys_file
done

# sudoers fix
sed s/__USER__/${_USERNAME}/g -i ${_SUDOERS}

# try to run daemons
for daemon in ${_DAEMONS}/*; do
    echo " * The daemon $daemon is found. I'll try to run it in background"
    $daemon &
done

# setup user's password if avaible
if test ${_PASSWORD_AUTH^^} = 'YES'; then
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config 
    user_password=$(openssl rand -hex 20)
    echo $user_password | passwd $_USERNAME --stdin
    echo -ne "\n* Password auth is enabled, password for the user \"$_USERNAME\": ${user_password} *\n\n"
else
    echo -ne '\n* Password auth is disabled, you have to use ssh-keys *\n\n'
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config 
fi

# show the ip of container
echo -ne "\n* Container IP is $(ifconfig | grep inet | grep -v 127.0.0.1 | awk '{print $2'}) *\n\n"

# run ssh server
/usr/bin/ssh-keygen -A && /usr/sbin/sshd -D -e
