# mbed-OS development environment docker image

This docker image is the official Mbed OS development environment.
* It is based on ubuntu 20.04
* Python 3 is installed
* arm-none-eabi-gcc toolchain is installed
* pyOCD is installed
* Latest released version of Mbed CLI and GreenTea are installed
* All other Mbed OS dependency tools are installed

# How to use docker image:

## Pull docker images
```bash
docker pull mbedos/mbed-os-env

```

## Run Mbed OS environment without HW support (build mbed images only)
launch docker by
```bash
docker run -it mbedos/mbed-os-env:<lable>
```
Then you will have the container with mbed OS development environment.
you should be able to compile mbed commands/examples as recommenced in mbed documentations
e.g.
```bash
mbed import --no-requirements mbed-os-example-blinky
cd mbed-os-example-blinky
mbed compile -m <TARGET> -t GCC_ARM
```

## Run Mbed OS environment with HW support (USB pass-through)
If you want to use this docker container connect and flash your targets. you need some extra command line option to pass-through your USB devices.
```bash
sudo docker run -it --privileged -v /dev/disk/by-id:/dev/disk/by-id -v /dev/serial/by-id:/dev/serial/by-id mbed-os-env:<label>
```
Then you will have the container with mbed OS development environment.
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```
To make sure your mbed targets been detected, you might want to manually run the mount command and `mbedls` to check
```bash
mount /dev/sdb /mnt
mbedls
```
if `mbedls` detected  your connected target, then you should be able to run mbed tests/examples as recommenced in mbed documentations
``` bash
mbed clone https://github.com/ARMmbed/mbed-os.git
cd mbed-os
mbed test -t GCC_ARM -m <target> 
```

# Development

## Build docker image locally

```bash
./docker-build.sh
```

## Run docker image locally
```bash
./docker-run.sh
```