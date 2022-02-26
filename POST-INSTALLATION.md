# Basic Post-installation

https://wiki.archlinux.org

Clock synchronization
`timedatectl set-ntp true`

Secury recommendations
https://wiki.archlinux.org/title/Security

Disables
- `sudo systemctl disable cups-daemon`
- `sudo systemctl disable avahi-daemon`

IPT
- `sudo iptables  -I  INPUT  -i  ech0  -p   icmp  -s  0/0  -d  0/0   -j  DROP`

Uncomment or add parallel downloads
`ParallelDownloads = 5` >> `/etc/pacman.conf`

Update system
`sudo pacman -Syu`

Install useful
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

Proxy
https://www.charlesproxy.com

Version manager
https://github.com/asdf-vm/asdf
