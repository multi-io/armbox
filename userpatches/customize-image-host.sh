#!/bin/sh

#!/bin/sh

set -e

# the , after the chroot location is vital...otherwise ansible bails out somehow
ansible-playbook -c chroot  -i "$CACHEDIR/$SDCARD", "${SRC}/userpatches/routerbox/setup.yml"
