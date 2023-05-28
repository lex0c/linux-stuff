...

## **error:25066067:DSO support routines:dlfcn_load:could not load the shared library**

tmp fix: `export OPENSSL_CONF=/dev/null`


## Load snaps profile

`sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/*`

## Checks

### System
- `ps -ef`
- `uname -a; env; history`
- `systemctl list-unit-files`
- `tail -f /var/log/messages`
- `find / -mtime -7`
- `find / -type f -mmin -60`
- `nmap -sT -v localhost`

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

## Commands
```shell
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
