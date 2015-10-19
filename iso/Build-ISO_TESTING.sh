#!/bin/bash
##############################################################################################################################################################################################################################################################
# Install debootstrap
sudo apt-get install debootstrap
##############################################################################################################################################################################################################################################################
# Create ChRoot environment
mkdir -p -v ~/SparkleShare/iso/work/chroot
sudo debootstrap --arch=amd64 `lsb_release -c -s` chroot
##############################################################################################################################################################################################################################################################
# Network start config
sudo cp /etc/hosts chroot/etc/hosts
sudo cp /etc/resolv.conf chroot/etc/resolv.conf
sudo cp /etc/apt/sources.list chroot/etc/apt/sources.list
##############################################################################################################################################################################################################################################################
# Start ChRoot environment
sudo chroot chroot
mount none -t proc /proc
mount none -t sysfs /sys
mount none -t devpts /dev/pts
export HOME=/root
export LC_ALL=C
##############################################################################################################################################################################################################################################################
# DBus configuration
apt-get install -y dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
##############################################################################################################################################################################################################################################################
# No password on sudo
# /etc/sudoers.d/avix
touch /etc/sudoers.d/avix
echo '%sudo ALL=NOPASSWD: ALL'| tee /etc/sudoers.d/avix
chmod 0440 -v /etc/sudoers.d/avix
##############################################################################################################################################################################################################################################################
# Add user in audio group
# /etc/adduser.conf
sed -i 's/#EXTRA_GROUPS="dialout cdrom floppy audio video plugdev users"/EXTRA_GROUPS="dialout cdrom floppy audio video plugdev users"/g' /etc/adduser.conf
sed -i 's/#ADD_EXTRA_GROUPS=1/ADD_EXTRA_GROUPS=1/g' /etc/adduser.conf
##############################################################################################################################################################################################################################################################
# Configure default sources
# /etc/apt/sources.list
# Remove sources
sed -i 's/#\ deb-src/deb-src/g' /etc/apt/sources.list
sed -i 's/deb-src/#deb-src/g' /etc/apt/sources.list
# Activate partners
sed -i 's/# deb http:\/\/archive.canonical.com\/ubuntu `lsb_release -c -s` partner/deb http:\/\/archive.canonical.com\/ubuntu `lsb_release -c -s` partner/g' /etc/apt/sources.list
##############################################################################################################################################################################################################################################################
# Auto accept TOS
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
##############################################################################################################################################################################################################################################################
# Keep configurations of the APT packages against new defaults from update and no install recommends & suggests
echo 'APT::Install-Recommends "0";' | tee /etc/apt/apt.conf
echo 'APT::Install-Suggests "0";' | tee -a /etc/apt/apt.conf
echo 'Dpkg::Options {' | tee -a /etc/apt/apt.conf
echo '		"--force-confdef";' | tee -a /etc/apt/apt.conf
echo '		"--force-confold";' | tee -a /etc/apt/apt.conf
echo '};' | tee -a /etc/apt/apt.conf
##############################################################################################################################################################################################################################################################
# Repositories tools
apt-get update
apt-get install -y software-properties-common wget apt-transport-https
##############################################################################################################################################################################################################################################################
# Add PPAs
# Graphics drivers PPA #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:graphics-drivers/ppa
# Oibaf graphics drivers #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:oibaf/graphics-drivers
# Numix PPA #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:numix/ppa
# Nemo PPA(WebUpd8Team) #TRUSTY #VIVID
add-apt-repository -y ppa:webupd8team/nemo
sed -i 's/wily/vivid/g' /etc/apt/sources.list.d/webupd8team-ubuntu-nemo-wily.list #WILY TMP_FIX
# Folder color PPA #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:costales/folder-color
# Simple screen recorder PPA #TRUSTY #VIVID
add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
sed -i 's/wily/vivid/g' /etc/apt/sources.list.d/maarten-baert-ubuntu-simplescreenrecorder-wily.list #WILY TMP_FIX
# Oracle Java PPA #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:webupd8team/java
# GIMP extras PPA #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:otto-kesselgulasch/gimp
# LibreOffice PPA #TRUSTY #VIVID #WILY
add-apt-repository -y ppa:libreoffice/ppa
# Haguichi PPA #TRUSTY #VIVID# #WILY
add-apt-repository -y ppa:webupd8team/haguichi
##############################################################################################################################################################################################################################################################
# Extra repositories
# KXStudio repositories #TRUSTY #VIVID #WILY
cd /tmp
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.2.1~kxstudio1_all.deb
dpkg -i /tmp/kxstudio-repos_9.2.1~kxstudio1_all.deb
# Vertex theme repository #TRUSTY #VIVID
cd /tmp
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/Release.key #WILY TMP_FIX
apt-key add - < Release.key  
echo deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/ / | tee /etc/apt/sources.list.d/vertex-theme-`lsb_release -c -s`.list #WILY TMP_FIX
rm -v /tmp/Release.key
# Spotify repository
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
# Syncthing repository
cd /tmp
wget -c https://syncthing.net/release-key.txt
apt-key add - < release-key.txt
echo deb http://apt.syncthing.net/ syncthing release | tee /etc/apt/sources.list.d/syncthing-release.list
# VirtualBox repository
cd /tmp
wget -q https://www.virtualbox.org/download/oracle_vbox.asc
apt-key add - < oracle_vbox.asc
echo deb http://download.virtualbox.org/virtualbox/debian `lsb_release -c -s|sed 's/wily/vivid/g'` contrib | tee /etc/apt/sources.list.d/virtualbox-`lsb_release -c -s`.list #WILY TMP_FIX
# Purple-Facebook repository
cd /tmp
wget http://download.opensuse.org/repositories/home:jgeboski/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/Release.key #WILY TMP_FIX
apt-key add - < Release.key  
echo deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/ / | tee /etc/apt/sources.list.d/purple-facebook-`lsb_release -c -s`.list #WILY TMP_FIX
rm -v /tmp/Release.key
##############################################################################################################################################################################################################################################################
# Update repositories
apt-get update
# Upgrade system
apt-get dist-upgrade -y
##############################################################################################################################################################################################################################################################
# Live system dependences
apt-get install -y ubuntu-standard casper lupin-casper
apt-get install -y discover laptop-detect os-prober
##############################################################################################################################################################################################################################################################
# Organize system kernels
# Install lowlatency lernel
apt-get install -y `lsb_release -c -s|sed 's/wily/linux-lowlatency/g'|sed 's/vivid/linux-lowlatency/g'|sed 's/trusty/linux-lowlatency-lts-utopic/g'`
##############################################################################################################################################################################################################################################################
# Install core apps
apt-get install -y q4wine winbind wineasio playonlinux cadence pulseaudio-module-jack indicator-cpufreq oracle-java9-installer icedtea-plugin alsa-firmware
##############################################################################################################################################################################################################################################################
# Install desktop apps
apt-get install -y nemo nemo-dropbox nemo-emblems nemo-share folder-color-nemo vertex-theme numix-icon-theme-circle deluge-gtk python-libtorrent parole qasmixer spotify-client libreoffice-style-tango shutter vinagre p7zip-rar rygel-preferences skype gtk2-engines-pixbuf:i386 unity-gtk2-module:i386 pyrenamer filezilla diodon liferea syncthing preload gshare undistract-me pidgin pidgin-extprefs pidgin-skype purple-facebook
# haguichi NEEDS_FIX
##############################################################################################################################################################################################################################################################
# Install config apps
apt-get install -y system-config-samba synaptic deborphan bleachbit grsync
# modem-manager-gui NEEDS_FIX
##############################################################################################################################################################################################################################################################
# Install tool apps
apt-get install -y git checkinstall gparted gdebi gufw unetbootin
apt-get install -y `lsb_release -c -s|sed 's/wily/virtualbox/g'|sed 's/vivid/virtualbox-5.0/g'|sed 's/trusty/virtualbox-5.0/g'` #WILY TMP_FIX
##############################################################################################################################################################################################################################################################
# Install media apps
apt-get install -y acetoneiso gimp gimp-plugin-registry inkscape simplescreenrecorder blender openshot kdenlive krita kde-l10n-ptbr handbrake brasero asunder ffmpeg lame tuxguitar-fluidsynth fluid-soundfont-gm rawtherapee openlp puddletag
##############################################################################################################################################################################################################################################################
# Install XFCE desktop apps
apt-get install -y xfce4-session xfce4-panel xfce4-whiskermenu-plugin xfce4-indicator-plugin volti xfwm4 compton xscreensaver
##############################################################################################################################################################################################################################################################
# Remove orphaned packages 2x and keep libgcrypt11 for Spotify
deborphan | xargs apt-get -y remove --purge
deborphan | xargs apt-get -y remove --purge
apt-get install -y libgcrypt11 #SPOTIFY TMP_FIX
# Purge autoremoved apps
apt-get autoremove --purge -y
##############################################################################################################################################################################################################################################################
# XFCE desktop configs
# ~/.config/xfce4 + ~/.config/compton.conf + ~/.config/Trolltech.conf
cd /tmp
wget -c https://github.com/rauldipeas/AviX/raw/master/data/xfce%2Bcompton%2Bqtconfig-settings.zip
unzip /tmp/xfce+compton+qtconfig-settings.zip
cp -R -v /tmp/xfce+compton+qtconfig-settings/* /etc/skell/.config/
# /etc/xdg/autostart/qasmixer.desktop #XFCE TMP_FIX
echo '' | tee -a /etc/xdg/autostart/qasmixer.desktop
echo 'OnlyShowIn=Unity;' | tee -a /etc/xdg/autostart/qasmixer.desktop
# /etc/xdg/autostart/vino-server.desktop #XFCE TMP_FIX
sed -i 's/OnlyShowIn=GNOME;Unity;/OnlyShowIn=GNOME;Unity;XFCE;/g' /etc/xdg/autostart/vino-server.desktop
# /etc/xdg/autostart/haguichi-autostart.desktop #XFCE TMP_FIX
echo '' | tee -a /etc/xdg/autostart/haguichi-autostart.desktop
echo 'OnlyShowIn=Unity;' | tee -a /etc/xdg/autostart/haguichi-autostart.desktop
##############################################################################################################################################################################################################################################################
# Install bootloader
apt-get install -y grub2 plymouth-x11
##############################################################################################################################################################################################################################################################
# AviX branding
# /etc/lsb-release
sed -i "s/`lsb_release -d -s`/AviX 2.0/g" /etc/lsb-release
# /etc/default/grub
sed -i 's/-i\ -s/-d\ -s/g' /etc/default/grub
# Plymouth theme
cd /tmp
wget -c http://sourceforge.net/projects/avix/files/repository/data/debian%20apps/avix-plymouth_2.0_all.deb
dpkg -i /tmp/avix-plymouth_2.0_all.deb
# Unity dash icon
cd /tmp
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/artwork/launcher_bfb.png
mkdir -p -v /usr/share/unity/icons
cp -v /tmp/launcher_bfb.png /usr/share/unity/icons/launcher_bfb.png
##############################################################################################################################################################################################################################################################
# LibreOffice M$Office
cd /tmp
wget -c https://github.com/rauldipeas/AviX/raw/master/data/images_tango.zip
sudo cp -v tmp/images_tango.zip /usr/share/libreoffice/share/config/
##############################################################################################################################################################################################################################################################
# Pidgin Numix Theme
cd /tmp
wget -c https://github.com/rauldipeas/AviX/raw/master/data/pidgin.tar.gz
sudo tar -vzxf /tmp/pidgin.tar.gz -C /usr/share/pixmaps/
##############################################################################################################################################################################################################################################################
# Dark-Theme
sudo mkdir -p -v /opt/dark-theme/share/themes
sudo ln -s -v /usr/share/themes/Vertex-Dark /opt/dark-theme/share/themes/Vertex
##############################################################################################################################################################################################################################################################
# Arquivos de configuração dark-theme
# ~/.config/autostart/deluge.desktop + /usr/share/applications/deluge.desktop
sudo sed -i 's/Exec=deluge-gtk %U/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme" deluge-gtk %U/g' /usr/share/applications/deluge.desktop
# /usr/share/applications/gimp.desktop
sudo sed -i 's/Exec=gimp-2.8 %U/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme" gimp-2.8 %U/g' /usr/share/applications/gimp.desktop
# /usr/share/applications/inkscape.desktop
sudo sed -i 's/Exec=inkscape %F/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme" inkscape %F/g' /usr/share/applications/inkscape.desktop
# /usr/share/applications/openlp.desktop
sudo sed -i 's/Exec=openlp %F/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme" openlp %F/g' /usr/share/applications/openlp.desktop
# /usr/share/applications/rawtherapee.desktop
sudo sed -i 's/Exec=rawtherapee %f/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme\" rawtherapee %f/g' /usr/share/applications/rawtherapee.desktop
# /usr/share/applications/kde4/kdenlive.desktop
sudo sed -i 's/Exec=kdenlive %i -caption %c %u/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme\" kdenlive %i -caption %c %u/g' /usr/share/applications/kde4/kdenlive.desktop
# /usr/share/applications/openshot.desktop
sudo sed -i 's/Exec=openshot %F/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme\" openshot %F/g' /usr/share/applications/openshot.desktop
# /usr/share/applications/shutter.desktop
sudo sed -i 's/Exec=shutter/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme\" shutter/g' /usr/share/applications/shutter.desktop
# /usr/share/applications/kde4/quassel.desktop
sudo sed -i 's/Exec=quassel/Exec=env GTK_DATA_PREFIX="\/opt\/dark-theme\" quassel/g' /usr/share/`lsb_release -c -s|sed 's/trusty/applications\/kde4/g'|sed 's/vivid/applications/g'|sed 's/wily/applications/g'`/quassel.desktop
sudo sed -i 's/TryExec=env GTK_DATA_PREFIX="\/opt\/dark-theme\" quassel/TryExec=quassel/g' /usr/share/`lsb_release -c -s|sed 's/trusty/applications\/kde4/g'|sed 's/vivid/applications/g'|sed 's/wily/applications/g'`/quassel.desktop
##############################################################################################################################################################################################################################################################
# Shortcut fix
# /usr/share/applications/nemo.desktop
sudo sed -i 's/Name=Open a New Window/Name=Abrir uma nova janela/g' /usr/share/applications/nemo.desktop
# /usr/share/applications/pyrenamer.desktop
sudo sed -i 's/Icon\=\/usr\/share\/pyrenamer\/pyrenamer.png/Icon\=pyrenamer/g' /usr/share/applications/pyrenamer.desktop
# /usr/share/applications/xdiagnose.desktop
sudo sed -i 's/Icon=\/usr\/share\/xdiagnose\/icons\/microscope.svg/Icon=xdiagnose/g' /usr/share/applications/xdiagnose.desktop
# /usr/share/applications/webbrowser-app.desktop
sudo sed -i 's/Icon=\/usr\/share\/webbrowser-app\/webbrowser-app.png/Icon=webbrowser-app/g' /usr/share/applications/webbrowser-app.desktop
# /usr/share/applications/kde4/calligra*
sudo rm -v /usr/share/applications/kde4/calligra*
# /usr/share/applications/tuxguitar.desktop
sudo sed -i 's/Name=tuxguitar/Name=TuxGuitar/g' /usr/share/applications/tuxguitar.desktop
##############################################################################################################################################################################################################################################################
# Fix Numix Indicators # NUMIX TMP_FIX
#*sudo ln -s /usr/share/icons/Numix/16 /usr/share/icons/Numix/16x16
#*sudo ln -s /usr/share/icons/Numix/22 /usr/share/icons/Numix/22x22
#*sudo ln -s /usr/share/icons/Numix/24 /usr/share/icons/Numix/24x24
#*sudo ln -s /usr/share/icons/Numix-Light/16 /usr/share/icons/Numix-Light/16x16
#*sudo ln -s /usr/share/icons/Numix-Light/22 /usr/share/icons/Numix-Light/22x22
#*sudo ln -s /usr/share/icons/Numix-Light/24 /usr/share/icons/Numix-Light/24x24
#*sudo rm -v /usr/share/icons/Numix/icon-theme.cache 
#*sudo rm -v /usr/share/icons/Numix-Circle/icon-theme.cache
# SPARKLESHARE TMP_FIX
cd /tmp
wget -c https://github.com/rauldipeas/AviX/raw/master/data/sparkle-share-indicators.7z
7z x sparkle-share-indicators.7z
sudo cp -v /tmp/sparkle-share-indicators/24/* /usr/share/icons/hicolor/24x24/status/
sudo cp -v /tmp/sparkle-share-indicators/48/* /usr/share/icons/hicolor/48x48/status/
##############################################################################################################################################################################################################################################################
# Install graphic installer
apt-get install -y ubiquity-frontend-gtk
# Cleanup the ChRoot environment
rm -r /var/lib/dbus/machine-id
apt-get clean
rm -rf /tmp/*
rm -r /etc/resolv.conf
umount -lf /proc
umount -lf /sys
umount -lf /dev/pts
##############################################################################################################################################################################################################################################################
# Stop ChRoot environment
exit
##############################################################################################################################################################################################################################################################
# Create CD image directory and populate it
sudo apt-get install syslinux squashfs-tools genisoimage
mkdir -p image/{casper,isolinux,install}
sudo cp chroot/boot/vmlinuz-*-lowlatency image/casper/vmlinuz
sudo cp chroot/boot/initrd.img-*-lowlatency image/casper/initrd.gz
# cp /usr/lib/syslinux/isolinux.bin image/isolinux/ NEEDS_FIX
cp /boot/memtest86+.bin image/install/memtest
##############################################################################################################################################################################################################################################################
# Boot instructions for the AviX user
echo 'splash.rle' | sudo tee image/isolinux/isolinux.txt
echo '' | sudo tee -a image/isolinux/isolinux.txt
echo '******************************************************************************' | sudo tee -a image/isolinux/isolinux.txt
echo '' | sudo tee -a image/isolinux/isolinux.txt
echo 'This is an AviX 2.0 Live CD.' | sudo tee -a image/isolinux/isolinux.txt
echo '' | sudo tee -a image/isolinux/isolinux.txt
echo 'For the default live system, enter "live".  To run memtest86+, enter "memtest"' | sudo tee -a image/isolinux/isolinux.txt
echo '' | sudo tee -a image/isolinux/isolinux.txt
echo '******************************************************************************' | sudo tee -a image/isolinux/isolinux.txt
# Splash screen
sudo apt-get install syslinux-utils
printf "\x18" >emptyfile
bmptoppm splash.bmp > splash.ppm
ppmtolss16 '#ffffff=7' < splash.ppm > splash.rle
##############################################################################################################################################################################################################################################################
# Boot-loader configuration
echo '
DEFAULT live
LABEL live
  menu label ^Start or install Ubuntu Remix
  kernel /casper/vmlinuz
  append  file=/cdrom/preseed/ubuntu.seed boot=casper initrd=/casper/initrd.gz quiet splash --
LABEL check
  menu label ^Check CD for defects
  kernel /casper/vmlinuz
  append  boot=casper integrity-check initrd=/casper/initrd.gz quiet splash --
LABEL memtest
  menu label ^Memory test
  kernel /install/memtest
  append -
LABEL hd
  menu label ^Boot from first hard disk
  localboot 0x80
  append -
DISPLAY isolinux.txt
TIMEOUT 300
PROMPT 1' | tee image/isolinux/isolinux.cfg
##############################################################################################################################################################################################################################################################
# Create manifest
sudo chroot chroot dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee image/casper/filesystem.manifest
sudo cp -v image/casper/filesystem.manifest image/casper/filesystem.manifest-desktop
REMOVE='ubiquity ubiquity-frontend-gtk ubiquity-frontend-kde casper lupin-casper live-initramfs user-setup discover1 xresprobe os-prober libdebian-installer4'
for i in $REMOVE 
do
        sudo sed -i "/${i}/d" image/casper/filesystem.manifest-desktop
done