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
- https://wiki.archlinux.org/title/Sysctl
- https://wiki.archlinux.org/title/iptables
- https://wiki.archlinux.org/title/MAC_address_spoofing

## Enable AppArmor
https://wiki.archlinux.org/title/AppArmor

`sudo systemctl enable --now apparmor`

Edit `/etc/default/grub`: Append `lsm=landlock,lockdown,yama,apparmor,bpf` in **GRUB_CMDLINE_LINUX_DEFAULT**

Update grub config: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

**Reboot now!**

##  Useful programs
```shell
sudo pacman -S \
  syslog-ng \ # sudo systemctl enable --now syslog-ng@default.service
  firefox \
  bash-completion \
  base-devel \
  gparted \
  docker \ # sudo systemctl start docker
  firejail \
  unzip \
  zip \
  openvpn \
  git \
  curl \
  wget \
  vim \
  perl-image-exiftool \
  qbittorrent \
  flatpak \
  virtualbox \
  irssi \
  lsof \
  gdb \
  pwndbg \ # echo 'source /usr/share/pwndbg/gdbinit.py' >> ~/.gdbinit
  chromium \
  strings \
  strace \
  #tor \ # sudo systemctl start tor
  #proxychains \
  #dnsutils \
  #hashcat \
  #hashdeep \
  nmap \
  #traceroute \
  gnu-netcat \
  tcpdump \
  whois
```

- Passw: https://keepassxc.org/download
- Lvm: https://github.com/asdf-vm/asdf
- packit: https://aur.archlinux.org/packages/packit
- ghidra: https://github.com/NationalSecurityAgency/ghidra
