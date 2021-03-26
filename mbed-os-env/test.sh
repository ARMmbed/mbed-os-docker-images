#!/bin/sh
set -x
MBED_OS_VERSION=$1
if [ "$(uname -m)" = "x86_64" ];then
	 exit 1
fi

            
# set -e 
# mbed import mbed-os-example-blinky
# cd mbed-os-example-blinky
# git checkout ${MBED_OS_VERSION}
# mbed deploy 
# mbed compile -m K64F -t GCC_ARM
# echo "::set-output name=STATUS::true"
