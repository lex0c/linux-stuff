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

### Disable daemons
- `sudo systemctl disable cups-daemon`
- `sudo systemctl disable avahi-daemon`

### Disable IPV6 (temp.)
- `sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1`
- `sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1`

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
  vim \
  keepassxc \
  hashdeep \
  net-tools \
  mitmproxy \
  mat2 \
  qbittorrent \
  flatpak \
  virtualbox
-----vmsb-----
  dnsutils \
  netcat \
  hashcat \
  nmap \
  traceroute \
  whois \
  tcpdump \
  tcpflow \
  telnet \
  ftp
```


AUR
https://aur.archlinux.org/packages/yay

HTTP performance testing
https://github.com/tsenart/vegeta

Lang version manager
https://github.com/asdf-vm/asdf

Proxy debug
https://www.charlesproxy.com/download
