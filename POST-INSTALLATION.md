# Basic Post-installation

https://wiki.archlinux.org

## Clock synchronization
`timedatectl set-ntp true`

## Uncomment or add parallel downloads
`ParallelDownloads = 5` >> `/etc/pacman.conf`

## Update system
`sudo pacman -Syu`

## Disable daemons
- `sudo systemctl disable cups-daemon`
- `sudo systemctl disable avahi-daemon`

## Disable IPV6 (temp.)
- `sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1`
- `sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1`
- or add `ipv6.disable=1` in **GRUB_CMDLINE_LINUX_DEFAULT** (persistent)

## Disable swap
`swapoff -a; free -h`

## Security recommendations
- https://wiki.archlinux.org/title/Security
- https://wiki.archlinux.org/title/iptables
- https://wiki.archlinux.org/title/Syslog-ng
- https://wiki.archlinux.org/title/MAC_address_spoofing

## Enable AppArmor
https://wiki.archlinux.org/title/AppArmor

`sudo systemctl enable --now apparmor`

Edit `/etc/default/grub`: Append `lsm=landlock,lockdown,yama,apparmor,bpf` in **GRUB_CMDLINE_LINUX_DEFAULT**

Update grub config: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

**Reboot now!**

Load snaps profile: `sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/*`

## Install useful
```shell
sudo pacman -S \
  syslog-ng \ # sudo systemctl enable --now syslog-ng@default.service
  firefox \
  bash-completion \
  base-devel \
  #gparted \
  docker \ # sudo systemctl start docker
  firejail \
  unzip \
  zip \
  openvpn \
  git \
  curl \
  wget \
  vim \
  #net-tools \
  mat2 \
  #qbittorrent \
  #flatpak \
  virtualbox \
  irssi \
  chromium \
  #fail2ban \ # sudo systemctl enable --now fail2ban
  #tor \ # sudo systemctl start tor
  proxychains \
  #dnsutils \
  netcat \
  #hashcat \
  hashdeep \
  nmap \
  #traceroute \
  #gnu-netcat \
  tcpdump
```

- Pw: https://keepassxc.org/download
- Lang version manager: https://github.com/asdf-vm/asdf


## Checks

### System
`uname -a; env; history`

### Who
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


...
