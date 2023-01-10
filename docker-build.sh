#!/bin/bash
name='ssh-interview'
tag=$(date '+%Y%m%d-%H%M%S')

docker build --tag ${name}:${tag} docker/