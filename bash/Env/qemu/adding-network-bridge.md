[SUSE-LIBVIRT-NETWORKING-DOC](https://documentation.suse.com/sles/15-SP1/html/SLES-all/cha-libvirt-networks.html)
1. Create with:
		- 'sudo ip link add name VIRBR_TEST type bridge'
2. Destroy with:
		- 'sudo ip link delete VIRBR_TEST
3. List with:
		- sudo ip link list
4. Bring the network bridge up and add a network interface to the bridge:
		- sudo ip link set VIRBR_TEST up
		- sudo ip link set enp4s0 master VIRBR_TEST
5. Enable STP
		- sudo bridge link set dev VIRBR_TEST cost 4
		

[NETWORKING-natConfiguration-IP-Tables](https://wiki.qemu.org/Documentation/Networking/NAT)

- 
