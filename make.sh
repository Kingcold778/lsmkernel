#!/bin/bash
if [ ! -f certs/signing_key.pem ]; then
	echo "Generating new key."
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out certs/signing_key.pem -days 9999
fi
export USER=build
make \
ARCH=arm \
CROSS_COMPILE=gcc-linaro-7.1.1/bin/arm-linux-gnueabihf- \
EXTRA_CFLAGS=-w
cp arch/arm/boot/zImage AnyKernel2/
cd AnyKernel2/ && zip ../lsm-anykernel.zip $(ls) -r &>/dev/null
echo "Installer zip created @ 'lsm-anykernel.zip'!"

