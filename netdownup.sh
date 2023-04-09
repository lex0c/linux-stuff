#!/bin/sh

INTERFACE="$1"
DURATION="$2"

if [ ! -d "/sys/class/net/${INTERFACE}" ]; then
    echo "Network interface ${INTERFACE} not found."
    exit 1
fi

sudo ip link set "${INTERFACE}" down
echo "Interface ${INTERFACE} disabled."

sleep "${DURATION}"

sudo ip link set "${INTERFACE}" up
echo "Interface ${INTERFACE} enabled."
