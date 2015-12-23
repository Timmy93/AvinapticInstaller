#!/bin/bash
# Purpose:	Install AVInaptic
# Usage:	scriptname /path/to/file.sh
# Author:	Timmy93
# Date:		Sun Dec 19, 2015
# Version:	1
# Disclaimer:	It's just a try

#Get desktop folder name
if [ -r ~/.config/user-dirs.dirs ]
then
    . ~/.config/user-dirs.dirs
fi
if [ "$XDG_DESKTOP_DIR" = "" ]
then
    export XDG_DESKTOP_DIR=$HOME/Desktop
fi
#XDG_DESKTOP_DIR contains the name of the desktop

#Variables
#It's the command given to the shell to execute the program
export CMD=avinaptic
#It's the name of the program
export NAME="AVInaptic"

#Auto-generated or fixed variables
export TEMP_NAME=~/temp_$CMD
export FOLDER_NAME=/opt/$CMD
export ICON_SUFFIX=.png
export LIB_FOLDER="/usr/lib32"

#Other info
export LINK_ICON="https://chakraos.org/ccr/packages/av/avinaptic2/avinaptic2/avinaptic2.png"
export LINK_SOFTWARE="http://fsinapsi.altervista.org/code/avinaptic/avinaptic.zip"
export GENERIC_NAME="Report Video"
export CATEG="GTK;AudioVideo;"
export EN_COM="A free utility which reports many technical informations about multimedia files."
export IT_COM="Un programma che analizza file file multimediali e mostra informazioni sulle caratteristiche tecniche."

#Create folders
echo '###Creating folder###'
sudo mkdir -p $FOLDER_NAME
mkdir $TEMP_NAME
mkdir -p ~/bin

#Satisfy dependency
echo '###Installing dependencies###'
sudo mkdir -p $LIB_FOLDER/libgtk
sudo mkdir -p $LIB_FOLDER/libgmp
#Download libraries
#Download libgtk
echo '###Download libgtk###'
wget -q http://fsinapsi.altervista.org/code/avinaptic/libgtk.zip -O $TEMP_NAME/libgtk.zip
#Download libiconv
echo '###Download libiconv###'
sudo wget -q http://fsinapsi.altervista.org/code/avinaptic/libiconv.zip -O $TEMP_NAME/libiconv.zip
#Download libgmp
echo '###Download libgmp###'
sudo wget -q http://fsinapsi.altervista.org/code/avinaptic/libgmp.zip -O $TEMP_NAME/libgmp.zip
#Download libjpeg
sudo wget -q http://ftp.it.debian.org/debian/pool/main/libj/libjpeg6b/libjpeg62_6b1-1_i386.deb -O $TEMP_NAME/libjpeg.deb
#Install libraries
sudo unzip $TEMP_NAME/libgtk.zip -d /usr/lib32/libgtk/
sudo unzip $TEMP_NAME/libiconv.zip -d /usr/lib32/
sudo unzip $TEMP_NAME/libgmp.zip -d /usr/lib32/libgmp/
sudo gdebi --n $TEMP_NAME/libjpeg.deb
#Create config
sudo rm -f /etc/ld.so.conf.d/avinaptic.conf
sudo printf '/usr/lib32\n/usr/lib32/libgtk\n/usr/lib32/libgmp' > /etc/ld.so.conf.d/avinaptic.conf
#Update libraries
sudo ldconfig
echo '###Dependencies installed###'

#Download Main Software
echo '###Download Main Software###'
wget "$LINK_SOFTWARE" -O "$TEMP_NAME/$CMD.zip"

#Start settings
echo '###Setting up...###'
#Move Software to his folder
sudo unzip "$TEMP_NAME/$CMD.zip" -d "$FOLDER_NAME"

echo '###Create script###'
echo "#!/bin/bash
# Purpose:	
# Usage:	
# Author:	Timmy93
# Date:		
# Version:	
# Disclaimer:
$FOLDER_NAME/$CMD  \"\$1\"" > $TEMP_NAME/$CMD
sudo mv "$TEMP_NAME/$CMD" ~/bin/

echo '###Make it executable###'
chmod +x ~/bin/$CMD


#Create Hard Link
echo '###Create Hard Link###'
sudo ln -s ~/bin/$CMD /usr/local/bin
#Download Icon
wget -q $LINK_ICON -O $TEMP_NAME/$CMD$ICON_SUFFIX
sudo mv $TEMP_NAME/$CMD$ICON_SUFFIX /usr/share/pixmaps

#Create Shortcuts
shortcut="[Desktop Entry]
Encoding=UTF-8
Version=1.0
Name=$NAME
GenericName=$GENERIC_NAME
Exec=$CMD %f
Terminal=false
Icon=$CMD
Type=Application
Categories=$CATEG
Comment=$EN_COM
Comment[it]=$IT_COM"
echo "$shortcut" > "$TEMP_NAME/$NAME.desktop"
chmod +x "$TEMP_NAME/$NAME.desktop"
sudo cp "$TEMP_NAME/$NAME.desktop" /usr/share/applications/
cp "$TEMP_NAME/$NAME.desktop" "$XDG_DESKTOP_DIR/$NAME.desktop"

#Remove useless files
rm -rf -f "$TEMP_NAME"

echo '###All done###'
