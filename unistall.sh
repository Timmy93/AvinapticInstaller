#!/bin/bash

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
export ICON_SUFFIX=_icon.png
export LIB_FOLDER="/usr/lib32"

echo '###Start unistalling ...###'
#Remove dependencies
sudo rm -rf -f $LIB_FOLDER/libgtk/
sudo rm -rf -f $LIB_FOLDER/libgmp/
sudo rm -f $LIB_FOLDER/libiconv.so.2
sudo rm -f /etc/ld.so.conf.d/avinaptic.conf
#Removes folders
sudo rm -f -rf $FOLDER_NAME
sudo rm -f -rf $TEMP_NAME
#Removes scripts
sudo rm -f /usr/local/bin/$CMD
sudo rm -f ~/bin/$CMD
#Removes setting
sudo rm -f /etc/ld.so.conf.d/avinaptic.conf
#Removes icon
sudo rm -f /usr/share/pixmaps/$CMD$ICON_SUFFIX
#Removes shortcuts
sudo rm -f /usr/share/applications/$NAME.desktop
sudo rm -f $XDG_DESKTOP_DIR/$NAME.desktop

#Update libraries
sudo ldconfig
echo '###All done###'
