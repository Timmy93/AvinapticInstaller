#!/bin/bash
echo '###Start unistalling ...###'
sudo rm -rf /usr/lib32/libgtk/
sudo rm -rf /usr/lib32/libgmp/
sudo rm /usr/lib32/libiconv.so.2
sudo rm -rf /opt/avinaptic/
sudo rm /etc/ld.so.conf.d/avinaptic.conf
sudo rm -rf ~/temp_avinaptic/
sudo rm /usr/local/bin/avinaptic
sudo rm /usr/share/applications/Avinaptic.desktop
echo '###All done###'
