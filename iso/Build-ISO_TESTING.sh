#!/bin/bash
##############################################################################################################################################################################################################################################################
# Install debootstrap
sudo apt-get install debootstrap
##############################################################################################################################################################################################################################################################
# Create chroot environment
mkdir -p -v ~/SparkleShare/iso/work/chroot
sudo debootstrap --arch=amd64 `lsb_release -c -s` chroot
##############################################################################################################################################################################################################################################################
# Network start config
sudo cp /etc/hosts chroot/etc/hosts
sudo cp /etc/resolv.conf chroot/etc/resolv.conf
sudo cp /etc/apt/sources.list chroot/etc/apt/sources.list
##############################################################################################################################################################################################################################################################
# No password on sudo
# /etc/sudoers.d/avix
sudo touch /etc/sudoers.d/avix
echo '%sudo ALL=NOPASSWD: ALL'|sudo tee /etc/sudoers.d/avix
sudo chmod 0440 -v /etc/sudoers.d/avix
##############################################################################################################################################################################################################################################################
# Add user in audio group
# /etc/adduser.conf
sudo sed -i 's/#EXTRA_GROUPS="dialout cdrom floppy audio video plugdev users"/EXTRA_GROUPS="dialout cdrom floppy audio video plugdev users"/g' /etc/adduser.conf
sudo sed -i 's/#ADD_EXTRA_GROUPS=1/ADD_EXTRA_GROUPS=1/g' /etc/adduser.conf
sudo usermod -a -G audio $USER
##############################################################################################################################################################################################################################################################
# Configure default sources
# /etc/apt/sources.list
# Remove sources
sudo sed -i 's/#\ deb-src/deb-src/g' /etc/apt/sources.list
sudo sed -i 's/deb-src/#deb-src/g' /etc/apt/sources.list
# Activate partners
sudo sed -i 's/# deb http:\/\/archive.canonical.com\/ubuntu `lsb_release -c -s` partner/deb http:\/\/archive.canonical.com\/ubuntu `lsb_release -c -s` partner/g' /etc/apt/sources.list
##############################################################################################################################################################################################################################################################
# Auto accept TOS
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
##############################################################################################################################################################################################################################################################
# Keep configurations of the APT packages against new defaults from update and no install recommends & suggests
echo 'APT::Install-Recommends "0";' | sudo tee /etc/apt/apt.conf
echo 'APT::Install-Suggests "0";' | sudo tee -a /etc/apt/apt.conf
echo 'Dpkg::Options {' | sudo tee -a /etc/apt/apt.conf
echo '		"--force-confdef";' | sudo tee -a /etc/apt/apt.conf
echo '		"--force-confold";' | sudo tee -a /etc/apt/apt.conf
echo '};' | sudo tee -a /etc/apt/apt.conf
##############################################################################################################################################################################################################################################################
# Repositories tools
apt-get update
apt-get install -y software-properties-common wget apt-transport-https
##############################################################################################################################################################################################################################################################
# Add PPAs
# Graphics drivers PPA #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:graphics-drivers/ppa
# Oibaf graphics drivers #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:oibaf/graphics-drivers
# Numix PPA #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:numix/ppa
# Nemo PPA(WebUpd8Team) #TRUSTY #VIVID
sudo add-apt-repository -y ppa:webupd8team/nemo
sudo sed -i 's/wily/vivid/g' /etc/apt/sources.list.d/webupd8team-ubuntu-nemo-wily.list #WILY TMP_FIX
# Folder color PPA #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:costales/folder-color
# Simple screen recorder PPA #TRUSTY #VIVID
sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
sudo sed -i 's/wily/vivid/g' /etc/apt/sources.list.d/maarten-baert-ubuntu-simplescreenrecorder-wily.list #WILY TMP_FIX
# Oracle Java PPA #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:webupd8team/java
# GIMP extras PPA #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
# LibreOffice PPA #TRUSTY #VIVID #WILY
sudo add-apt-repository -y ppa:libreoffice/ppa
# Haguichi PPA #TRUSTY #VIVID# #WILY
sudo add-apt-repository -y ppa:webupd8team/haguichi
##############################################################################################################################################################################################################################################################
# Extra repositories
# KXStudio repositories #TRUSTY #VIVID #WILY
cd ~/tmp
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.2.1~kxstudio1_all.deb
sudo dpkg -i ~/tmp/kxstudio-repos_9.2.1~kxstudio1_all.deb
# Vertex theme repository #TRUSTY #VIVID
cd ~/tmp
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/Release.key #WILY TMP_FIX
sudo apt-key add - < Release.key  
echo deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/ / | sudo tee /etc/apt/sources.list.d/vertex-theme-`lsb_release -c -s`.list #WILY TMP_FIX
rm -v ~/tmp/Release.key
# Spotify repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
# Syncthing repository
cd ~/tmp
wget -c https://syncthing.net/release-key.txt
sudo apt-key add - < release-key.txt
echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list
# VirtualBox repository
cd ~/tmp
wget -q https://www.virtualbox.org/download/oracle_vbox.asc
sudo apt-key add - < oracle_vbox.asc
echo deb http://download.virtualbox.org/virtualbox/debian `lsb_release -c -s|sed 's/wily/vivid/g'` contrib | sudo tee /etc/apt/sources.list.d/virtualbox-`lsb_release -c -s`.list #WILY TMP_FIX
# Purple-Facebook repository
cd ~/tmp
wget http://download.opensuse.org/repositories/home:jgeboski/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/Release.key #WILY TMP_FIX
sudo apt-key add - < Release.key  
echo deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/ / | sudo tee /etc/apt/sources.list.d/purple-facebook-`lsb_release -c -s`.list #WILY TMP_FIX
rm -v ~/tmp/Release.key
##############################################################################################################################################################################################################################################################
# DBus configuration
apt-get install -y dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
##############################################################################################################################################################################################################################################################
# Update repositories
sudo apt-get update
# Upgrade system
sudo apt-get dist-upgrade -y
##############################################################################################################################################################################################################################################################
# Live system dependences
apt-get install -y ubuntu-standard casper lupin-casper
apt-get install -y discover laptop-detect os-prober
##############################################################################################################################################################################################################################################################
# Organize system kernels
# Install lowlatency lernel
sudo apt-get install -y `lsb_release -c -s|sed 's/wily/linux-lowlatency/g'|sed 's/vivid/linux-lowlatency/g'|sed 's/trusty/linux-lowlatency-lts-utopic/g'`
##############################################################################################################################################################################################################################################################
# Install core apps
sudo apt-get install -y q4wine winbind wineasio playonlinux cadence pulseaudio-module-jack indicator-cpufreq oracle-java9-installer icedtea-plugin alsa-firmware
##############################################################################################################################################################################################################################################################
# Install desktop apps
sudo apt-get install -y nemo nemo-dropbox nemo-emblems nemo-share folder-color-nemo vertex-theme numix-icon-theme-circle deluge-gtk python-libtorrent parole qasmixer spotify-client libreoffice-style-tango shutter vinagre p7zip-rar rygel-preferences skype gtk2-engines-pixbuf:i386 unity-gtk2-module:i386 pyrenamer filezilla diodon liferea syncthing preload gshare undistract-me pidgin pidgin-extprefs pidgin-skype purple-facebook
# haguichi NEEDS_FIX
##############################################################################################################################################################################################################################################################
# Install config apps
sudo apt-get install -y system-config-samba synaptic deborphan bleachbit grsync
# modem-manager-gui NEEDS_FIX
##############################################################################################################################################################################################################################################################
# Install tool apps
sudo apt-get install -y git checkinstall gparted gdebi gufw unetbootin
sudo apt-get install -y `lsb_release -c -s|sed 's/wily/virtualbox/g'|sed 's/vivid/virtualbox-5.0/g'|sed 's/trusty/virtualbox-5.0/g'` #WILY TMP_FIX
##############################################################################################################################################################################################################################################################
# Install media apps
sudo apt-get install -y acetoneiso gimp gimp-plugin-registry inkscape simplescreenrecorder blender openshot kdenlive krita kde-l10n-ptbr handbrake brasero asunder ffmpeg lame tuxguitar-fluidsynth fluid-soundfont-gm rawtherapee openlp puddletag
##############################################################################################################################################################################################################################################################
# Install XFCE desktop apps
sudo apt-get install -y xfce4-session xfce4-panel xfce4-whiskermenu-plugin xfce4-indicator-plugin volti xfwm4 compton xscreensaver
##############################################################################################################################################################################################################################################################
# Remove orphaned packages 2x and keep libgcrypt11 for Spotify
sudo deborphan | xargs sudo apt-get -y remove --purge
sudo deborphan | xargs sudo apt-get -y remove --purge
sudo apt-get install -y libgcrypt11 #SPOTIFY TMP_FIX
# Purge autoremoved apps
sudo apt-get autoremove --purge -y
##############################################################################################################################################################################################################################################################
# XFCE desktop configs
# ~/.config/xfce4 + ~/.config/compton.conf + ~/.config/Trolltech.conf
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/xfce%2Bcompton%2Bqtconfig-settings.zip
unzip ~/Downloads/xfce+compton+qtconfig-settings.zip
cp -R -v ~/Downloads/xfce+compton+qtconfig-settings/* ~/.config/
# /etc/xdg/autostart/qasmixer.desktop #XFCE TMP_FIX
echo '' | sudo tee -a /etc/xdg/autostart/qasmixer.desktop
echo 'OnlyShowIn=Unity;' | sudo tee -a /etc/xdg/autostart/qasmixer.desktop
# /etc/xdg/autostart/vino-server.desktop #XFCE TMP_FIX
sudo sed -i 's/OnlyShowIn=GNOME;Unity;/OnlyShowIn=GNOME;Unity;XFCE;/g' /etc/xdg/autostart/vino-server.desktop
# /etc/xdg/autostart/haguichi-autostart.desktop #XFCE TMP_FIX
echo '' | sudo tee -a /etc/xdg/autostart/haguichi-autostart.desktop
echo 'OnlyShowIn=Unity;' | sudo tee -a /etc/xdg/autostart/haguichi-autostart.desktop
##############################################################################################################################################################################################################################################################
# Install bootloader
apt-get install -y grub2 plymouth-x11
##############################################################################################################################################################################################################################################################
# AviX branding
# /etc/lsb-release
sudo sed -i "s/`lsb_release -d -s`/AviX 2.0/g" /etc/lsb-release
# /etc/default/grub
sudo sed -i 's/-i\ -s/-d\ -s/g' /etc/default/grub
# Plymouth theme
cd /tmp
wget -c http://sourceforge.net/projects/avix/files/repository/data/debian%20apps/avix-plymouth_2.0_all.deb
sudo dpkg -i ~/Downloads/avix-plymouth_2.0_all.deb
# Unity dash icon
cd /tmp
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/artwork/launcher_bfb.png
sudo cp -v ~/Downloads/launcher_bfb.png /usr/share/unity/icons/launcher_bfb.png