#!/bin/bash
name='ssh-interview'
tag=$(date '+%Y%m%d-%H%M%S')

branch=$(git rev-parse --abbrev-ref HEAD)
retval=$?
if test $retval -ne 0; then
    echo "The 'git' executable isnt found!"
    exit 1
fi

if test "$branch" != "main"; then
    tag="${branch}-${tag}"
fi 

docker build --tag ${name}:${tag} docker/