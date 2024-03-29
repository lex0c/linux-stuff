# Iptables

https://wiki.archlinux.org/title/iptables

- ipv4: `/etc/iptables/iptables.rules`
- ipv6: `/etc/iptables/ip6tables.rules`

**Apply these rules to ipv6 too. Change `sudo /sbin/iptables` for `sudo /sbin/ip6tables`.**

## List

`sudo /sbin/iptables -nvL --line-numbers`

## Save

`sudo /sbin/iptables-save -f /etc/iptables/iptables.rules`

## Restore 

`sudo /sbin/iptables-restore -f /etc/iptables/iptables.rules`

## Delete

- `sudo /sbin/iptables -D <command>`
- `sudo /sbin/iptables -D <chain> <num>`

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
sudo /sbin/iptables -A LOGDROP -m limit --limit 5/m --limit-burst 10 -j LOG --log-prefix "LOGDROPPKG"
sudo /sbin/iptables -A LOGDROP -j DROP
```

## Block invalid packets

Drop invalid packets

`sudo /sbin/iptables -A INPUT -m conntrack --ctstate INVALID -j LOGDROP`

## Drop ICMP traffic by rate limit

```
sudo /sbin/iptables -A INPUT -p icmp -m limit --limit 30/minute --limit-burst 60 -j ACCEPT
sudo /sbin/iptables -A INPUT -p icmp -j LOGDROP
```

**OBS**: Change `icmp` to `ipv6-icmp` for ipv6 protocol.

## Logging

- `sudo journalctl -k --grep="IN=.*OUT=.*"`
- `sudo tail -f /var/log/iptables.log`

## Useful

### Block all incoming/outgoing traffic

- `sudo /sbin/iptables -P INPUT DROP`
- `sudo /sbin/iptables -P OUTPUT DROP`

### Block an IP address

`sudo /sbin/iptables -I INPUT -p tcp -s <ip> -j DROP`

### Block incoming port

- `sudo /sbin/iptables -I INPUT -p tcp --dport <port> -j DROP`
- `sudo /sbin/iptables -I INPUT -p tcp -s <ip> --dport <port> -j DROP`

### Block connections by limit

`sudo /sbin/iptables -I INPUT -p tcp -m connlimit --connlimit-above <limit> -j DROP`

### Block new connections by rate limit

```
sudo /sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit <limit-per-sec>/s --limit-burst <initial-limit> -j ACCEPT 
sudo /sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j DROP
```

### Redirect incoming traffic to a different port

`sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport <port> -j REDIRECT --to-port <port>`

### IP forwarding

- 0 = disabled
- 1 = enabled

`echo 1 > /proc/sys/net/ipv4/ip_forward` or `sysctl -w net.ipv4.ip_forward=1 && sysctl -p`

persistent

`sudo vim /etc/sysctl.conf`
