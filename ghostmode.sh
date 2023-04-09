#!/bin/sh

# sudo ./ghostmode.sh <interface> 192.168.0.0/24 255.255.255.0

if [ $# -ne 3 ]; then
    echo "Usage: $0 interface subnet subnet_mask"
    exit 1
fi

interface=$1
subnet=$2
subnet_mask=$3

function generate_random_ip() {
    subnet=$1
    ip=$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))
    echo ${subnet%.*}.$((${subnet##*.} + RANDOM % 255))
}

function mask2cidr() {
    local mask=$1
    local bits=0

    for octet in $(echo $mask | tr "." " "); do
        local binary=$(echo "obase=2; ibase=10; $octet" | bc)
        bits=$(($bits + $(echo $binary | tr -cd '1' | wc -c)))
    done

    echo $bits
}

./randomac.sh

new_ip=$(generate_random_ip $subnet)
current_ip_cidr=$(ip -o -f inet addr show $interface | awk '{print $4}')
subnet_mask_cidr=$(mask2cidr $subnet_mask) # Esta função deve ser implementada

sudo ip addr del $current_ip_cidr dev $interface
sudo ip addr add $new_ip/$subnet_mask_cidr dev $interface

echo "Changed MAC address and IP address for $interface."
