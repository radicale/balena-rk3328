#!/bin/bash

losetup -fP build/tmp/deploy/images/heltec-m2808/balena-image-heltec-m2808.balenaos-img
sudo mount /dev/loop2p1 ~/mnt
jq . /mnt/d/helium-heltec.testdevice.config.json | sudo tee /home/radical/mnt/config.json
sudo umount /dev/loop2p1
losetup -d /dev/loop2
cp build/tmp/deploy/images/heltec-m2808/balena-image-heltec-m2808.balenaos-img /mnt/d

