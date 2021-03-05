# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:20.04

# ------------------------------------------------------------------------------
# Arguments
ARG WORKDIR=/root

# ------------------------------------------------------------------------------
# Install tools via apt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y update && \
    apt -y install git \
    wget \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-usb \
    python3-pip \
    software-properties-common \
    build-essential \
    cmake \
    astyle \
    mercurial \
    ninja-build \
    libssl-dev \
    cargo \
    && apt clean && rm -rf /var/lib/apt/lists

# Cmake (Mbed OS requires >=3.19.0-rc3 version which is not available in Ubuntu 20.04 repository)
RUN set -x \
    && (cd /tmp \
    && [ "$(uname -m)" = "aarch64" ] && \
        CMAKE_SCRIPT="cmake-3.19.3-Linux-aarch64.sh" || \
        CMAKE_SCRIPT="cmake-3.19.3-Linux-x86_64.sh" \  
    && wget --progress=dot:giga https://github.com/Kitware/CMake/releases/download/v3.19.3/${CMAKE_SCRIPT} \
    && sh ${CMAKE_SCRIPT} --exclude-subdir --prefix=/usr/local \
    && rm -rf ${CMAKE_SCRIPT}) \
    && exec bash \
    && : # last line

# ------------------------------------------------------------------------------
# Install Python modules (which are not included in requirements.txt)
RUN pip3 install -U \
    mbed-cli \
    mbed-tools

# Set up mbed environment
WORKDIR /tmp/
RUN wget https://github.com/ARMmbed/mbed-os/raw/master/requirements.txt && \
    pip3 install -r requirements.txt && \
    rm requirements.txt

# ------------------------------------------------------------------------------
# Install arm-none-eabi-gcc
WORKDIR /opt/mbed-os-toolchain
RUN [ "$(uname -m)" = "aarch64" ] && \
        TARBALL="gcc-arm-none-eabi-9-2019-q4-major-aarch64-linux.tar.bz2" || \
        TARBALL="gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2" && \
    wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/${TARBALL} && \
    tar -xjf ${TARBALL} && \
    rm ${TARBALL}

# ------------------------------------------------------------------------------
# Configure mbed build system
RUN set -x \
    && mbed config -G GCC_ARM_PATH /opt/mbed-os-toolchain/gcc-arm-none-eabi-9-2019-q4-major/bin/ \
    && mbed toolchain -G -s GCC_ARM \
    && : # last line

# ------------------------------------------------------------------------------
# Configure environment variables
ENV MBED_GCC_ARM_PATH=/opt/mbed-os-toolchain/gcc-arm-none-eabi-9-2019-q4-major/bin/
ENV PATH="${PATH}:${MBED_GCC_ARM_PATH}"

# ------------------------------------------------------------------------------
# Display and save environment settings
RUN python3 --version | tee env_settings && \
    arm-none-eabi-gcc --version | tee -a env_settings && \
    (echo -n 'mbed-cli ' && mbed --version) | tee -a env_settings && \
    (echo -n 'mbed-greentea ' && mbedgt --version) | tee -a env_settings && \
    (echo -n 'mbed-host-tests ' && mbedhtrun --version) | tee -a env_settings
