# Routerbox

This is an Ansible playbook for setting up a simple ADSL home router.

Primarily used for in https://github.com/multi-io/routerbox for now,
but can be used to set up other machines, including non-ARM ones.

Supports basic network configuration, WiFi access point setup,
iptables firewalling, DHCP and DNS for the local network, a separate
management interface and network, ADSL uplink connectivity, DynDNS
client setup.

Some roles are tailored to the Lamobo R1 right now (this concerns
network interface names primarily), but can be used as a basis for
setting up other machines.


## TODOs

- IPv6

- /var not on SD card

- /var/log no space left on device

- configurable port forwardings

- clean up systemd network target dependencies of services

- user setup:

    - login user, option to disable root password ssh login

- DHCP on the management interface (2nd dnsmasq instance?)

- assignment of physical ethernet ports to networks (wan/lan/mgmt) configurable

- service executables in /usr/local/sbin
