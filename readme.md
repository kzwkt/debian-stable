
# debian dots and configs

apt-mark showmanual | grep -v '^lib'

```
apt install bash-completion  dbus-broker deborphan dialog dosfstools fdisk ffmpeg file fonts-noto-color-emoji foot  grim  htop  intel-media-va-driver-non-free iwd  jq   l3afpad lifeograph tiny-initramfs linux-image-amd64 locales  mandoc mpv   nano neofetch nnn opendoas otpclient  pipewire-audio  slurp sway systemd-boot systemd-oomd systemd-resolved systemd-timesyncd systemd-zram-generator  tar  tzdata  udev   vainfo  wireless-regdb wl-clipboard wofi  zathura  
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
sudo /sbin/dpkg-reconfigure tzdata
sudo timedatectl set-ntp true
sudo /sbin/dpkg-reconfigure locales
```


```
xdg-mime default nnn.desktop inode/directory
``` 









