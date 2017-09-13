#!/bin/sh

set -e

# apt-get install --yes ansible  # too old

apt-get install --yes python-pip
ans_dir=/root/ansible
if [ ! -d "$ans_dir" ]; then
    git clone --branch myintegration https://github.com/multi-io/ansible.git "$ans_dir"
    pip install -r "$ans_dir/requirements.txt"
fi
source "$ans_dir/hacking/env-setup"

# the , after the chroot location is vital...otherwise ansible bails out somehow
ansible-playbook -c chroot  -i "$CACHEDIR/$SDCARD", "${SRC}/userpatches/routerbox/setup.yml"
