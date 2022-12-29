#!/bin/bash

set -e

# apt-get install --yes ansible  # too old

apt update
apt install --yes python3-pip python-is-python3

ans_dir=/root/ansible
if [ ! -d "$ans_dir" ]; then
    git clone --depth 1 --branch armbox https://github.com/multi-io/ansible.git "$ans_dir"
    pip install -r "$ans_dir/requirements.txt"
fi
set +e
source "$ans_dir/hacking/env-setup"
set -e

# needed for the -c chroot (chroot connection plugin)
ansible-galaxy collection install community.general

# the , after the chroot location is vital...otherwise ansible bails out somehow
ansible-playbook ${ANSIBLE_PARAMS} -c chroot -e board=${BOARD}  -i "$SDCARD", "${SRC}/userpatches/routerbox/setup.yml"
