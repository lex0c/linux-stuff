# Basic Post-installation

https://wiki.archlinux.org

https://wiki.archlinux.org/title/MAC_address_spoofing


Clock synchronization
`timedatectl set-ntp true`

Secury recommendations
https://wiki.archlinux.org/title/Security

### Uncomment or add parallel downloads
`ParallelDownloads = 5` >> `/etc/pacman.conf`

### Update system
`sudo pacman -Syu`

### Disable daemons
- `sudo systemctl disable cups-daemon`
- `sudo systemctl disable avahi-daemon`

### Disable IPV6 (temp.)
- `sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1`
- `sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1`
- or add `ipv6.disable=1` in **GRUB_CMDLINE_LINUX_DEFAULT**

### Disable swap
`swapoff -a; free -h`

### Enable AppArmor
https://wiki.archlinux.org/title/AppArmor

`sudo systemctl enable --now apparmor`

Edit `/etc/default/grub`:
 - Append `lsm=landlock,lockdown,yama,apparmor,bpf` in **GRUB_CMDLINE_LINUX_DEFAULT**

Update grub config: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

Reboot now

### Install useful
```shell
sudo pacman -S \
  firefox \
  bash-completion \
  base-devel \
  docker \
  firejail \
  unzip \
  zip \
  openvpn \
  git \
  curl \
  wget \
  ufw \
  vim \
  net-tools \
  mat2 \
  qbittorrent \
  #flatpak \
  virtualbox \
  irssi \
  chromium \
  #pulseaudio \
  tor \
  proxychains \
  dnsutils \
  netcat \
  hashcat \
  hashdeep \
  nmap \
  traceroute \
  tcpdump #\
  #tcpflow
```

Pass
https://keepassxc.org/download

AUR
https://aur.archlinux.org/packages/yay

HTTP performance testing
https://github.com/tsenart/vegeta

Lang version manager
https://github.com/asdf-vm/asdf

Proxy debug
https://www.charlesproxy.com/download

Binary analyzer
- https://hex-rays.com/ida-free/#download
- http://angusj.com/resourcehacker
- http://www.pe-explorer.com/

Detect packers
https://www.aldeid.com/wiki/PEiD
