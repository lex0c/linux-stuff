## LUKS
```sh
sudo cryptsetup luksFormat /dev/sda2
```
```sh
sudo cryptsetup luksOpen /dev/sda2 my_encrypted_volume
```
```sh
sudo mkfs.ext4 /dev/mapper/my_encrypted_volume
```
```sh
sudo mkdir /run/media/<username>/my_encrypted_volume
sudo mount /dev/mapper/my_encrypted_volume /run/media/<username>/my_encrypted_volume
```
```sh
sudo umount /run/media/<username>/my_encrypted_volume
```
```sh
sudo cryptsetup luksClose my_encrypted_volume
```

## VeraCrypt

Dados em contêineres.

...
