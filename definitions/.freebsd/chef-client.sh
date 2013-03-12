#!/bin/sh -x

FILENAME=chef-11.4.0_0.freebsd.9.1-RELEASE.sh
INSTALLER=http://petecheslock.s3.amazonaws.com/${FILENAME}

fetch ${INSTALLER}
chmod +x ./${FILENAME}
sudo ./${FILENAME} --nox11
