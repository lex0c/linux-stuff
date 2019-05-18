#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Permission denied"
    exit 1
fi

##############################################
######## REMOVE UNNECESSARY PROGRAMS #########
##############################################

if which telnet; then
    sudo apt-get purge -y telnet
fi

if which netcat-openbsd; then
    sudo apt-get purge -y netcat-openbsd
fi

if which netcat-traditional; then
    sudo apt-get purge -y netcat-traditional
fi

if which ftp; then
    sudo apt-get purge -y ftp
fi

if which samba; then
    sudo apt-get purge -y samba
fi

if which nft; then
    sudo apt-get purge -y nftables
fi

if which rhythmbox; then
    sudo apt-get purge -y rhythmbox
fi

if which brasero; then
    sudo apt-get purge -y brasero
fi


##############################################
############### SYSTEM UPDATES ###############
##############################################

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y

##############################################
################## INSTALLS ##################
##############################################

if !which iptables; then
  sudo apt-get install -y iptables
fi

if !which ruby; then
  sudo apt-get install -y ruby-full
fi

if !which node; then
  sudo curl -sL https://deb.nodesource.com/setup_10.x | bash -
  sudo apt-get install -y nodejs
  sudo apt-get install -y build-essential
fi

if !which curl; then
  sudo apt-get install -y curl
fi

if !which docker; then
  sudo curl -sS https://get.docker.com | sh
fi

if !which vim; then
  sudo apt-get install -y vim
fi


##############################################
######### SETTING SECURITY POLICIES ##########
##############################################

if which iptables; then
  # Blocks ping response
  iptables  -I  INPUT  -i  ech0  -p   icmp  -s  0/0  -d  0/0   -j  DROP
  # Set the default policy of the INPUT chain to DROP
  iptables -P INPUT DROP
  iptables -P FORWARD DROP
  iptables -P OUTPUT ACCEPT
  # Accept incomming TCP connections from eth0 on port 80 and 443
  iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
  iptables -A INPUT -i eth0 -p tcp --dport 443 -j ACCEPT
  iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
fi

##############################################
################ DOCKER CONFIG ###############
##############################################

if which docker; then
  sudo groupadd docker
  sudo usermod -aG docker $USER
fi

##############################################
################# COPY FILES ###W#############
##############################################

cp .vimrc ~/
cp .bash_aliases ~/


echo "Ok!"
exit 0
