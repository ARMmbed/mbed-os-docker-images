#!/usr/bin/env sh

set -e

PORT="8080"
WORKSPACE=${@:-$HOME}
PROJECT_DIR="/work/$(basename $WORKSPACE)"

PARAMS="$PARAMS -it --rm"
PARAMS="$PARAMS -v $WORKSPACE:$PROJECT_DIR"
PARAMS="$PARAMS -p $PORT:8080"
PARAMS="$PARAMS -w $PROJECT_DIR"

docker run $PARAMS mbed/mbed-os-env-cmake
