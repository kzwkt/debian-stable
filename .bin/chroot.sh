mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /dev/pts /mnt/dev/pts && mount --make-rslave /mnt/dev/pts
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
chroot  /mnt /bin/sh
