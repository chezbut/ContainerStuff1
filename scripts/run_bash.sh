#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run -it --rm -e ENVIRONMENT="localdev" nginx_test bash
