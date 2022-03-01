### System
`uname -a; env; history`

### Who?
`who; w; last`

### Super users
`grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1 }'`

### SUID
`find / -perm -u=s -type f 2>/dev/null`

### Net
`ip addr; ss -antup; lsof -i`

### Process
`ps aux; ps -ef`

### Crons
`crontab -l; ls -la /etc/cron*`
