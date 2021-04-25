# Routerbox

This is an Ansible playbook for setting up a simple ADSL home router.

Primarily used for https://github.com/multi-io/armbox for now,
but can be used to set up other machines, including non-ARM ones.

Supports basic network configuration, WiFi access point setup,
iptables firewalling, DHCP and DNS for the local network, a separate
management interface and network, ADSL uplink connectivity, DynDNS
client setup.

Some roles are tailored to the Lamobo R1 right now (this concerns
network interface names primarily), but can be used as a basis for
setting up other kinds of machines.

## Basic Usage

```
# customize settings
$ cp config/postproc/99-mine.yml.sample config/postproc/99-mine.yml
$ vim config/postproc/99-mine.yml  # edit settings
$ vim inventory.running-machine  # adapt IP if necessary
# board must be one from config/board/.
$ ansible-playbook -e board=clearfogpro -i inventory.running-machine setup.yml
```

## Variables

  Conifguration happens entirely via variables; the Ansible code is written to
  work for all variables and boards.

  There's these variables, in the order of execution:

  - config/general/*yml
  - config/board/$BOARD.yml
  - config/postproc/*yml

  In the `config/general/` and `config/postproc/` directories, the files will
  be executed in alphabetical order (via `include_vars`). The user may add
  other *yml files, which should usually be named something like `99-mine.yml`.
  We first run everything in `config/general/`, then `board/$BOARD.yml`, then
  everything in `config/postproc/`.

  config/general/ would usually contain board-independent settings like
  hostname, ssh keys, public IP address etc. $BOARD.yml would contain
  board-specific variable settings, e.g. switchports, and is free to
  use variables from config/general/. config/postproc/ will contain
  variables that may be set to override board default settings.

## Systemd Networking Units

(TODO)

See also https://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/

`network.target` indicates that the network management stack is up.

`network-online.target` indicates that the local LAN is up and
running, including routing and firewalling. Internet connectivity
(adslconnection.service) is not required by this unit (but in fact
requires it).

`network-pre.target` unused atm.

Right now there is this sequence of unit activations:

networking.service -> routing.service -> firewall.service -> network-online.target -> adslconnection.service

Maybe we can start firewall.service earlier (in parallel with
routing.service) if it doesn't require the interfaces it configures to
exist.

## TODOs

- port mappings: UDP support

  - probably(?) can't be done via masquerading, must use separate
    iptables rule to statelessly rewrite of the source address & port
    of outgoing packets to the public-facing endpoint (requires
    changing the rule whenever the public IP changes)
  
- IPv6

- STUN

- /var not on SD card

- clean up systemd network target dependencies of services

- user setup:

    - login user, option to disable root password ssh login

- DHCP on the management interface (2nd dnsmasq instance?)

- assignment of physical ethernet ports to networks (wan/lan/mgmt) configurable

- service executables in /usr/local/sbin
