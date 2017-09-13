#!/bin/sh

for branch in default next; do
  sudo umount -l /home/ubuntu/.tmp/rootfs-${branch}-lamobo-r1-jessie-no/tmp/overlay
  sudo umount -l /home/ubuntu/.tmp/rootfs-${branch}-lamobo-r1-jessie-no
done
