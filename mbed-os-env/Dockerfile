# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:18.04

# ------------------------------------------------------------------------------
# Arguments
ARG WORKDIR=/root

# ------------------------------------------------------------------------------
# Install base
RUN apt -y update && apt -y dist-upgrade

# ------------------------------------------------------------------------------
# Install tools via apt
RUN apt -y install git \
    wget \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-usb \
    python3-pip \
    software-properties-common \
    build-essential \
    cmake \
    && apt-get clean && rm -rf /var/lib/apt/lists


# ------------------------------------------------------------------------------
# Install Python modules (which are not included in requirements.txt)
RUN pip3 install -U mbed-cli

# Set up mbed environment
WORKDIR /root/
RUN git clone https://github.com/ARMmbed/mbed-os.git && \
    cp mbed-os/requirements.txt . && \
    rm -rf mbed-os
RUN pip3 install -r requirements.txt

# ------------------------------------------------------------------------------
# Install arm-none-eabi-gcc
WORKDIR /root/
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 && \
    tar -xjf gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 && \
    rm gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
ENV PATH="/root/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"


# ------------------------------------------------------------------------------
# Display and save environment settings
RUN python3 --version | tee env_settings && \
    arm-none-eabi-gcc --version | tee -a env_settings && \
    (echo -n 'mbed-cli ' && mbed --version) | tee -a env_settings && \
    (echo -n 'mbed-greentea ' && mbedgt --version) | tee -a env_settings && \
    (echo -n 'mbed-host-tests ' && mbedhtrun --version) | tee -a env_settings

WORKDIR /root
