# systemd
best suported systemd 
https://wiki.debian.org/systemd
apt install systemd
systemd needs systemd bus either dbus or dbus-broker
polkitd | policykit-1 is needed for passwordless auth 
init=/lib/systemd/systemd

systemd-sysv makes symlink of   /sbin/init 
 apt-get install systemd-sysv

# openrc
https://wiki.debian.org/OpenRC


# runit
https://wiki.debian.org/runit
 runit-init


# sysvinit
http://www.yolinux.com/TUTORIALS/LinuxTutorialInitProcess.html

chroot mode / init=/bin/sh 
apt --download-only install sysvinit-core libpam-elogind

libelogind0 , libsystemd0 will pull systemd/elogind when necessary so you can swap one for other depending on need

sysvinit-core has init in /sbin/init 
/usr/sbin/init is symlinked to /lib/systemd/systemd by systemd-sysv package
also provides /usr/sbin/halt,init,poweroff,reboot,runlevel,shutdown,telinit
dracut has /init as systemd


init-system-helpers(essential)  
/usr/bin/deb-systemd-helper,deb-systemd-invoke
/usr/sbin/invoke-rc.d,service,update-rc.d
sudo apt install initscripts


sysvinit-core
/usr/sbin/halt,init,poweroff,reboot,runlevel,shutdown,telinit
/usr/share/sysvinit/inittab
	
sysvinit-utils(essential) 
/usr/bin/pidof
/usr/lib/init/init-d-script
/usr/lib/init/vars.sh
/usr/lib/lsb/init-functions
/usr/lib/lsb/init-functions.d/00-verbose
/usr/sbin/fstab-decode
/usr/sbin/killall5

reinstall udev without udev needs manually loading driver in /etc/modules , find /proc/modules 
depmod -a 
generates /lib/modules/kernel-version/modules.dep



https://packages.debian.org/stable/all/orphan-sysvinit-scripts/filelist



/etc/inittab 

syntax : 
id:runlevels:action:process
id: A unique identifier for each entry (up to four characters).
runlevels: Specifies the runlevels at which this entry should be executed. Each runlevel is a single digit, so multiple runlevels can be specified without separators (e.g., 123).
action: Defines the action that init should take. Common actions include:
 
    respawn: Restart the process if it terminates.
    wait: Start the process once when entering the specified runlevel and wait for it to finish.
    once: Start the process once when entering the specified runlevel without waiting.
    sysinit: Run the process during system initialization.
    initdefault: default init script to run
    ctrlaltdel: Execute the process when Ctrl+Alt+Del is pressed.
    powerfail: Run the process if a power failure is detected (if supported).
    
process: The command to execute, which can be a path to a program or a script.

runlevels
# Runlevel 0 is halt.
# Runlevel 1 is single-user.
# Runlevels 2-5 are multi-user.
# Runlevel 6 is reboot.
debian has runkevel in folder /etc/rc0.d,rc1.d....rc6.d,rcS.d

scripts in runlevels are renamed SXX or KXX to enable or disable  

example :
id:2:initdefault:

# Boot-time system configuration/initialization script.
# This is run first except when booting in emergency (-b) mode.
si::sysinit:/etc/init.d/rcS
empty runlevel here means that the process defined by this entry runs at the system initialization stage before the runlevel is set. 

~~:S:wait:/sbin/sulogin --force


l0:0:wait:/etc/init.d/rc 0

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now



ps aux | head




runit
sudo apt install runit-systemd  runit runit-run elogind libpam-elogind orphan-sysvinit-scripts systemctl procps


https://lecorbeausvault.wordpress.com/2022/02/07/debian-switching-init-system-easily-openrc-sysvinit-runit/
)
