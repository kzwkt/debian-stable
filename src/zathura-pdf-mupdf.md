in google/amazon/azure/github-codespace whatever   
sudo mount -o rw,remount,exec,dev,suid  /home   
debootstrap stable deb   
```
debian Stable 
Mupdf 1.21.1+ds2-1 	
Zthura 0.5.2-1 
Girara 0.4.0-1 
Meosn 1.0.1-5

we can go with zathura-pdf-mupdf 0.4.1 due to mupdf version dep

https://github.com/pwmt/zathura-pdf-mupdf/archive/refs/tags/0.4.1.tar.gz

apt install build-essential libmupdf-dev zathura-dev
apt build-dep zathura mupdf
 apt-get source mupdf
```

i commented following in meson.build
```
  build_dependencies += [
 
    # tesseract,
    # leptonica,
  ]
# build from Debian's libmupdf-dev
#  tesseract = dependency('tesseract')
#  leptonica = dependency('lept')
```

meson build
```
		
cd build
ninja

testing 
cp libpdf-mupdf.so   ~/opt/mupdf/
zathura -p ~/opt/mupdf/
missing dependecies blah blah blah
sudo apt install libjbig2dec0 libgumbo1

finally works 

copy it to zathura plugin dir  /usr/lib/x86_64-linux-gnu/zathura/
sudo install -m 755 -o root -g root  libpdf-mupdf.so /usr/lib/x86_64-linux-gnu/zathura/
zathura
error: Could not load plugin '/usr/lib/x86_64-linux-gnu/zathura/libpdf-mupdf.so' (/usr/lib/x86_64-linux-gnu/zathura/libpdf-mupdf.so: cannot open shared object file: Permission denied).
zatura 
error: plugin: filetype already registered: application/pdf

```


Dependencies for zathura-pdf-mupdf
```
Version 0.4.3
zathura (>= 0.2.0)
girara
mupdf (>= 1.24.0)
meson (>= 0.61) for building
GLib
Cairo
GTK+

Version 0.4.2
zathura (>= 0.2.0)
girara
mupdf (>= 1.24.0)
meson (>= 0.61) for building
GLib
Cairo
GTK+

Version 0.4.1       
zathura (>= 0.4.7)
girara (>= 0.3.6)
mupdf (>= 1.16.0)
meson (>= 0.61) for building
GLib
Cairo
GTK+

Version 0.4.0
zathura (>= 0.2.0)
girara
mupdf (>= 1.14.0)
meson (>= 0.50) for building
GLib
Cairo
GTK+

Version 0.3.9
zathura (>= 0.2.0)
girara
mupdf (>= 1.12.0)
meson (>= 0.50) for building
GLib
Cairo
GTK+

Version 0.3.8
zathura (>= 0.2.0)
girara
mupdf (>= 1.10.0)
meson (>= 0.50) for building
GLib
Cairo
GTK+

Version 0.3.7
zathura (>= 0.2.0)
girara
mupdf (>= 1.8.0)
meson (>= 0.50) for building
GLib
Cairo
GTK+
```
https://salsa.debian.org/sramacher/zathura

Stable 
0.4.9-1
```
https://tracker.debian.org/pkg/zathura
	 	 o-o-stable: 	 	 	0.4.3-1 	
	 	 oldstable: 	 	 	0.4.7-1 	
	 	 stable: 	 	 	0.5.2-1 	
	 	 testing: 	 	 	0.5.6-1 	
	 	 unstable: 	 	 	0.5.6-1 	
https://tracker.debian.org/pkg/mupdf
	 	 o-o-stable: 	 	 	1.14.0+ds1-4+deb10u3 	
	 	 o-o-sec: 	 	 	1.14.0+ds1-4+deb10u2 	
	 	 oldstable: 	 	 	1.17.0+ds1-2 	
	 	 old-sec: 	 	 	1.17.0+ds1-1.3~deb11u1 	
	 	 stable: 	 	 	1.21.1+ds2-1 	
	 	 testing: 	 	 	1.23.10+ds1-1 	
	 	 unstable: 	 	 	1.24.3+ds1-1 	
https://tracker.debian.org/pkg/girara
	 	 o-o-stable: 	 	 	0.3.2-1 	
	 	 oldstable: 	 	 	0.3.5-1 	
	 	 stable: 	 	 	0.4.0-1 	
	 	 testing: 	 	 	0.4.4-1 	
	 	 unstable: 	 	 	0.4.4-1 	
https://tracker.debian.org/pkg/meson
	 	 o-o-stable: 	 	 	0.49.2-1 	
	 	 oldstable: 	 	 	0.56.2-1 	
	 	 old-bpo: 	 	 	1.0.0-1.1~bpo11+1 	
	 	 stable: 	 	 	1.0.1-5 	
	 	 testing: 	 	 	1.4.1-1 	
	 	 unstable: 	 	 	1.4.1-1 	
```




