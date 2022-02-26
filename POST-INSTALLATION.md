# Basic Post-installation

https://wiki.archlinux.org

Clock synchronization
`timedatectl set-ntp true`

Secury recommendations
https://wiki.archlinux.org/title/Security

### Uncomment or add parallel downloads
`ParallelDownloads = 5` >> `/etc/pacman.conf`

### Update system
`sudo pacman -Syu`

### Disable
- `sudo systemctl disable cups-daemon`
- `sudo systemctl disable avahi-daemon`

### IPTable rules
- `sudo iptables  -I  INPUT  -i  ech0  -p   icmp  -s  0/0  -d  0/0   -j  DROP`
- ...

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
  tor \
  docker \
  firejail \
  proxychains \
  unzip \
  openvpn \
  git \
  curl \
  wget \
  ufw \
  whois \
  vim \
  keepassxc \
  hashdeep \
  net-tools \
  tcpdump \
  tcpflow \
  mitmproxy \
  dnsutils \
  traceroute \
  netcat \
  nmap \
  mat2 \
  hashcat \
  qbittorrent \
  virtualbox \
  gparted \
  steam
```

AUR
https://aur.archlinux.org/packages/yay

HTTP performance testing
https://github.com/tsenart/vegeta

Lang version manager
https://github.com/asdf-vm/asdf
