#!/bin/sh
set -x
MBED_OS_VERSION=$1
mbed import mbed-os-example-blinky
cd mbed-os-example-blinky
git checkout ${MBED_OS_VERSION}
mbed deploy 
mbed compile -m K64F -t GCC_ARM
mbed-tools compile -m K64F -t GCC_ARM
