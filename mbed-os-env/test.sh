#!/bin/sh
set -x
MBED_OS_VERSION=$1
if [ "$(uname -m)" = "x86_64" ];then
	 exit 1
fi
