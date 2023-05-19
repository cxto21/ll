**deactivate cups service**
```.sh
systemctl disable cups cups.service cups.socket cups.path
sudo apt-get remove --purge cups
sudo rm -rf cups-browsed.service cups.path cups.service cups.socket
sudo rm -rf /etc/cups
sudo rm -rf /etc/cupshelpers
```
**setting connections**
```.sh
# Example: Enabling and deny (CUPS) port
sudo ufw enable # 
sudo ufw deny 631
sudo ufw status numbered
sudo ufw reload
```
```.generative_wath
Unidades de almacenamiento distribuídos en red
**generative**
```.
oo   Nothing More Here.
		Changes of season,.. 
	-- 
	Soso- good se se siente bien
	rico caramelo que me comí recién
	ven zen fortalece vuelve al ver
```




