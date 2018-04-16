# Routerbox

This is an Ansible playbook for setting up a simple ADSL home router.

Primarily used for in https://github.com/multi-io/armbox for now,
but can be used to set up other machines, including non-ARM ones.

Supports basic network configuration, WiFi access point setup,
iptables firewalling, DHCP and DNS for the local network, a separate
management interface and network, ADSL uplink connectivity, DynDNS
client setup.

Some roles are tailored to the Lamobo R1 right now (this concerns
network interface names primarily), but can be used as a basis for
setting up other kinds of machines.

## Systemd Networking Units

(TODO)

See also https://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/

`network.target` indicates that the network management stack is up.

`network-online.target` indicates that the local LAN is up and
running, including routing and firewalling. Internet connectivity
(adslconnection.service) is not required by this unit (but in fact
requires it).

`network-pre.target` unused atm.

Right there is this sequence of unit activations:

networking.service -> routing.service -> firewall.service -> network-online.target -> adslconnection.service

Maybe we can start firewall.service earlier (in parallel with
routing.service) if it doesn't require the interfaces it configures to
exist.

## TODOs

- variables refactoring:

  - variables/pre/*yml
  - variables/board/$BOARD.yml
  - variables/post/*yml

  The pre and post directories each contain a 10-defaults.yml for
  pre-defined settings, the user may add other *yml files. All *.yml
  files in a diretory will be executed in alphabetical order (via
  include_vars). We first run everything in pre/, the
  board/$BOARD.yml, then everythin in post.

  pre/ would usually contain board-independent settings like hostname,
  ssh keys, public IP address etc. $BOARD.yml would contain
  board-specific variable settings, e.g. switchports, and is free to
  use variables from pre/. post/ will contain variables thay may be
  set to override board default settings.

- port mappings: UDP support

  - probably(?) can't be done via masquerading, must use separate
    iptables rule to statelessly rewrite of the source address & port
    of outgoing packets to the public-facing endpoint (requires
    changing the rule whenever the public IP changes)
  
- IPv6

- STUN

- /var not on SD card

- /var/log no space left on device

- clean up systemd network target dependencies of services

- user setup:

    - login user, option to disable root password ssh login

- DHCP on the management interface (2nd dnsmasq instance?)

- assignment of physical ethernet ports to networks (wan/lan/mgmt) configurable

- service executables in /usr/local/sbin
