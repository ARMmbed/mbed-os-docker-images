#!/usr/bin/env sh

set -e

docker build "$@" -t mbed/mbed-os-env-cmake .
