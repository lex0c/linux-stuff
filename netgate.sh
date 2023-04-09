#!/bin/sh

if [ $# -eq 4 ]; then
  sudo iptables -$1 INPUT -j $2
  sudo iptables -$1 OUTPUT -j $3
  sudo iptables -$1 FORWARD -j $4
fi

if [ $# -eq 5 ]; then
  sudo iptables -$1 INPUT -s "$5" -j $2
  sudo iptables -$1 OUTPUT -d "$5" -j $3
fi

if [ $# -eq 6 ]; then
  sudo iptables -$1 INPUT -s "$5" -p tcp --dport "$6" -j $2
  sudo iptables -$1 OUTPUT -d "$5" -p tcp --sport "$6" -j $3
fi
