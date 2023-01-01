#!/bin/bash

# apt-get install --yes ansible  # too old

apt update
apt install --yes python3-pip python-is-python3

# lib/functions/host/prepare-host.sh may have rewritten the symlink to point to python2.7, the apt install above wouldn't have fixed that
# if this turns out to be problematic, we might use a python3 venv instead
ln -fs /usr/bin/python3 /usr/bin/python

ans_dir=/root/ansible
if [ ! -d "$ans_dir" ]; then
    git clone --depth 1 --branch armbox https://github.com/multi-io/ansible.git "$ans_dir"
    pip install -r "$ans_dir/requirements.txt"
fi
source "$ans_dir/hacking/env-setup"

# needed for the -c chroot (chroot connection plugin)
ansible-galaxy collection install community.general

# the , after the chroot location is vital...otherwise ansible bails out somehow
ansible-playbook ${ANSIBLE_PARAMS} -c chroot -e board=${BOARD}  -i "$SDCARD", "${SRC}/userpatches/routerbox/setup.yml"
ROUTERBOX_RC=$?
if [[ $ROUTERBOX_RC != 0 ]]; then
	exit_with_error "Routerbox Ansible exited with error (rc: $ROUTERBOX_RC)"
fi
