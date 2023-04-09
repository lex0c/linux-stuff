#!/bin/sh

INTERFACE=$1

echo $INTERFACE

if [ ! -d "/sys/class/net/${INTERFACE}" ]; then
    echo "Network interface ${INTERFACE} not found."
    exit 1
fi

sudo ip link set ${INTERFACE} down

sudo macchanger -r ${INTERFACE}

sudo ip link set ${INTERFACE} up

echo "New MAC address for ${INTERFACE}:"
ip link show ${INTERFACE} | awk '/ether/ {print $2}'
