# 
## **Installing whois**
```.sh
#add whois
sudo apt-get install whois
```


**Installing iwlwifi firmware:**
```.sh
#add non-free in the apt sources.list
#firmware-iwlwifi is a non-free software.
sudo sed -i 's/main/& contrib non-free/' /etc/apt/sources.list
sudo apt update
sudo apt install firmware-iwlwifi
```
**Installing nvidia drivers** 
```.sh
#add nvidia-detect
sudo apt-get install nvidia-detect
#add tesla 470 for suggestion to run 'nvidia-detect'
sudo apt-get install nvidia-tesla-470-driver
```
**Installing ufw**
```.sh
#add non-free in the apt sources.list
sudo apt-get install ufw
```
**Installing translate-shell**
```.sh
#add trans command to translate via terminal
sudo apt-get install translate-shell
```
**Installing Git:**
```.sh
sudo apt-get install git
```
**Installing python3-venv**
```.sh
sudo apt-get install python3-venv
```

**Installing Poetry:**
```.anulated_x.sh
curl -sSL https://install.python-poetry.org | python3 -
```
**Installing tk-inter**
```.sh
sudo apt-get install python3-tk
```

```.sh
#macchanger: 
sudo apt-get install macchanger
```

**Installing Brave Browser:**
```.sh
sudo apt install apt-transport-https curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
```

### **Installing terminator**
```.sh
sudo apt-get install terminator
```
*enable the ctrl+shift+e key setting for splitting vertically:*
- open ibus configuration program: '> ibus-setup'
- inside emoji section delete correspondent keybrinds on anotation emoji

**Installing xdotool**
```.sh
#With xdotool we can generate keyboard signal 
sudo apt-get install xdotool
```

**Installing zsh**
```.sh
sudo apt-get install zsh

```

**Installing ohmyzsh**
```.sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```


**Installing xsel**
```.sh
#with xsel we can manipulate the X selection
sudo apt-get install xsel
## adding pbcopy and pbpaste:
#alias pbcopy='xsel --clipboard --input'
#alias pbpaste='xsel --clipboard --output'

```
 
**Installing ffmpeg**
```.sh
ffmpeg allow manipulate and convert audio and video
sudo apt-get install ffmpeg
```
# Process
```.sh
#htop
sudo apt-get install htop
```

# Network utilities
```.sh
#nmap: 
sudo apt-get install nmap
```

```.sh
#tcpdump: dump network packages
sudo apt-get install tcpdump
```

```.sh
#wireshark: graphicall network monitor
sudo apt-get install wireshark
```
