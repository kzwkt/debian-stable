sudo apt install libcanberra-pulse  xsettingsd libcanberra-gtk3-module

canberra-gtk-module" should be in the GTK_MODULES environment variable (re-login may be required);
Check "Enable event sounds" in Settings Manager > Appearance > Settings tab;
In the Settings Editor set "xsettings/Net/SoundThemeName" to a sound theme located in /usr/share/sounds/;
Turn on "System Sounds" in audio mixer (e.g. pavucontrol).

sudo apt install gnome-session-canberra 
for canberra-gtk-play 
canberra-gtk-play --id="desktop-login" --description="Test Login Sound"

settings-editor
