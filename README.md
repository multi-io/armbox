# Armbox -- Automated ADSL "Home Router" Setup and Image Creation

Based on Armbian and Routerbox (https://github.com/multi-io/routerbox).

Supports basic network configuration, WiFi access point setup,
iptables firewalling, DHCP and DNS for the local network, a separate
management interface and network, ADSL uplink connectivity, DynDNS
client setup.

Only fully implemented for the Lamobo R1 right now, but can be used as
a basis for creating images for other boards, as long as Armbian
supports them.

## Requirements

Vagrant.

## Basic Usage

```
# customize settings
$ cp userpatches/routerbox/vars_override/mine.yml.sample userpatches/routerbox/vars_override/mine.yml
$ vim userpatches/routerbox/vars_override/mine.yml  # edit settings for the image to be built
$ make  # build the image into output/images/
```

Run `make` to build an image into `output/images/`.

## Description

This repository is a fork of Armbian
(https://github.com/armbian/build); Routerbox is included via Git
subtree (https://git-scm.com/book/de/v1/Git-Tools-Subtree-Merging) at
userpatches/routerbox.

Armbian is used to set up the basic image, Routerbox is then used to
provision it. Routerbox is an Ansible playbook containing a bunch of
roles. It is integrated into Armbian as an image customization step
(`userpatches/customize-image-host.sh`), so it is used automatically
used to provision the image being built. It can also be used lateron
to re-provision the already running machine.


## BUGS

- proper starting order of networking, routing, firewall
  and adslconnection services
  

## TODOs (in no particular order)

- IPv6

- STUN

- /var not on SD card

- /var/log no space left on device

- configurable port forwardings

- avoid stateful wlan interface naming (udev)

- fix apparent race: networking-service[514]: RTNETLINK answers: Network is down

- remove unneeded services, verify wants vs. requires in various networking services

- user setup:

    - login user, option to disable root password ssh login

- DHCP on the management interface (2nd dnsmasq instance?)

- assignment of physical ethernet ports to networks (wan/lan/mgmt) configurable

- service executables in /usr/local/sbin
