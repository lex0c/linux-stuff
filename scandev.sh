#!/bin/sh

IP="$1"

nmap -v -A "${IP}"

