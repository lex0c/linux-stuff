# Post-installation

Uncomment or add parallel downloads
`ParallelDownloads = 5` >> `/etc/pacman.conf`

Update system
`sudo pacman -Syu`

Install base
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
  transmission-cli \
  pacman-mirrorlist \
```

AUR
https://aur.archlinux.org/packages/yay

HTTP performance testing
https://github.com/tsenart/vegeta

Clock synchronization
`timedatectl set-ntp true`

Secury recommendations
https://wiki.archlinux.org/title/Security

Debug proxies
https://www.charlesproxy.com

Work tools
https://www.kali.org/tools

Version manager
https://github.com/asdf-vm/asdf


### IPT
...
