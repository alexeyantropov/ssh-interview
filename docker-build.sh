#!/bin/bash
_DAEMONS='/daemons' 
build_args="--build-arg _DAEMONS=$_DAEMONS"

name='alexeyantropov/ssh-interview'
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
    docker build $build_args --tag ${name}:${tag} --tag ${name}:${latest_tag} docker/
    for task in tasks/*; do
        task_name=${name}_$(basename $task)
        #cat ${task}/Dockerfile | sed s/__LATEST_TAG__/$latest_tag/g > ${task}/Dockerfile.tmp
        docker build $build_args --tag ${task_name}:${tag} --tag ${task_name}:${latest_tag} --build-arg "_FROM_TAG=$latest_tag" ${task}/ 
    done
elif test $(basename $0) = "docker-run.sh"; then
    run_opts='--rm -it --privileged --cap-add=SYS_PTRACE --publish 0.0.0.0:22222:22'
    if test -z "$1"; then
        docker run $run_opts ${name}:${latest_tag}
    else
        docker run $run_opts ${name}_$(basename $1):${latest_tag}
    fi
else
    if test -z "$1"; then
        docker exec -it $(docker ps | fgrep ${name}:${latest_tag} | awk '{print $1}') bash
    else
        docker exec -it $(docker ps | fgrep ${name}_$(basename $1):${latest_tag} | awk '{print $1}') bash
    fi
fi