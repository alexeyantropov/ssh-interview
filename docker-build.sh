#!/bin/bash
name='ssh-interview'
tag=$(date '+%Y%m%d-%H%M%S')
latest_tag='latest'

branch=$(git rev-parse --abbrev-ref HEAD)
retval=$?
if test $retval -ne 0; then
    echo "The 'git' executable isnt found!"
    exit 1
fi

if test "$branch" != "main"; then
    tag="${branch}-${tag}"
    latest_tag="${branch}.latest"
fi 

if test $(basename $0) = "docker-build.sh"; then
    docker build --tag ${name}:${tag} --tag ${name}:${latest_tag} docker/
elif test $(basename $0) = "docker-run.sh"; then
    docker run --rm -it --cap-add=SYS_PTRACE ${name}:${latest_tag}
else
    docker exec -it $(docker ps | fgrep ${name}:${latest_tag} | awk '{print $1}') bash
fi