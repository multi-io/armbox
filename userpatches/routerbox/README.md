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

- port mappings

  - currently the DROP default policy of the FORWARD chain (set up in the firewall service,
    applied after the routing decision) will drop any packets coming in from the internet
    that had their target address rewritten in a prerouting rule from the router's
    external IP to an internal IP (which is what a port mapping rule would do -- example:
    `iptables -t nat -A PREROUTING -p tcp --dport 2022 -i ppp0 -j DNAT --to 192.168.142.16:22`)

    Changing the default policy to ACCEPT would be the easiest way to let those packets
    through and make port mapping work. Are there any security implications to this? The
    DROP policy was meant to fend off any packets coming in from the internet with target
    addresses in the LAN, i.e. a rfc1918 range. Would anyone actually be able to construct such
    packets?

- IPv6

- STUN

- /var not on SD card

- /var/log no space left on device

- configurable port forwardings

- clean up systemd network target dependencies of services

- user setup:

    - login user, option to disable root password ssh login

- DHCP on the management interface (2nd dnsmasq instance?)

- assignment of physical ethernet ports to networks (wan/lan/mgmt) configurable

- service executables in /usr/local/sbin

- Prometheus monitoring
