#!/bin/sh

INTERFACE=$1
ONOFF=$2

if [ ! -d "/sys/class/net/${INTERFACE}" ]; then
    echo "Network interface ${INTERFACE} not found."
    exit 1
fi

sudo ip link set ${INTERFACE} promisc ${ONOFF}

echo "Interface ${INTERFACE} promisc mode ${ONOFF}"
ip link show ${INTERFACE}
