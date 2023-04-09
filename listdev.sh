#!/bin/sh

if ! command -v nmap >/dev/null 2>&1; then
  echo "nmap not found."
  exit 1
fi

NETWORK_RANGE="$1"

nmap -sn ${NETWORK_RANGE} -oG - | awk '/Up$/{print $2, $3}' | sed 's/(//g; s/)//g'

arp
