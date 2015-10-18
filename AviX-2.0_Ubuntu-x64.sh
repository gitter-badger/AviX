#/bin/bash
##############################################################################################################################################################################################################################################################
# Ubuntu 15.04 (19/07/2015)
# Fresh install(27gb-SSD / + 120gb-HD /home)
# Video drivers install (NVIDIA 346)
# Video drivers update (NVIDIA 352)(PPA)
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
cd ~/Downloads
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.2.1~kxstudio1_all.deb
sudo dpkg -i ~/Downloads/kxstudio-repos_9.2.1~kxstudio1_all.deb
# Vertex theme repository #TRUSTY #VIVID
cd ~/Downloads
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/Release.key #WILY TMP_FIX
sudo apt-key add - < Release.key  
echo deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/ / | sudo tee /etc/apt/sources.list.d/vertex-theme-`lsb_release -c -s`.list #WILY TMP_FIX
rm -v ~/Downloads/Release.key
# Spotify repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
# Syncthing repository
cd ~/Downloads
wget -c https://syncthing.net/release-key.txt
sudo apt-key add - < release-key.txt
echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list
# VirtualBox repository
cd ~/Downloads
wget -q https://www.virtualbox.org/download/oracle_vbox.asc
sudo apt-key add - < oracle_vbox.asc
echo deb http://download.virtualbox.org/virtualbox/debian `lsb_release -c -s|sed 's/wily/vivid/g'` contrib | sudo tee /etc/apt/sources.list.d/virtualbox-`lsb_release -c -s`.list #WILY TMP_FIX
# Purple-Facebook repository
cd ~/Downloads
wget http://download.opensuse.org/repositories/home:jgeboski/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/Release.key #WILY TMP_FIX
sudo apt-key add - < Release.key  
echo deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_`lsb_release -r -s|sed 's/15.10/15.04/g'`/ / | sudo tee /etc/apt/sources.list.d/purple-facebook-`lsb_release -c -s`.list #WILY TMP_FIX
rm -v ~/Downloads/Release.key
##############################################################################################################################################################################################################################################################
# Organize system kernels
# Install lowlatency lernel
sudo apt-get install -y `lsb_release -c -s|sed 's/wily/linux-lowlatency/g'|sed 's/vivid/linux-lowlatency/g'|sed 's/trusty/linux-lowlatency-lts-utopic/g'`
# Remove generic kernel
sudo apt-get purge -y linux-generic linux-image-generic linux-headers-generic
sudo apt-get purge -y linux-generic-lts-utopic linux-image-generic-lts-utopic linux-headers-generic-lts-utopic
sudo apt-get purge -y linux-generic-lts-vivid linux-image-generic-lts-vivid linux-headers-generic-lts-vivid
sudo apt-get purge -y linux-generic-lts-wily linux-image-generic-lts-wily linux-headers-generic-lts-wily
sudo apt-get purge -y linux-image-`uname -r` linux-headers-`uname -r`
sudo rm -R -v /lib/modules/`uname -r`/
##############################################################################################################################################################################################################################################################
# Ubuntu extras keyring
sudo apt-get install -y `lsb_release -c -s|sed 's/trusty/ubuntu-extras-keyring/g'|sed 's/vivid/-f/g'|sed 's/wily/-f/g'` #TRUSTY TMP_FIX
##############################################################################################################################################################################################################################################################
# Update repositories
sudo apt-get update
# Upgrade system
sudo apt-get dist-upgrade -y
##############################################################################################################################################################################################################################################################
# Install core apps
sudo apt-get install -y q4wine winbind wineasio playonlinux cadence pulseaudio-module-jack indicator-cpufreq oracle-java9-installer icedtea-plugin alsa-firmware
##############################################################################################################################################################################################################################################################
# Install desktop apps
sudo apt-get install -y nemo nemo-dropbox nemo-emblems nemo-share folder-color-nemo vertex-theme numix-icon-theme-circle deluge-gtk python-libtorrent parole qasmixer spotify-client libreoffice-style-tango shutter vinagre p7zip-rar rygel-preferences skype gtk2-engines-pixbuf:i386 unity-gtk2-module:i386 pyrenamer filezilla diodon liferea syncthing haguichi preload gshare undistract-me pidgin pidgin-extprefs pidgin-skype purple-facebook
##############################################################################################################################################################################################################################################################
# Install config apps
sudo apt-get install -y system-config-samba synaptic deborphan bleachbit grsync modem-manager-gui
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
# Removed default apps
sudo apt-get purge -y xcursor-themes nautilus transmission-common totem-common gnome-mahjongg gnome-sudoku gnome-mines aisleriot empathy gnome-screenshot usb-creator-common remmina-common plymouth-theme-ubuntu-logo plymouth-theme-ubuntu-text plymouth-label software-center-aptdaemon-plugins rhythmbox-data rhythmbox
# Removed extra apps
sudo apt-get purge -y xfdesktop4-data xfce4-volumed meterbridge qsynth sni-qt:i386 steadyflow
# Purge autoremoved apps
sudo apt-get autoremove --purge -y
# Remove orphaned packages 2x and keep libgcrypt11 for Spotify
sudo deborphan | xargs sudo apt-get -y remove --purge
sudo deborphan | xargs sudo apt-get -y remove --purge
sudo apt-get install -y libgcrypt11 #SPOTIFY TMP_FIX
##############################################################################################################################################################################################################################################################
# Hamachi
cd ~/Downloads
wget -c https://secure.logmein.com/labs/logmein-hamachi_2.1.0.139-1_amd64.deb
sudo dpkg -i ~/Downloads/logmein-hamachi_2.1.0.139-1_amd64.deb
sudo apt-get install -f -y
sudo apt-get install -y haguichi-indicator
##############################################################################################################################################################################################################################################################
# Syncthing-GTK
cd ~/Downloads
wget -c http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/s/syncthing-gtk/syncthing-gtk_0.7.6-1~webupd8~`lsb_release -c -s`0_amd64.deb
sudo dpkg -i ~/Downloads/syncthing-gtk_0.7.6-1~webupd8~`lsb_release -c -s`0_amd64.deb
sudo apt-get install -f -y
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/data/config.json
mkdir -p -v ~/.config/syncthing-gtk
cp -v ~/Downloads/config.json ~/.config/syncthing-gtk/
sudo cp /usr/share/applications/syncthing-gtk.desktop /etc/xdg/autostart/syncthing-daemon.desktop
sudo sed -i 's/Exec=\/usr\/bin\/syncthing-gtk/Exec=syncthing -no-browser/g' /etc/xdg/autostart/syncthing-daemon.desktop
##############################################################################################################################################################################################################################################################
# Copy
cd ~/Downloads
wget -c https://copy.com/install/linux/Copy.tgz
tar xvzf ~/Downloads/Copy.tgz
sudo cp -R -v ~/Downloads/copy /opt/
sudo rm -r -v /opt/copy/x86
sudo rm -r -v /opt/copy/armv6h
echo '[Desktop Entry]' | sudo tee /usr/share/applications/copy.desktop
echo 'Name=Copy' | sudo tee -a /usr/share/applications/copy.desktop
echo 'GenericName=File Synchronizer' | sudo tee -a /usr/share/applications/copy.desktop
echo 'Comment=Sync your files across computers and to the web' | sudo tee -a /usr/share/applications/copy.desktop
echo 'Exec=/opt/copy/x86_64/CopyAgent' | sudo tee -a /usr/share/applications/copy.desktop
echo 'Terminal=false' | sudo tee -a /usr/share/applications/copy.desktop
echo 'Type=Application' | sudo tee -a /usr/share/applications/copy.desktop
echo 'Icon=copy' | sudo tee -a /usr/share/applications/copy.desktop
echo 'Categories=Network;FileTransfer;' | sudo tee -a /usr/share/applications/copy.desktop
echo 'StartupNotify=false' | sudo tee -a /usr/share/applications/copy.desktop
##############################################################################################################################################################################################################################################################
# MEOCloud
cd ~/Downloads
wget -c https://meocloud.pt/binaries/linux/amd64/meocloud-gui-latest_amd64_beta.deb
sudo dpkg -i ~/Downloads/meocloud-gui-latest_amd64_beta.deb
sudo apt-get install -f -y
##############################################################################################################################################################################################################################################################
# Messenger
cd ~/Downloads
wget -c https://github.com/Aluxian/Facebook-Messenger-Desktop/releases/download/v1.4.3/Messenger_linux64.deb
sudo dpkg -i ~/Downloads/Messenger_linux64.deb
##############################################################################################################################################################################################################################################################
# Quassel
sudo apt-get install -y quassel --no-install-recommends
# ~/.config/quasselrc
echo '[MainWindow]' | tee ~/.config/quasselrc
echo 'MenuBar=Disabled' | tee -a ~/.config/quasselrc
# ~/.config/quassel-irc.org/quasselclient.conf
mkdir -p -v ~/.config/quassel-irc.org
echo '[UiStyle]' | tee ~/.config/quassel-irc.org/quasselclient.conf
echo 'UseCustomStyleSheet=true' | tee -a ~/.config/quassel-irc.org/quasselclient.conf
echo CustomStyleSheetPath=/usr/share/`lsb_release -c -s|sed 's/trusty/kde4\/apps\/quassel/g'|sed 's/vivid/quassel/g'|sed 's/wily/quassel/g'`/stylesheets/jussi01-darktheme.qss | tee -a ~/.config/quassel-irc.org/quasselclient.conf
# /usr/share/'kde4/apps'/quassel/networks.ini
sudo sed -i 's/Kubuntu IRC/AviX IRC/g' /usr/share/`lsb_release -c -s|sed 's/trusty/kde4\/apps\/quassel/g'|sed 's/vivid/quassel/g'|sed 's/wily/quassel/g'`/networks.ini
sudo sed -i 's/#kubuntu/#AviX/g' /usr/share/`lsb_release -c -s|sed 's/trusty/kde4\/apps\/quassel/g'|sed 's/vivid/quassel/g'|sed 's/wily/quassel/g'`/networks.ini
# /usr/share/applications/suporte.desktop
sudo cp /usr/share/applications/quassel.desktop /usr/share/applications/suporte.desktop
sudo sed -i 's/Name\[pt_BR\]=Quassel IRC/Name\[pt_BR\]=Suporte técnico/g' /usr/share/applications/suporte.desktop
echo '' | sudo tee -a /usr/share/applications/suporte.desktop 
echo 'StartupWMClass=quassel' | sudo tee -a /usr/share/applications/suporte.desktop 
##############################################################################################################################################################################################################################################################
# CGRU Afanasy
cd ~/Downloads
wget -c http://ufpr.dl.sourceforge.net/project/cgru/2.0.6/cgru.2.0.6.ubuntu14.04.2_amd64.tar.gz
mkdir -p -v ~/Downloads/Afanasy
tar -vzxf ~/Downloads/cgru.2.0.6.ubuntu14.04.2_amd64.tar.gz -C ~/Downloads/Afanasy
sudo dpkg -i ~/Downloads/Afanasy/*.deb
sudo apt-get install -f -y
# /usr/local/share/applications/cgrukeeper.desktop
sudo sed -i 's/Icon=cgrumenuitem/Icon=preferences-system-network-sharing/g' /usr/local/share/applications/cgrukeeper.desktop 
##############################################################################################################################################################################################################################################################
# Cinelerra
sudo mkdir -p -v /opt/cinelerra
sudo chmod 777 -v /opt/cinelerra
sudo chown $USER -v /opt/cinelerra
cd ~/Downloads
wget -c http://cinelerra.org/2015/downloads/cinelerra-5.0-ubuntu-14.04.1-x86_64-20150817-static.txz
cp -v ~/Downloads/cinelerra-5.0-ubuntu-14.04.1-x86_64-20150817-static.txz /opt/cinelerra/
cd /opt/cinelerra
tar -xJf /opt/cinelerra/cinelerra-5.0-ubuntu-14.04.1-x86_64-20150817-static.txz
echo '[Desktop Entry]' | sudo tee /usr/share/applications/cinelerra.desktop
echo 'Name=Cinelerra' | sudo tee -a /usr/share/applications/cinelerra.desktop
echo 'Categories=AudioVideo;AudioVideoEditing;' | sudo tee -a /usr/share/applications/cinelerra.desktop
echo 'Exec=/opt/cinelerra/cinelerra' | sudo tee -a /usr/share/applications/cinelerra.desktop
echo 'Icon=avidemux' | sudo tee -a /usr/share/applications/cinelerra.desktop
echo 'Type=Application' | sudo tee -a /usr/share/applications/cinelerra.desktop
echo 'Terminal=false' | sudo tee -a /usr/share/applications/cinelerra.desktop
##############################################################################################################################################################################################################################################################
# Natron
cd ~/Downloads
wget -c http://downloads.natron.fr/Linux/releases/64bit/files/Natron_Linux_x86-64bits_v1.2.1.tar.gz
tar -vzxf ~/Downloads/Natron_Linux_x86-64bits_v1.2.1.tar.gz
sudo ./Natron_Linux_x86-64bits_v1.2.1
##############################################################################################################################################################################################################################################################
# The Foundry Nuke
cd ~/Downloads
wget -c http://thefoundry.s3.amazonaws.com/products/nuke/releases/9.0v7/Nuke9.0v7-linux-x86-release-64.tgz
tar xvzf ~/Downloads/Nuke9.0v7-linux-x86-release-64.tgz
sudo ~/Downloads/Nuke9.0v7-linux-x86-release-64-installer
sudo rm -R -v ~/Desktop
sudo rm -R -v ~/.gnome2
sudo killall -9 firefox
##############################################################################################################################################################################################################################################################
# MPV + Youtube-DL (For Firefox extension and Popcorn Time)
# https://addons.mozilla.org/en-US/firefox/addon/watch-with-mpv/
# Aditional player parameters: --geometry 480x270 --ontop --no-border
sudo apt-get install -y --no-install-recommends mpv youtube-dl libsdl2-2.0-0
##############################################################################################################################################################################################################################################################
# DeaDBeeF
cd ~/Downloads
wget -c http://ufpr.dl.sourceforge.net/project/deadbeef/debian/0.6.2/deadbeef-static_0.6.2-2_amd64.deb
sudo dpkg -i ~/Downloads/deadbeef-static_0.6.2-2_amd64.deb
##############################################################################################################################################################################################################################################################
# REAPER
# Install
cd ~/Downloads
wget -c http://reaper.fm/files/5.x/reaper504_x64-install.exe
wine ~/Downloads/reaper504_x64-install.exe /S
# Set launcher
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/artwork/reaper.png
cp -v ~/Downloads/reaper.png ~/.local/share/icons/
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/data/REAPER%20%28x64%29.desktop
sudo cp -v ~/Downloads/REAPER\ \(x64\).desktop /usr/share/applications/
echo '' | tee -a $HOME/.local/share/applications/wine/Programs/REAPER\ \(x64\)/ReaMote\ Slave\ \(x64\).desktop
echo 'StartupWMClass=reamote.exe' | tee -a $HOME/.local/share/applications/wine/Programs/REAPER\ \(x64\)/ReaMote\ Slave\ \(x64\).desktop
rm -v ~/Área\ de\ Trabalho/REAPER\ \(x64\).desktop
rm -v ~/Área\ de\ trabalho/REAPER\ \(x64\).desktop
# MIME
sudo mkdir -p -v /opt/reaper
sudo chmod 777 -v /opt/reaper
sudo chown $USER -v /opt/reaper
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/data/reaper.sh
cp -v ~/Downloads/reaper.sh /opt/reaper/
chmod +x /opt/reaper/reaper.sh
ln -s -v ~/.wine /opt/reaper/
ln -s -v ~/.wine/drive_c/Program\ Files/REAPER\ \(x64\)/ ~/.wine/drive_c/Program\ Files/REAPER
xdg-mime default REAPER\ \(x64\).desktop application/x-wine-extension-rpp application/x-wine-extension-rpp-back application/x-wine-extension-reaperthemezip
xdg-mime query default application/x-wine-extension-rpp
# REAPER SWS
cd ~/Downloads
wget -c http://sws.mj-s.com/download/featured/sws-v2.8.1.0-x64-install.exe
wine ~/Downloads/sws-v2.8.1.0-x64-install.exe /S
# REAPER codecs
# FFMPEG
cd ~/Downloads
wget -c http://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-1.2-win64-shared.7z
7z x ~/Downloads/ffmpeg-1.2-win64-shared.7z
cp -v ~/Downloads/ffmpeg-1.2-win64-shared/bin/*.dll ~/.wine/drive_c/Program\ Files/REAPER\ \(x64\)/
# LAME
cd ~/Downloads
wget -c https://www.dropbox.com/s/cbuav0t80t7pdc8/lame_enc64.dll
cp -v ~/Downloads/lame_enc64.dll ~/.wine/drive_c/Program\ Files/REAPER\ \(x64\)/lame_enc64.dll
# VST plugins
cd ~/Downloads
wget -c http://sourceforge.net/projects/avix/files/repository/data/tarball%20apps/plugins-vst.7z
7z x ~/Downloads/plugins-vst.zip
mv -v ~/Downloads/plugins-vst/* ~/Plugins\ VST/
ln -s ~/Plugins\ VST/ ~/.wine/drive_c/Program\ Files/REAPER\ \(x64\)/Plugins/FX/
# Optional VST plugins
# Drum Core 3 Free
#*cd ~/Downloads
#*wget -c http://www.sonomawireworks.com/drumcore/downloads/DrumCore3_FREE.exe
#*wine ~/Downloads/DrumCore3_FREE.exe
# SampleTank 3 Custom Shop
#*xdg-open http://www.ikmultimedia.com/products/sampletankcs/
# UVI Workstation
#*cd ~/Downloads/
#*wget -c http://files.uvi.net:8080/UVIWS/4-2.5.15-0_uviworkstation-2.5.15.exe
#*wine ~/Downloads/4-2.5.15-0_uviworkstation-2.5.15.exe
##############################################################################################################################################################################################################################################################
# LICEcap
cd ~/Downloads
wget -c http://www.cockos.com/licecap/licecap126-install.exe
wine ~/Downloads/licecap126-install.exe /S
rm -v ~/Área\ de\ Trabalho/LICEcap*
rm -v ~/Área\ de\ trabalho/LICEcap*
echo '' | tee -a ~/.local/share/applications/wine/Programs/LICEcap/LICEcap.desktop
echo 'StartupWMClass=licecap.exe' | tee -a ~/.local/share/applications/wine/Programs/LICEcap/LICEcap.desktop
##############################################################################################################################################################################################################################################################
# TagSpaces
sudo mkdir -p -v /opt/tagspaces
sudo chmod 777 -v /opt/tagspaces
sudo chown $USER -v /opt/tagspaces
cd ~/Downloads
wget -c http://www.tagspaces.org/downloads/tagspaces-1.12.0-linux64.tar.gz
tar -vzxf ~/Downloads/tagspaces-1.12.0-linux64.tar.gz
cp -R -v ~/Downloads/tagspaces-l64/* /opt/tagspaces
echo '[Desktop Entry]' | sudo tee /usr/share/applications/TagSpaces.desktop
echo 'Name=TagSpaces' | sudo tee -a /usr/share/applications/TagSpaces.desktop
echo 'Exec=/opt/tagspaces/tagspaces' | sudo tee -a /usr/share/applications/TagSpaces.desktop
echo 'Icon=tagspaces' | sudo tee -a /usr/share/applications/TagSpaces.desktop
echo 'StartupNotify=false' | sudo tee -a /usr/share/applications/TagSpaces.desktop
echo 'Categories=Categories=Utility;TextEditor;' | sudo tee -a /usr/share/applications/TagSpaces.desktop
echo 'Type=Application' | sudo tee -a /usr/share/applications/TagSpaces.desktop
##############################################################################################################################################################################################################################################################
# Popcorn Time
sudo mkdir -p -v /opt/Popcorn-Time
sudo chmod 777 -v /opt/Popcorn-Time
sudo chown $USER -v /opt/Popcorn-Time
cd ~/Downloads
wget -c https://get.popcorntime.io/build/Popcorn-Time-0.3.8-5-Linux-64.tar.xz
cp -v ~/Downloads/Popcorn-Time-0.3.8-5-Linux-64.tar.xz /opt/Popcorn-Time/
cd /opt/Popcorn-Time
tar -Jxf /opt/Popcorn-Time/Popcorn-Time-0.3.8-5-Linux-64.tar.xz
echo '[Desktop Entry]' | sudo tee /usr/share/applications/Popcorn-Time.desktop
echo 'Comment=Watch Movies and TV Shows instantly' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
echo 'Name=Popcorn Time' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
echo 'Exec=/opt/Popcorn-Time/Popcorn-Time' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
echo 'Icon=popcorntime' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
echo 'StartupNotify=false' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
echo 'Categories=AudioVideo;Video;Network;Player;P2P;' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
echo 'Type=Application' | sudo tee -a /usr/share/applications/Popcorn-Time.desktop
##############################################################################################################################################################################################################################################################
# Steam
cd ~/Downloads
wget -c https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo dpkg -i ~/Downloads/steam.deb
##############################################################################################################################################################################################################################################################
# App Grid
cd ~/Downloads
wget -c http://ppa.launchpad.net/appgrid/stable/ubuntu/pool/main/a/appgrid/appgrid_0.252_all.deb
sudo dpkg -i ~/Downloads/appgrid_0.252_all.deb
##############################################################################################################################################################################################################################################################
# Sublime Text
cd ~/Downloads
wget -c http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
sudo dpkg -i ~/Downloads/sublime-text_build-3083_amd64.deb
xdg-mime default sublime_text.desktop application/x-shellscript
##############################################################################################################################################################################################################################################################
# Cadence/Jack/Qasmixer/Volti
# ~/.config/Cadence/GlobalSettings.conf
mkdir -p -v ~/.config/Cadence
echo '[JACK]' | tee ~/.config/Cadence/GlobalSettings.conf
echo 'AutoStart=true' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo '' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo '[ALSA-Audio]' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo 'BridgeIndexType=0' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo '' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo '[A2J]' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo 'AutoStart=true' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo '' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo '[Pulse2JACK]' | tee -a ~/.config/Cadence/GlobalSettings.conf
echo 'AutoStart=true' | tee -a ~/.config/Cadence/GlobalSettings.conf
# ~/.config/jack/conf.xml
mkdir -p -v ~/.config/jack
echo '<?xml version="1.0"?>' | tee ~/.config/jack/conf.xml
echo '<!--' | tee -a ~/.config/jack/conf.xml
echo 'JACK settings, as persisted by D-Bus object.' | tee -a ~/.config/jack/conf.xml
echo "You probably don't want to edit this because" | tee -a ~/.config/jack/conf.xml
echo 'it will be overwritten next time jackdbus saves.' | tee -a ~/.config/jack/conf.xml
echo '-->' | tee -a ~/.config/jack/conf.xml
echo '<!-- Thu Sep 24 19:53:05 2015 -->' | tee -a ~/.config/jack/conf.xml
echo '<jack>' | tee -a ~/.config/jack/conf.xml
echo ' <engine>' | tee -a ~/.config/jack/conf.xml
echo '  <option name="driver">alsa</option>' | tee -a ~/.config/jack/conf.xml
echo ' </engine>' | tee -a ~/.config/jack/conf.xml
echo ' <drivers>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="loopback">' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="dummy">' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="net">' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="alsarawmidi">' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="netone">' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="alsa">' | tee -a ~/.config/jack/conf.xml
echo '   <option name="capture">none</option>' | tee -a ~/.config/jack/conf.xml
echo '   <option name="playback">none</option>' | tee -a ~/.config/jack/conf.xml
echo '   <option name="period">256</option>' | tee -a ~/.config/jack/conf.xml
echo '   <option name="softmode">false</option>' | tee -a ~/.config/jack/conf.xml
echo '   <option name="midi-driver">seq</option>' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo '  <driver name="firewire">' | tee -a ~/.config/jack/conf.xml
echo '  </driver>' | tee -a ~/.config/jack/conf.xml
echo ' </drivers>' | tee -a ~/.config/jack/conf.xml
echo ' <internals>' | tee -a ~/.config/jack/conf.xml
echo '  <internal name="netmanager">' | tee -a ~/.config/jack/conf.xml
echo '  </internal>' | tee -a ~/.config/jack/conf.xml
echo '  <internal name="audioadapter">' | tee -a ~/.config/jack/conf.xml
echo '  </internal>' | tee -a ~/.config/jack/conf.xml
echo '  <internal name="profiler">' | tee -a ~/.config/jack/conf.xml
echo '  </internal>' | tee -a ~/.config/jack/conf.xml
echo '  <internal name="netadapter">' | tee -a ~/.config/jack/conf.xml
echo '  </internal>' | tee -a ~/.config/jack/conf.xml
echo ' </internals>' | tee -a ~/.config/jack/conf.xml
echo '</jack>' | tee -a ~/.config/jack/conf.xml
# ~/.config/qastools/qasmixer.conf
mkdir -p -v ~/.config/qastools
echo '[General]' | tee ~/.config/qastools/qasmixer.conf
echo 'start_device_mode=1' | tee -a ~/.config/qastools/qasmixer.conf
echo 'start_user_device=hw:0' | tee -a ~/.config/qastools/qasmixer.conf
echo 'current_device="hw:CARD=2"' | tee -a ~/.config/qastools/qasmixer.conf
echo 'wheel_degrees=720' | tee -a ~/.config/qastools/qasmixer.conf
echo 'tray_on_close=true' | tee -a ~/.config/qastools/qasmixer.conf
echo 'tray_show_icon=true' | tee -a ~/.config/qastools/qasmixer.conf
echo 'tray_is_minimized=true' | tee -a ~/.config/qastools/qasmixer.conf
echo '' | tee -a ~/.config/qastools/qasmixer.conf
echo '[main_window]' | tee -a ~/.config/qastools/qasmixer.conf
echo 'window_state=@ByteArray(\0\0\0\xff\0\0\0\0\xfd\0\0\0\0\0\0\x4\xd4\0\0\x2\xb7\0\0\0\x4\0\0\0\x4\0\0\0\b\0\0\0\b\xfc\0\0\0\0)' | tee -a ~/.config/qastools/qasmixer.conf
echo 'window_geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x1\0\0\0\0\x2Z\0\0\0\xc0\0\0\aC\0\0\x3\xa7\0\0\x2\x65\0\0\0\xe6\0\0\a8\0\0\x3\x9c\0\0\0\0\0\0)' | tee -a ~/.config/qastools/qasmixer.conf
echo 'splitter_state=@ByteArray(\0\0\0\xff\0\0\0\0\0\0\0\x2\0\0\0\x84\0\0\0\xc5\x1\0\0\0\x6\x1\0\0\0\x1)' | tee -a ~/.config/qastools/qasmixer.conf
echo 'show_device_selection=true' | tee -a ~/.config/qastools/qasmixer.conf
echo '' | tee -a ~/.config/qastools/qasmixer.conf
echo '[device_selection]' | tee -a ~/.config/qastools/qasmixer.conf
echo 'selection_db=default, "hw:CARD=2"' | tee -a ~/.config/qastools/qasmixer.conf
echo '' | tee -a ~/.config/qastools/qasmixer.conf
echo '[simple_mixer]' | tee -a ~/.config/qastools/qasmixer.conf
echo 'show_stream_playback=true' | tee -a ~/.config/qastools/qasmixer.conf
echo 'show_stream_capture=true' | tee -a ~/.config/qastools/qasmixer.conf
echo 'show_slider_value_labels=true' | tee -a ~/.config/qastools/qasmixer.conf
echo '' | tee -a ~/.config/qastools/qasmixer.conf
echo '[tray_mixer]' | tee -a ~/.config/qastools/qasmixer.conf
echo 'device_mode=1' | tee -a ~/.config/qastools/qasmixer.conf
echo 'user_device=hw:0' | tee -a ~/.config/qastools/qasmixer.conf
echo 'show_balloon=true' | tee -a ~/.config/qastools/qasmixer.conf
echo 'balloon_lifetime=4000' | tee -a ~/.config/qastools/qasmixer.conf
echo '' | tee -a ~/.config/qastools/qasmixer.conf
echo '[settings_dialog]' | tee -a ~/.config/qastools/qasmixer.conf
echo 'page=3' | tee -a ~/.config/qastools/qasmixer.conf
# /etc/xdg/autostart/qasmixer.desktop
sudo sed -i 's/Icon=qasmixer/Icon=Veromix/g' /usr/share/applications/qasmixer.desktop
sudo cp -v /usr/share/applications/qasmixer.desktop /etc/xdg/autostart/
sudo sed -i 's/Exec=qasmixer/Exec=qasmixer --tray/g' /etc/xdg/autostart/qasmixer.desktop
# ~/.config/volti/config
cd ~/Downloads
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/data/config
mkdir -p -v ~/.config/volti
cp -v ~/Downloads/config ~/.config/volti/config
# /usr/share/applications/unity-sound-panel.desktop
sudo sed -i 's/Exec=unity-control-center sound/Exec=cadence/g' /usr/share/applications/unity-sound-panel.desktop
sudo sed -i 's/X-Unity-Settings-Panel=sound/X-Unity-Settings-Panel=/g' /usr/share/applications/unity-sound-panel.desktop
##############################################################################################################################################################################################################################################################
# WINEASIO register
regsvr32 wineasio.dll
wine64 regsvr32 wineasio.dll
##############################################################################################################################################################################################################################################################
# Nemo as default
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
xdg-mime query default inode/directory
##############################################################################################################################################################################################################################################################
# WINE as default
xdg-mime default wine.desktop application/x-ms-dos-executable
xdg-mime query default application/x-ms-dos-executable
##############################################################################################################################################################################################################################################################
# Parole settings
# ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
mkdir -p -v ~/.config/xfce4/xfconf/xfce-perchannel-xml
echo '<?xml version="1.0" encoding="UTF-8"?>' | tee ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '<channel name="parole" version="1.0">' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  <property name="subtitles" type="empty">' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '    <property name="font" type="string" value="Sans Bold 20"/>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  </property>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  <property name="window" type="empty">' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '    <property name="maximized" type="bool" value="false"/>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '    <property name="width" type="int" value="720"/>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '    <property name="height" type="int" value="480"/>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  </property>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  <property name="audio" type="empty">' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '    <property name="volume" type="int" value="100"/>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  </property>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '  <property name="video" type="empty">' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '    <property name="videosink" type="string" value="cluttersink"/>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
echo '</channel>' | tee -a ~/.config/xfce4/xfconf/xfce-perchannel-xml/parole.xml
##############################################################################################################################################################################################################################################################
# GIMP settings
# ~/.gimp-2.8
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/gimp-2.8.zip
unzip ~/Downloads/gimp-2.8.zip
mkdir -p -v ~/.gimp-2.8
cp -R -v ~/Downloads/gimp-2.8/* ~/.gimp-2.8
##############################################################################################################################################################################################################################################################
# System config samba
# /etc/libuser.conf
sudo touch /etc/libuser.conf #VIVID&WILY TMP_FIX
##############################################################################################################################################################################################################################################################
# TuxGuitar/FluidSynth
# ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
mkdir -p -v ~/.tuxguitar-1.2/plugins
echo '#Plugin Configuration' | tee ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo '#Mon Sep 21 19:02:09 BRT 2015' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'audio.periods=16' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'soundfont.path0=/usr/share/sounds/sf2/FluidR3_GM.sf2' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'synth.chorus.active=yes' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'audio.sample-format=16bits' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'synth.polyphony=256' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'audio.period-size=64' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'synth.reverb.active=yes' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'audio.driver=pulseaudio' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'synth.gain=0.2' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'soundfont.count=1' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
echo 'synth.sample-rate=48000.0' | tee -a ~/.tuxguitar-1.2/plugins/tuxguitar-fluidsynth.cfg
# ~/.tuxguitar-1.2/config.properties
echo 'midi.port=tuxguitar-fluidsynth_/usr/share/sounds/sf2/FluidR3_GM.sf2' | tee -a ~/.tuxguitar-1.2/config.properties
##############################################################################################################################################################################################################################################################
# Inkscape icon theme
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/icons.svg.7z
7z x ~/Downloads/icons.svg.7z
mkdir -p -v ~/.config/inkscape/icons/
cp -v icons.svg ~/.config/inkscape/icons/
##############################################################################################################################################################################################################################################################
# KDEnLive Krita-Dark theme
# ~/.kde/share/config/
mkdir -p -v ~/.kde/share/config
echo '[unmanaged]' | tee ~/.kde/share/config/kdenliverc
echo 'colortheme=/usr/share/kde4/apps/color-schemes/KritaDark.colors' | tee -a ~/.kde/share/config/kdenliverc
##############################################################################################################################################################################################################################################################
# OpenShot Holo theme
# ~/.openshot/config.xml
mkdir -p -v ~/.openshot
echo '<?xml version="1.0" encoding="UTF-8"?><settings><app_state><upload_username></upload_username><vpane_position>370</vpane_position><toolbar_visible>True</toolbar_visible><clip_property_window_width>775</clip_property_window_width><window_height>710</window_height><vimeo_token></vimeo_token><clip_property_window_height>345</clip_property_window_height><vimeo_verifier></vimeo_verifier><window_width>900</window_width><hpane_position>450</hpane_position><import_folder>None</import_folder><clip_property_hpane_position>260</clip_property_hpane_position><history_visible>False</history_visible><upload_service>YouTube</upload_service><clip_property_window_maximized>False</clip_property_window_maximized><vimeo_token_secret></vimeo_token_secret><window_maximized>False</window_maximized></app_state><general><use_affine>Yes</use_affine><output_mode>sdl</output_mode><default_theme>holo</default_theme><save_interval>1</save_interval><imported_image_length>7.00</imported_image_length><melt_command>melt</melt_command><max_history_size>20</max_history_size><project_file_type>ascii</project_file_type><save_before_playback>False</save_before_playback><blender_command>blender</blender_command><use_stock_icons>Yes</use_stock_icons><default_profile>HD 1080p 30 fps</default_profile><icon_size>medium</icon_size><autosave_enabled>False</autosave_enabled></general></settings>' | tee -a ~/.openshot/config.xml
##############################################################################################################################################################################################################################################################
# Undistract-me
# ~/.bashrc
echo '' | tee -a ~/.bashrc
echo '. /usr/share/undistract-me/long-running.bash' | tee -a ~/.bashrc
echo 'notify_when_long_running_commands_finish_install' | tee -a ~/.bashrc
source ~/.bashrc
# /usr/share/undistract-me/long-running.bash
sudo sed -i 's/Long command completed/Comando concluído/g' /usr/share/undistract-me/long-running.bash
sudo sed -i 's/dialog-information/xterm-color/g' /usr/share/undistract-me/long-running.bash
sudo sed -i 's/took/levou/g' /usr/share/undistract-me/long-running.bash
##############################################################################################################################################################################################################################################################
# AviX XSessions
# /usr/share/xsessions/ubuntu.desktop
sudo sed -i 's/Name=Ubuntu/Name=AviX (Unity)/g' /usr/share/xsessions/ubuntu.desktop 
# /usr/share/xsessions/xfce.desktop
sudo sed -i 's/Name\[pt_BR\]=Sessão do Xfce/Name\[pt_BR\]=AviX (XFCE)/g' /usr/share/xsessions/xfce.desktop
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
# Keep configurations of the APT packages against new defaults from update
# /etc/apt/apt.conf
cd ~/Downloads
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/data/apt.conf
sudo cp -R -v ~/Downloads/apt.conf /etc/apt/apt.conf
##############################################################################################################################################################################################################################################################
# AviX branding
# /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 14.04 LTS"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 14.04.1 LTS"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 14.04.2 LTS"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 14.04.3 LTS"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 15.04"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 15.10"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release
sudo sed -i 's/DISTRIB_DESCRIPTION="Ubuntu Wily Werewolf (development branch)"/DISTRIB_DESCRIPTION="AviX 2.0"/g' /etc/lsb-release #WILY TMP_FIX
# /etc/default/grub
sudo sed -i 's/-i\ -s/-d\ -s/g' /etc/default/grub
# Plymouth theme
cd ~/Downloads
wget -c http://sourceforge.net/projects/avix/files/repository/data/debian%20apps/avix-plymouth_2.0_all.deb
sudo dpkg -i ~/Downloads/avix-plymouth_2.0_all.deb
# Wallpaper
cd ~/Downloads
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/artwork/Wowpeiper.jpg
mkdir -p -v ~/Imagens/Wallpapers
mv -v ~/Downloads/Wowpeiper.jpg ~/Imagens/Wallpapers/avix-wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri file:///$HOME/Imagens/Wallpapers/avix-wallpaper.jpg
# Unity dash icon
cd ~/Downloads
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/artwork/launcher_bfb.png
sudo cp -v ~/Downloads/launcher_bfb.png /usr/share/unity/icons/launcher_bfb.png
# Unity desktop name
cd ~/Downloads
echo 'msgid "Ubuntu Desktop"' | tee unity.po
echo 'msgstr "Área de trabalho"' | tee -a unity.po
sudo msgfmt -o /usr/share/locale/pt_BR/LC_MESSAGES/unity.mo unity.po
# System details
cd ~/Downloads
wget -c https://raw.githubusercontent.com/rauldipeas/AviX/master/artwork/UbuntuLogo.png
sudo cp -v ~/Downloads/UbuntuLogo.png /usr/share/unity-control-center/ui/UbuntuLogo.png
# Remove LightDM Unity greeter logo
sudo rm -v /usr/share/unity-greeter/logo.png
sudo rm -v /usr/share/unity-greeter/cof.png
##############################################################################################################################################################################################################################################################
# LibreOffice M$Office
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/images_tango.zip
sudo cp -v ~/Downloads/images_tango.zip /usr/share/libreoffice/share/config/
##############################################################################################################################################################################################################################################################
# Pidgin Numix Theme
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/pidgin.tar.gz
sudo tar -vzxf pidgin.tar.gz -C /usr/share/pixmaps/
##############################################################################################################################################################################################################################################################
# Vertex Firefox Theme
killall -9 firefox
cd ~/Downloads
git clone git://github.com/horst3180/vertex-theme.git --depth 1
cp -R -v ~/Downloads/vertex-theme/extra/Firefox/Vertex/chrome ~/.mozilla/firefox/*.default/
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
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/sparkle-share-indicators.7z
7z x sparkle-share-indicators.7z
sudo cp -v ~/Downloads/sparkle-share-indicators/24/* /usr/share/icons/hicolor/24x24/status/
sudo cp -v ~/Downloads/sparkle-share-indicators/48/* /usr/share/icons/hicolor/48x48/status/
##############################################################################################################################################################################################################################################################
# Set Folder Icons
# Dropbox
mkdir -p -v ~/Dropbox
gvfs-set-attribute ~/Dropbox/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/blue-folder-dropbox.svg
# MEOCloud
mkdir -p -v ~/MEOCloud
gvfs-set-attribute ~/MEOCloud/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/blue-folder-cloud.svg
# Copy
mkdir -p -v ~/Copy
gvfs-set-attribute ~/Copy/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/blue-folder-hdd.svg
# Plugins VST (Wine)
mkdir -p -v ~/Plugins\ VST
gvfs-set-attribute ~/Plugins\ VST/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/green-folder-system.svg
# VirtualBox
mkdir -p -v ~/VirtualBox\ VMs
gvfs-set-attribute ~/VirtualBox\ VMs/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/blue-folder-vm.svg
# Projetos
mkdir -p -v ~/Projetos
ln -s -v ~/Projetos ~/Copy/
gvfs-set-attribute ~/Projetos/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/red-folder-projects.svg
# Steam
mkdir -p -v ~/Steam
gvfs-set-attribute ~/Steam/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/grey-folder-steam.svg
# Sync (Synchhing)
mkdir -p -v ~/Sync
gvfs-set-attribute ~/Sync/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/purple-folder-recent.svg
# Shared Files (GShare)
mkdir -p -v ~/Shared\ Files
gvfs-set-attribute ~/Shared\ Files/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/purple-network.svg
# SparkleShare (GitHub)
mkdir -p -v ~/SparkleShare
gvfs-set-attribute ~/SparkleShare/ metadata::custom-icon file:///usr/share/icons/Numix/48/places/orange-folder-projects.svg
##############################################################################################################################################################################################################################################################
# Set Bookmarks
echo file:///home/$USER/Copy Copy | tee ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Documentos Documentos | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Downloads Downloads | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Dropbox Dropbox | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Imagens Imagens | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/MEOCloud MEOCloud | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Música Música | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Projetos Projetos | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/SparkleShare SparkleShare | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Sync Sync | tee -a ~/.config/gtk-3.0/bookmarks
echo file:///home/$USER/Vídeos Vídeos | tee -a ~/.config/gtk-3.0/bookmarks
##############################################################################################################################################################################################################################################################
# Better GPU Performance
# NVIDIA Powermizer Settings
cp -v /usr/share/applications/nvidia-settings.desktop ~/.config/autostart/
sed -i 's/Exec=\/usr\/bin\/nvidia-settings/Exec=nvidia-settings -a \[gpu:0\]\/GpuPowerMizerMode\=1/g' ~/.config/autostart/nvidia-settings.desktop
# Unity Low GFX Mode
echo 'export UNITY_LOW_GFX_MODE=1' | tee ~/.xprofile
##############################################################################################################################################################################################################################################################
# GShare settings and autostart
# ~/.gconf/apps/gshare/%gconf.xml
gconftool-2 --set /apps/gshare/enabled --type bool 1
gconftool-2 --set /apps/gshare/port --type int 10021
gconftool-2 --set /apps/gshare/allow_delete --type bool 0
gconftool-2 --set /apps/gshare/allow_write --type bool 0
gconftool-2 --set /apps/gshare/password --type string 123456
gconftool-2 --set /apps/gshare/username --type string $USER
gconftool-2 --set /apps/gshare/allow_anonymous --type bool 0
gconftool-2 --set /apps/gshare/first_time --type bool 0
gconftool-2 --set /apps/gshare/share_name --type string Arquivos\ compartilhados\ no\ `uname -n`
# /etc/xdg/autostart/gshare.desktop
echo '[Desktop Entry]' | sudo tee /etc/xdg/autostart/gshare.desktop
echo 'Name=GNOME Share Daemon' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'Comment=Launch Personal File Sharing if enabled' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'Icon=purple-network' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'Exec=gshared' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'Terminal=false' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'Type=Application' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'OnlyShowIn=GNOME;Unity;XFCE;' | sudo tee -a /etc/xdg/autostart/gshare.desktop
echo 'X-GNOME-Autostart-Delay=15' | sudo tee -a /etc/xdg/autostart/gshare.desktop
##############################################################################################################################################################################################################################################################
# VNC remote access
gsettings set org.gnome.Vino enabled true
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino authentication-methods \[\'vnc\'\]
gsettings set org.gnome.Vino vnc-password \'MTIzNDU2\'
##############################################################################################################################################################################################################################################################
# Custom keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/']"
# Volume up
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up ''
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Aumentar o volume'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'amixer set Master 6%+'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'AudioRaiseVolume'
# Volume down
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down ''
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Diminuir o volume'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'amixer set Master 6%-'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding 'AudioLowerVolume'
# Print full screen
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot ''
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip  ''
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Capturar a tela inteira'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'env GTK_DATA_PREFIX="/opt/dark-theme" shutter -f'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding 'Print'
# Print screen selection
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot ''
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip  ''
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'Selecionar uma área para capturar'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'env GTK_DATA_PREFIX="/opt/dark-theme" shutter -s'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Shift>Print'
# Clear misc keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute ''
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot ''
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip  ''
##############################################################################################################################################################################################################################################################
# CompizConfig settings manager options
# Ubuntu Unity Plugin > General > Panel Opacity = 0,2000
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ panel-opacity 0.2000
# Ubuntu Unity Plugin > General > Panel Opacity for Maximized Windows Toogle = true
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ panel-opacity-maximized-toggle true
# Ubuntu Unity Plugin > General > Background Color = #000000+Opacidade = 80
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ background-color '#00000050'
# Ubuntu Unity Plugin > Launcher > Launcher Opacity = 0,2000
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-opacity 0.2000
# Ubuntu Unity Plugin > Launcher > Minimize Single Window Applications (Unsupported) = true
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
# Mover Janela > Iniciar Movimento de Janelas = <Super>Button1
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier \<Super\>
# Colocar Janelas > Geral > Modo de Multi Saída = Usar dispositivo de saída com o cursor
gsettings set org.compiz.place:/org/compiz/profiles/unity/plugins/place/ multioutput-mode 1
# Unity Favorites
gsettings set com.canonical.Unity.Launcher favorites \[\'application://nemo.desktop\'\,\ \'application://firefox.desktop\'\,\ \'application://messengerfordesktop.desktop\'\,\ \'application://haguichi.desktop\'\,\ \'application://REAPER\ \(x64\).desktop\'\,\ \'application://cinelerra.desktop\'\,\ \'application://gimp.desktop\'\,\ \'application://blender.desktop\'\,\ \'application://suporte.desktop\'\,\ \'unity://running-apps\'\,\ \'unity://expo-icon\'\,\ \'unity://devices\'\]
##############################################################################################################################################################################################################################################################
# Unity tweak tool options
# Unity > Pesquisar > Buscar fontes online = false
gsettings set com.canonical.Unity.Lenses remote-content-search none
# Unity > Pesquisar > Mostrar "mais sugestões" = false
gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
# Unity > Barra superior > Data = true
gsettings set com.canonical.indicator.datetime show-date true
# Unity > Barra superior > Dia da semana = true
gsettings set com.canonical.indicator.datetime show-day true
# Unity > Barra superior > Volume = false
gsettings set com.canonical.indicator.sound visible false
# Sistema > Rolagem > Barras de rolagem = Antigo
gsettings set com.canonical.desktop.interface scrollbar-mode normal
# Hide Keyboard-Type Indicator
gsettings set com.canonical.indicator.keyboard visible false
# Set Power Indicator to charge
gsettings set com.canonical.indicator.power icon-policy charge
# Set GTK Theme
gsettings set org.gnome.desktop.interface gtk-theme Vertex
# Set Icon Theme
gsettings set org.gnome.desktop.interface icon-theme Numix-Circle
# Set Menu Have Icons
gsettings set org.gnome.desktop.interface menus-have-icons true
# Set Buttons Have Icons
gsettings set org.gnome.desktop.interface buttons-have-icons true
##############################################################################################################################################################################################################################################################
# Set Fonts
cd ~/Downloads
wget -c https://github.com/rauldipeas/AviX/raw/master/data/fonts.zip
unzip ~/Downloads/fonts.zip
sudo mkdir -p -v /usr/share/fonts/avix
sudo cp -R -v ~/Downloads/fonts/* /usr/share/fonts/avix/
gsettings set org.gnome.desktop.interface font-name 'Proxima Nova 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Anonymous Pro 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Proxima Nova Semi-Bold 10'
##############################################################################################################################################################################################################################################################
# Update Grub
sudo update-grub
##############################################################################################################################################################################################################################################################
# Restart System
sudo shutdown -r 0