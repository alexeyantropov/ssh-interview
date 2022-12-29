#!/bin/bash
docker exec -it $(docker ps | fgrep interview-env-example-1 | awk '{print $1}') bash
