- https://documentation.suse.com/sles/15-SP1/html/SLES-all/cha-libvirt-networks.html
- incorporate the guest on the local network. NatBox is required.

***
[ES]
Hay dos partes de configuración de red con QEMU.
1. El dispositivo de red virtual proveido por el huesped.
2. El backend de la red que interactua con el NIC emulado. (pone paquetes en la red del host)

Existe una variedad de opciones de configuración para cada parte. Por defecto QEMu crea SLiR  como backend de la red de usuario y un dispositivo de red virtual apropiado para el invitado.

*Crear un backend de red* depende el entorno. Será algo como '-netdev TYPE, id=NAME,....' el id será la manera en la que el dispositivo y el backend de red se asocian Si se desean multiples dispositivos virtuales de red en el mismo invitado, cada uno deberá tener su propio backend de red. El nombre es usado para distingui backends de cada uno y debe ser usado incluso cuando solo un backend de red sea especificado.  

**User Networking (SLIRP):**
Este es el backend de red por defecto y generalmente es facil de usar porque no requiere privilegios de root. 
***

**Network Interface Card (NIC):**
*La tarjea de interfaz de red es un componente de hardware que permite conectar un  ordenador a una red informática y posibilita el compartir los recursos en una red de ordenadores.*
*Un conmutador de red reenvía datos entre dispositivos a diferencia de un enrutador que reenvía datos entre redes.*
El componente principal de las redes de **libvirt** son los "Switch-Virtuales", conmutador de red virtual, al que las máquinas se conectarán a los vNIC de estas.

# Ficheros de configuración de redes en libvirt

Los ficheros de configuración de las redes los encontraremos en 'etc/libvirt/qemu/networks/*.xml'

[source: https://www.pinguytaz.net/index.php/2021/08/13/usando-qemu-kvm-con-libvirt-3-x-redes-virtuales/]


# Virsh - Administrando la interfaz de usuario

## Connect a virtualized system with qemu to the same network as the host using virsh
**create net using xml file:**
- arg: --file <file-name>
- ex: net-create --file net-90labs


## Example of XML file
```.xml
<network>
  <name>examplenetwork</name>
  <bridge name="virbr100" />
  <forward mode="route" />
  <ip address="10.10.120.1" netmask="255.255.255.0" />
</network>
```

*acclarations:*
forward mode:
- bridge: Una red con puente comparte un dispositivo ethernet real con las máquinas virtuales VM, estas máquinas tendrán una OP de la LAN como si de una máquina física se tratara.
- nat: Todo el tráfico entre los invitados conectados a esta red y la red física se reenviará a la red física a través de la pila de enrutamiento IP del host después de que la dirección IP del invitado se traduzca para que aparezca como la dirección pública de la máquina host (NAT). La configuración en forward nat permite múltiples invitados todos accediendo a la red física en un host al que se le permite una única dirección IP pública. Si una red tiene direcciones IPV6 definidas, el tráfico IPv6 se reenviará mediante enrutamiento simple ya que ipv6 no tiene el concepto de nat. Las reglasl del cortafuego permitirán conexiones salientes a cualquier otro dispositivo de red, ya sea ethernet, inalámbrico, de acceso telefónico o VPN. Si se establece el atributo dev, las reglas del firewall restrigngiran el reenvio solo al dispositivo designado.


- route: El tráfico de la red de invitados se reenviará a la red física a traves de la pila de enrutamiento de IP del host, pero sin que se aplique NAT. Nuevamente, sis es establece el atributo dev, las reglas del firwall restringirán el reenvío solo al dispositivo designado. Esto supone que las rutas LAN locales tienen una tabla de enrutamiento adecuada.a

- open: Al igual que con el modo de ruta, el trafico de la red de invitados se reenviará a la red física a través de la pila de enrutamiento d eIP del host, pero no se agregarán reglas de firwall para habilitar o evitar este tráfico cuando se establece forward='open'

- isolated: Nos permite crear una red privada entre el hipervisor y las máquinas virtuales
- SR-IOV: Dispositivo PCI directamente, logrando una red nativa en la máquina virtual.
- MacVtap: se utiliza para permitir que usuarios de la red Local se conecten a lasmáquinas virtuales pero no deseamos crear un puente

## Comandos virsh cli
- net-list (--all): Listado de las redes configuradas y sus estados.
- net-dumpxml volcamos la configuración cml de nuestra red por defecto
- net-edit <red> para editar la configuración, desde virt-manager también se puede en modo texto
- net-info <red> informaión de la red. Podemos ver el dispositivo de switch-virtual que utiliza
- net-start, net-destroy, net-autostart <red>

al crear la red libvirt creará reglas iptables para permitir que el tráfico al dispositivo virtual de virbrX. cadenas input, output, forward y postrouting, habilitará ip_forward, en caso de que no se habilite o alguna aplicación los inhabilite lo podemos activar modificando el fichero '/etc/sysctl.conf' poniendo la linea net.ip4.ip_forward=1  

Para ppermitir que conexiones del exterior ingresen a nuestra máquina invitada debemos redirigir desde nuestra anfitriona. Para esto editaremos '/etc/libvirt/hooks/qemu' con permiso de ejecución (porque es un script) con el código de la redirección a realizar:
```.sh
#!/bin/bash
# IMPORTANT: Change the "VM NAME" string to match your actual VM Name.
# In order to create rules to other VMs, just duplicate the below block and configure
# it accordingly.
If [ "${1}" = "<NOMBRE_MAQUINA>" ]; then
   IP_INVITADA=<IP MAQUINA INVITADA>
   PUERTO_INVITADA=<PUERTO INVITADA DE RECEPCIÓN>
   PUERTO_ANFITRION=<PUERTO ANFITRION A RENVIAR>

   if [ "${2}" = "stopped" ] || [ "${2}" = "reconnect" ]; then
	/sbin/iptables -D FORWARD -o <INTERFAZ SwitchVirtual> -p tcp -d $IP_INVITADA --dport $PUERTO_INVITADA -j ACCEPT
	/sbin/iptables -t nat -D PREROUTING -p tcp --dport $PUERTO_ANFITRION -j DNAT --to $IP_INVITADA:$PUERTO_INVITADA
   fi
   if [ "${2}" = "start" ] || [ "${2}" = "reconnect" ]; then
	/sbin/iptables -I FORWARD -o <INTERFAZ SwitchVirtual> -p tcp -d $IP_INVITADA --dport $PUERTO_INVITADA -j ACCEPT
	/sbin/iptables -t nat -I PREROUTING -p tcp --dport $PUERTO_ANFITRION -j DNAT --to $IP_INVITADA:$PUERTO_INVITADA
   fi
fi
```

## Modo enrutado
En el modo enrutado podemos hacer que los sistemas virtualizados estén en una subred del anfitrion pero no sean vistas por máquinas de la red del anfitrión, por lo tanto si queremos que las máquinas de la red local (del anfitrion )vean a las maquinas virtuales sería necesario configurar reglas en los routers de la red física para que conozcan la subred.


 
