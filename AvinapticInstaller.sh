#!/bin/bash
#sudo -s

#Create folders
echo '###Creating folder###'
sudo mkdir -p /usr/lib32/libgtk
sudo mkdir -p /usr/lib32/libgmp
sudo mkdir -p /opt/avinaptic
mkdir ~/temp_avinaptic
#Download libgtk
echo '###Download libgtk###'
wget -nv http://fsinapsi.altervista.org/code/avinaptic/libgtk.zip -O ~/temp_avinaptic/libgtk.zip

#Download libiconv
echo '###Download libiconv###'
sudo wget -nv http://fsinapsi.altervista.org/code/avinaptic/libiconv.zip -O ~/temp_avinaptic/libiconv.zip

#Download libgmp
echo '###Download libgmp###'
sudo wget -nv http://fsinapsi.altervista.org/code/avinaptic/libgmp.zip -O ~/temp_avinaptic/libgmp.zip

#Download libjpeg
sudo wget -nv http://ftp.it.debian.org/debian/pool/main/libj/libjpeg6b/libjpeg62_6b1-1_i386.deb -O ~/temp_avinaptic/libjpeg.deb

#Download Avinaptic
echo '###Download Avinaptic###'
sudo wget -nv http://fsinapsi.altervista.org/code/avinaptic/avinaptic.zip -O ~/temp_avinaptic/avinaptic.zip

#Decompress files
echo '###Decompress all files###'
sudo unzip ~/temp_avinaptic/libgtk.zip -d /usr/lib32/libgtk/
sudo unzip ~/temp_avinaptic/libiconv.zip -d /usr/lib32/
sudo unzip ~/temp_avinaptic/libgmp.zip -d /usr/lib32/libgmp/
sudo unzip ~/temp_avinaptic/avinaptic.zip -d /opt/avinaptic
sudo gdebi --n ~/temp_avinaptic/libjpeg.deb

#Remove useless files
echo '###Remove useless files###'
#sudo rm /usr/lib32/libgtk/libgtk.zip
#sudo rm /usr/lib32/libiconv.zip
#sudo rm /usr/lib32/libgmp/libgmp.zip
#sudo rm /opt/avinaptic/avinaptic.zip

#Start settings
echo '###Setting up...###'
#Create config
sudo printf '/usr/lib32\n/usr/lib32/libgtk\n/usr/lib32/libgmp' > /etc/ld.so.conf.d/avinaptic.conf
#Create script
echo '###Create Dir###'
mkdir ~/bin

echo '###Create script###'
sudo printf '#!/bin/sh\n/opt/avinaptic/avinaptic' > ~/bin/avinaptic
echo '###Make it executable###'
chmod +x ~/bin/avinaptic
#Create Hard Link
echo '###Create Hard Link###'
sudo ln -s ~/bin/avinaptic /usr/local/bin
#Download Icon
sudo wget -nv https://chakraos.org/ccr/packages/av/avinaptic2/avinaptic2/avinaptic2.png -O /opt/avinaptic/avinaptic_icon.png

#Creo Shortcut
sudo printf '[Desktop Entry]\nEncoding=UTF-8\nVersion=1.0\nName=AVInaptic\nGenericName=Report\nExec=avinaptic\nTerminal=false\nIcon[en_US]=/opt/avinaptic/avinaptic_icon.png\nType=Application\nCategories=GTK;AudioVideo;\nComment[en_US]=A free utility which reports many technical informations about multimedia files\nComment[it]=Un programma che analizza file file multimediali e mostra informazioni sulle caratteristiche tecniche' > /usr/share/applications/Avinaptic.desktop
#Applico tutte le modifiche
sudo ldconfig
echo '###All done###'
