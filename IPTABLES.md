# Iptables

- ipv4: `/etc/iptables/iptables.rules`
- ipv6: `/etc/iptables/ip6tables.rules`

## List

`sudo /sbin/iptables -nvL --line-numbers`

## Save

`sudo /sbin/iptables-save -f /etc/iptables/iptables.rules`

## Restore 

`sudo /sbin/iptables-restore -f /etc/iptables/iptables.rules`

## Delete

- `sudo /sbin/iptables -D <command>`
- `sudo /sbin/iptables -D <chain> <index>`

## Reset

```
sudo /sbin/iptables -F
sudo /sbin/iptables -X
sudo /sbin/iptables -t nat -F
sudo /sbin/iptables -t nat -X
sudo /sbin/iptables -t mangle -F
sudo /sbin/iptables -t mangle -X
sudo /sbin/iptables -t raw -F
sudo /sbin/iptables -t raw -X
sudo /sbin/iptables -t security -F
sudo /sbin/iptables -t security -X
sudo /sbin/iptables -P INPUT ACCEPT
sudo /sbin/iptables -P FORWARD ACCEPT
sudo /sbin/iptables -p OUTPUT ACCEPT
```

## Custom chains

### LOGDROP

```
sudo /sbin/iptables -N LOGDROP
sudo /sbin/iptables -A LOGDROP -m limit --limit 5/m --limit-burst 10 -j LOG --log-prefix "LOGDROP"
sudo /sbin/iptables -A LOGDROP -j DROP
```

## Block invalid packets

Drop invalid packets

`sudo /sbin/iptables -A INPUT -m conntrack --ctstate INVALID -j LOGDROP`

Drop TCP packets that are new and are not SYN

`sudo /sbin/iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j LOGDROP`

Drop SYN packets with suspicious MSS value

`sudo /sbin/iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j LOGDROP`

Drop packets with suspicious TCP flags

```
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j LOGDROP
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j LOGDROP
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j LOGDROP
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j LOGDROP
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j LOGDROP
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j LOGDROP
sudo /sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j LOGDROP
```

## Drop ICMP traffic by rate limit

```
sudo /sbin/iptables -A INPUT -p icmp -m limit --limit 30/minute --limit-burst 60 -j ACCEPT
sudo /sbin/iptables -A INPUT -p icmp -j LOGDROP
```

## Logging

- `sudo journalctl -k --grep="IN=.*OUT=.*"`
- `sudo tail -f /var/log/iptables.log`

## Useful

### Block an IP address

`sudo /sbin/iptables -I INPUT -s <ip-address> -j REJECT`

### Block incoming port

`sudo /sbin/iptables -I INPUT -p tcp --dport <port-number> -j REJECT`

### Block connections by limit

`sudo /sbin/iptables -A INPUT -p tcp -m connlimit --connlimit-above <limit> -j REJECT`

### Block connections by rate limit

```
sudo /sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit <limit-per-sec>/s --limit-burst <initial-limit> -j ACCEPT 
sudo /sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j LOGDROP
```

### Redirect incoming traffic to a different IP/port address

```
sudo /sbin/iptables -t nat -A PREROUTING -p tcp --dport <port> -j DNAT --to-destination <ip>:<port>
sudo /sbin/iptables -t nat -A POSTROUTING -j MASQUERADE
```

Set *MASQUERADE* to mask the IP address of the connecting system and use the gateway IP address instead. This is necessary for it to communicate back to the gateway, then to your client.

Redirect to another local port

`sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport <port> -j REDIRECT --to-port <port>`

...
