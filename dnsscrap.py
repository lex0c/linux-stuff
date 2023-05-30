from scapy.all import *

# Replace these with the target URL and DNS server IP
target_url = ""
dns_server_ip = "8.8.8.8"  # Google Public DNS

# Craft a DNS query packet
dns_query = IP(dst=dns_server_ip) / UDP(dport=53) / DNS(rd=1, qd=DNSQR(qname=target_url))

# Send the DNS query and capture the response
dns_response = sr1(dns_query, verbose=0)

# Parse the DNS response
if dns_response.haslayer(DNSRR):
    for i in range(dns_response[DNS].ancount):
        record = dns_response[DNS].an[i]
        print(f"Received DNS response: {record.rrname.decode('utf-8')} -> {record.rdata}")
else:
    print("No DNS response received.")

