#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker build --rm --pull=true --no-cache -t nginx_test $DIR/../
docker exec nginx_test supervisorctl stop all
docker stop nginx_test; docker rm nginx_test;
bash $DIR/run.sh