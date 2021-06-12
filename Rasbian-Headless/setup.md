#All Pi's - SD Card image
- Follow https://www.raspberrypi.org/documentation/installation/installing-images/ instructions for creating the Pi SD card

#All Pi's - Wifi and SSH
- Add 'SSH' and wpasupplicant.conf files to root (boot in windows) folder of the MicroSD card
- copy/ edit (with wifi info) wpa_supplicant.conf to root folder

#Pi Zero and Zero W - USB connex
- open config.txt and add 'dtoverlay=dwc2' at the bottom of the file and save
- Open cmdline.txt and add the text 'modules-load=dwc2,g_ether' after the word rootwait, and save the file. There are no linebreaks in this file
- (On Windows) download and install Bonjour Print Services - connect via Putty to raspberrypi.local

#Disable IPv6 - LIKELY NOT REQUIRED - 
- create /etc/sysctl.d/local.conf 
- add line 'net.ipv6.conf.all.disable_ipv6=1'

#replace apt repository
- replacing raspbian.raspberrypi.org in /etc/apt/sources.list with a local mirror;
- 'deb http://mirror.ox.ac.uk/sites/archive.raspbian.org/archive/raspbian buster main contrib non-free rpi'
- mirrors: https://www.raspbian.org/RaspbianMirrors/

#install git
- sudo apt install git

#python3 as default
- Open .bashrc file 'nano ~/.bashrc'. Type alias python=python3 on to a new line at the top
- type 'source ~/.bashrc'
