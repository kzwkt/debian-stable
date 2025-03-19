
# debian dots and configs

apt-mark showmanual | grep -v '^lib'

```
apt install bash-completion  dbus-broker deborphan dialog dosfstools fdisk ffmpeg file fonts-noto-color-emoji foot  grim  htop  intel-media-va-driver-non-free iwd  jq   l3afpad lifeograph tiny-initramfs linux-image-amd64 locales  mandoc mpv   nano neofetch nnn opendoas otpclient  pipewire-audio  slurp sway systemd-boot systemd-oomd  systemd-timesyncd systemd-zram-generator  tar  tzdata  udev   vainfo  wireless-regdb wl-clipboard wofi  zathura  librsvg2-common less wlsunset  wtype
```

ntfs-3g  bubblewrap  systemd-resolved or openresolv 

0 upgraded, 399 newly installed, 0 to remove and 0 not upgraded.

Need to get 279 MB of archives.

After this operation, 1172 MB of additional disk space will be used.


recommends and suggested 
```
Suggested packages:
  libarchive-dev ispell | aspell | hunspell wordlist ffmpeg-doc foot-themes lm-sensors lsof strace hunspell openoffice.org-hunspell
  | openoffice.org-core lrzip libasound2-plugins alsa-utils aspell libcuda1 libnvcuvid1 libnvidia-encode1 libbluray-bdj colord cups-common
  libdvdcss2 libenchant-2-voikko low-memory-monitor krb5-doc krb5-user gvfs jackd2 liblcms2-utils libportaudio2 opus-tools pciutils pulseaudio
  libraw1394-doc librsvg2-bin serdi sndiod sordi speex libwacom-bin linux-doc-6.1 debian-kernel-handbook grub-pc | grub-efi-amd64 | extlinux
  opencl-icd otpclient-cli pulseaudio-utils polkitd-pkla sgml-base-doc swayidle swaylock xdg-desktop-portal-wlr wireplumber-doc debhelper
  www-browser zathura-ps zathura-djvu zathura-cb
Recommended packages:
  gettext-base sensible-utils alsa-ucm-conf alsa-topology-conf aspell-en | aspell-dictionary | aspell6a-dictionary at-spi2-core libaacs0
  libclutter-1.0-common libcogl-common dbus libdecor-0-plugin-1-cairo | libdecor-0-plugin-1 enchant-2 libgdk-pixbuf2.0-bin libglib2.0-data
  xdg-user-dirs libgtk-3-bin krb5-locales libpipewire-0.3-common pocketsphinx-en-us poppler-data publicsuffix vdpau-driver-all | vdpau-driver
  mesa-vulkan-drivers | vulkan-icd libmagickcore-6.q16-6-extra firmware-linux-free apparmor yt-dlp rtkit psmisc suckless-tools sway-backgrounds
  libfile-mimeinfo-perl libnet-dbus-perl libx11-protocol-perl x11-utils x11-xserver-utils

```

```
bubblewrap - low level  sandbox  : Recommends: procps  
dbus-broker - alternative to dbus install before systemd  :  Recommends: dbus-bin Provides: dbus-system-bus   
deborphan - cleaning orphan pkgs : Recommends: apt, gettext-base(intl localization)  
dialog  - dpkg-reconfgure frontend set for debconf  
dosfstools - make fat32 partition for esp  
fdisk - cli partition manager Recommends: sensible-utils (set sensible-editor,browser,pager)  
file - for mime detection in nnn  
fonts-noto-color-emoji - emoji font  
foot - terminal editor Suggests: foot-themes Provides: x-terminal-emulator    
htop - cli task manager Suggests: lm-sensors, lsof, strace  
intel-media-va-driver-non-free - vaapi hwacel for intel gen 8+   Provides: va-driver  Conflicts: intel-media-va-driver  
iwd - wifi managment Recommends: dbus | dbus-system-bus, wireless-regdb  
jq - parsing swaymessage for screenshot   
l3afpad - gui text editor   
lifeograph  - Diary app : will fail silently if no librsvg pixbuf  
linux-image-amd64 - stable kernel   Provides: linux-image-generic, linux-latest-modules-6.1.0-16-amd64, virtualbox-guest-modules, wireguard-modules   
locales - provides UTF support like en_US.UTF-8 , warning  of loacle displayed without it   
mandoc - bsd alternative to man-db virtual man  provides mman package instead  
mpv - video/audio/image Recommends: xdg-utils, yt-dlp  Suggests: libcuda1 ( for nvidia?)  
nano - cli editor Conflicts: pico Suggests: hunspell Replaces: nano-tiny,pico   
neofetch - old dead neofetch Recommends: chafa, caca-utils, imagemagick, jp2a, libsixel-bin, w3m-img, pciutils   
nnn - cli file manager  Suggests: mediainfo | exiftool, atool | patool, vlock, file, lftp, sshfs, xdg-utils  
opendoas - unofficial bsd alternative to sudo  Provides: doas  
otpclient - gtk totp/hotp generator  Suggests: otpclient-cli   
pipewire-audio - full pipewire with wireplumber session and pipewire-alsa,pulse,bluetooth  Conflicts: pulseaudio, pulseaudio-module-bluetooth Replaces: pulseaudio, pulseaudio-module-bluetooth  
slurp -  cli utility to select a region in a Wayland compositor  
sway - wayland manual tiling compositor Recommends: suckless-tools, sway-backgrounds, foot  Suggests: swayidle, swaylock, xdg-desktop-portal-wlr  
systemd-boot - auto systemd-boot no need manual adding loader confs Recommends: efibootmgr    
systemd-oomd -userspace  oom killer   
systemd-resolved - DNS resolver for iwd Provides: resolvconf Suggests: polkitd | policykit-1 Conflicts: resolvconf Replaces: resolvconf  
systemd-timesyncd - Provides: time-daemon Conflicts: time-daemon for time sync in timedatectl  
systemd-zram-generator - systemd unit to make zram device  
tar for extracting tarball Suggests: bzip2, ncompress, xz-utils, tar-scripts, tar-doc  
tiny-initramfs Minimalistic(1MB) initramfs doesnt support compressed modules  Provides: linux-initramfs-tool  Conflicts: dracut, initramfs-tools, live-tools  
tzdata timezone list  
udev /dev/ and hotplug management daemon sway   
vainfo Video Acceleration (VA) API spport info  
wireless-regdb  wireless regulatory database for Linux  
wl-clipboard - cli for wayland clipboard Recommends: xdg-utils  
wofi - gui launcher   
zathura - pdf reader Suggests: www-browser, zathura-ps, zathura-djvu, zathura-cb   
```
 
 


```
 /sbin/dpkg-reconfigure tzdata
 timedatectl set-ntp true
 /sbin/dpkg-reconfigure locales
 /sbin/dpkg-reconfigure debconf

```


```
xdg-mime default nnn.desktop inode/directory
``` 

```
systemctl enable iwd
```

# firmware 
```
cd /lib/firmware/i915
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/icl_dmc_ver1_09.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/icl_guc_70.1.1.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/icl_huc_9.0.0.bin
```

```
cd /lib/firmware/ath10k/QCA9377/hw1.0
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/board-2.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/board.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/firmware-6.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/firmware-5.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/firmware-sdio-5.bin
```
todo: bluetooth and ethernet its in qca folder see dmesg

# secureboot

https://wiki.debian.org/SecureBoot

apt install systemd-boot grub-efi-amd64-signed-

revert 

apt install systemd-boot- grub-efi-amd64-signed


apt install systemd-boot shim-signed

MOK

mokutil --disable-validation 

 mokutil --enable-validation

 setup pw 

 apt install sbsigntool

 sbsign --key MOK.priv --cert MOK.pem "/boot/vmlinuz-$VERSION" --output "/boot/vmlinuz-$VERSION.tmp"

 debian key

  mokutil --import /var/lib/shim-signed/mok/MOK.der # prompts for one-time password

  mokutil --test-key /var/lib/shim-signed/mok/MOK.der




