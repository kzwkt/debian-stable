http://packages.linuxmint.com/pool/main/l/linuxmint-keyring/

download deb of keyring and istall with dpkg -i 

http://packages.linuxmint.com/pool/main/l/linuxmint-keyring/linuxmint-keyring_2022.06.21_all.deb

apt install gnupg

dpkg -i linuxmint-keyring_2022.06.21_all.deb


http://packages.linuxmint.com/

suites 

lmde6 faye for bookworm

lmde7 gigi for trixie

for ubuntu

https://en.wikipedia.org/wiki/Linux_Mint


```
Ubuntu 24.04 LTS (Noble Numbat)
22.1,22  xia,wilma = noble

Ubuntu 22.04 LTS (Jammy Jellyfish)
21,21.1,21.2,21.3 virginia,victoria,vera,vanessa = jammy

Ubuntu 20.04 LTS (Focal Fossa)
20,20.1,20.2,20.3 Ulyana,Ulyssa,uma,Una = focal
```

from https://github.com/linuxmint/mint-upgrade-info/blob/master/usr/share/mint-upgrade-info/wilma/
```
includes: 
xapp-ora-thumbnailer
power-profiles-daemon
mint-backgrounds-wallpapers
captain

blacklist:
linux-kernel
bcmwl
ubuntu-drivers-common
virtualbox

remove:
synaptic
apturl
apturl-common
gdebi
gdebi-core
```

# postinstall
```
kernel : linux-image-generic initramfs-tools firmware-sof-signed thermald
bootloader : grub-efi-amd64-signed    os-prober efibootmgr secureboot-db shim-signed
wifi :  iwd wireless-regdb systemd-resolved
login manager : slick-greeter
xorg: xserver-xorg-input-libinput xinit


dpkg-reconfigure grub-efi-amd64
passwd
adduser x


update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/mint-logo/mint-logo.plymouth  1
00
 update-initramfs -u
 plymouthd ; sudo plymouth --show-splash ; sleep 10 ; sudo killall plymouthd


mkdir /boot/efi
mount /dev/sda20 /boot/efi
grub-install /dev/sda

efibootmgr
Boot0003* Ubuntu	HD(20,GPT,f59beedb-9fbe-ed4e-b33f-b06a275555d7,0x62dfa800,0x100000)/File(\EFI\ubuntu\shimx64.efi)

```
