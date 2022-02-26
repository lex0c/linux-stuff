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
  hashdeep \
  qbittorrent \
  virtualbox \
  gparted \
  steam
```

AUR
https://aur.archlinux.org/packages/yay

HTTP performance testing
https://github.com/tsenart/vegeta

Debug proxies
https://www.charlesproxy.com

Work tools
https://www.kali.org/tools

Version manager
https://github.com/asdf-vm/asdf

Pass
https://keepassxc.org

Remove file metadata
https://0xacab.org/jvoisin/mat2
