#!/usr/bin/env sh

# ------------------------------------------------------------------------------
# Install tools via apt-get
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install git \
    wget \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-usb \
    python3-pip \
    software-properties-common \
    build-essential \
    astyle \
    mercurial \
    ninja-build \
    libssl-dev \
    cmake \
    srecord
apt-get clean
rm -rf /var/lib/apt/lists

# ------------------------------------------------------------------------------
# Set up mbed environment
cd /root
wget https://github.com/ARMmbed/mbed-os/raw/latest/requirements.txt
pip3 install -r requirements.txt

# ------------------------------------------------------------------------------
# Install Python modules (which are not included in requirements.txt)
pip3 install \
    'pyyaml>=5.1,<6.0' \
    mbed-cli \
    pyocd

# ------------------------------------------------------------------------------
# Install arm-none-eabi-gcc
TARBALL=""
ARCH="$(uname -m)"
if [ "$ARCH" = "aarch64" ]
then
    TARBALL="gcc-arm-none-eabi-9-2019-q4-major-aarch64-linux.tar.bz2"
else
    TARBALL="gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
fi

wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/$TARBALL
tar -xjf $TARBALL
rm $TARBALL
PATH="/root/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"
echo 'PATH="/root/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"' >> ~/.bashrc

# ------------------------------------------------------------------------------
# Display and save environment settings
python3 --version | tee env_settings
arm-none-eabi-gcc --version | tee -a env_settings
(echo -n 'mbed-cli' && mbed --version) | tee -a env_settings
(echo -n 'mbed-greentea ' && mbedgt --version) | tee -a env_settings
(echo -n 'mbed-host-tests ' && mbedhtrun --version) | tee -a env_settings
(echo -n 'pyocd ' && pyocd --version) | tee -a env_settings
