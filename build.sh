#!/bin/bash

# Install & upgrade packages
pkg update
pkg upgrade

pkg install git make cmake pass gnupg zlib golang \
            pkg-config libpcsclite hidapi libsecret

# Setup GPG
gpg --full-generate-key
gpg --list-secret-keys

pass init $(\
    gpg --list-secret-keys | grep ^sec -A1 |\
    tail -n1 | sed -e 's/^[[:space:]]*//' \
)
printf "\n\n" | pass insert test/test

# Download & build libcbor
git clone https://github.com/PJK/libcbor.git
cd libcbor

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_BUILD_TYPE=Release ..

make
make install

cd ../..
rm -rf libcbor

# Download, patch, & build libfido2
git clone https://github.com/Grimler91/termux-packages.git
cd termux-packages

git switch usb-libfido2
cd ..

git clone https://github.com/Yubico/libfido2.git
cd libfido2

git apply ../termux-packages/packages/libfido2/*.patch

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DUSE_HIDAPI=ON -DHIDAPI_SUFFIX="-libusb" \
      -DBUILD_EXAMPLES=OFF -DBUILD_STATIC_LIBS=OFF ..

make
make install

cd ../..
rm -rf libfido2 termux-packages

# Download & build proton-bridge (free use fork)
git clone https://github.com/mnixry/proton-bridge.git
cd proton-bridge

make build-nogui
