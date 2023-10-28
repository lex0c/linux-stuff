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

persistent mode: `/etc/fstab`

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

## Lockdown

```shell
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo ip6tables -P INPUT DROP
sudo ip6tables -P FORWARD DROP
sudo ip6tables -P OUTPUT ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6

sudo iptables -L
sudo ip6tables -L
```

##  Useful programs
```shell
sudo pacman -S \
  syslog-ng \ # sudo systemctl enable --now syslog-ng@default.service
  #firefox \
  bash-completion \
  base-devel \
  net-tools \
  pulseaudio \
  pavucontrol \
  pulseaudio-alsa \
  gparted \
  cryptsetup \
  docker \ # sudo systemctl start docker
  firejail \
  inotify-tools \
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
  iftop \
  gdb \
  pwndbg \ # echo 'source /usr/share/pwndbg/gdbinit.py' >> ~/.gdbinit
  #chromium \
  strace \
  tor \ # sudo systemctl start tor
  proxychains \
  dnsutils \
  hashcat \
  hashdeep \
  nmap \
  traceroute \
  #rkhunter \
  gnu-netcat \
  tcpdump \
  #whois \ 
  graphviz \
  #sendmail
```

- https://keepassxc.org/download
- https://electrum.org/#download
- https://github.com/asdf-vm/asdf
- https://aur.archlinux.org/packages/packit
- https://github.com/NationalSecurityAgency/ghidra
