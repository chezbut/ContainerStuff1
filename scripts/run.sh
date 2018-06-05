#!/bin/bash

if [[ $(hostname) = *LT* ]]; then
    echo local-development
    ENVIRONMENT=development
fi

echo docker run -d -p 80:80/tcp --name nginx_test -e ENVIRONMENT=$ENVIRONMENT --hostname="`hostname`" --restart=unless-stopped nginx_test

docker run -d -p 80:80/tcp --name nginx_test -e ENVIRONMENT=$ENVIRONMENT --hostname="`hostname`" --restart=unless-stopped nginx_test
