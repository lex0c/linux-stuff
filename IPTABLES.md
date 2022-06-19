# Iptables

## List

`sudo /sbin/iptables -nvL --line-numbers`

## Rule files

- ipv4: `/etc/iptables/iptables.rules`
- ipv6: `/etc/iptables/ip6tables.rules`

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

## Log all incoming traffic for analysis

Enable this rule for a short time, otherwise your log file will be full.

`sudo /sbin/iptables -I INPUT -m state --state NEW -j LOG --log-prefix "LOG_INPUT_TRAFFIC"`

## Block invalid packets

Drop invalid packets

`sudo /sbin/iptables -A INPUT -m conntrack --ctstate INVALID -j LOGDROP`

Drop TCP packets that are new and are not SYN

`sudo /sbin/iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j LOGDROP`

Drop SYN packets with suspicious MSS value

`sudo /sbin/iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j LOGDROP`


## Rules

```
# 
sudo /sbin/iptables -P FORWARD DROP

# Drop ICMP traffic by rate limit
sudo /sbin/iptables -A INPUT -p icmp -m limit --limit 30/minute --limit-burst 60 -j ACCEPT
sudo /sbin/iptables -A INPUT -p icmp -j LOGDROP


```


## Logging

- `sudo journalctl -k --grep="IN=.*OUT=.*"`
- `sudo tail -f /var/log/iptables.log`

...
