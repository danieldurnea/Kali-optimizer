#!/bin/bash
# *************************************************************************************** #
# ---------------------------------- EULA NOTICE ---------------------------------------- #
#                     Agreement between "Daniel Durnea" and "You"(user).                    #
# ---------------------------------- EULA NOTICE ---------------------------------------- #
#  1. By using this piece of software your bound to these point.                          #
#  2. This an End User License Agreement (EULA) is a legal between a software application #
#     author "Haroon Awan" and (YOU) user of this software.                               #
#  3. This software application grants users rights to use for any purpose or modify and  #
#     redistribute creative works.                                                        #
#  4. This software comes in "is-as" warranty, author "Haroon Awan" take no responsbility #
#     what you do with by/this software as your free to use this software.                #
#  5. Any other purpose(s) that it suites as long as it is not related to any kind of     #
#     crime or using it in un-authorized environment.                                     #
#  6. You can use this software to protect and secure your data information in any        #
#     environment.                                                                        #
#  7. It can also be used in state of being protection against the unauthorized use of    #
#     information.                                                                        #
#  8. It can be used to take measures achieve protection.                                 #
# *************************************************************************************** #

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
#OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"

echo -e $YELLOW"[ + ] Tweaking and making few adjustments "$ENDCOLOR
echo -e "y" | sudo tracker daemon -k
echo -e "y" | sudo tracker reset -r
sed -i -- 's/X-GNOME-Autostart-enabled=true/X-GNOME-Autostart-enabled=false/g' /etc/xdg/autostart/tracker-miner-fs.desktop
sed -i -- 's/X-GNOME-Autostart-enabled=true/X-GNOME-Autostart-enabled=false/g' /etc/xdg/autostart/tracker-store.desktop 
echo -e $YELLOW"[ + ] Done "$ENDCOLOR
echo -e 

echo -e $YELLOW"[ + ] Clearing cache and trash "$ENDCOLOR
sudo rm -r /etc/apt/sources.list.d/*
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
echo -e $YELLOW"[ + ] Done "$ENDCOLOR
echo -e 

echo -e $YELLOW"[ + ] Writing proper sources list "$ENDCOLOR
echo -e "y" | cp /etc/apt/sources.list /etc/apt/sources.list.backup
echo -e "y" | cp /root/Downloads/Kali-optimizer/sources.list /etc/apt/
echo -e $YELLOW"[ + ] Done "$ENDCOLOR
echo -e 

echo -e $YELLOW"[ + ] Updating kali "$ENDCOLOR
echo -e "y" | sudo apt autoremove
sudo apt clean
sudo apt purge $OLDCONF
sudo apt purge $OLDKERNELS
sudo apt update
echo -e $YELLOW"[ + ] Finished optimizing "$ENDCOLOR
echo -e $YELLOW"[ + ] Woah! There is no BAD MOJO now! "$ENDCOLOR
echo -e 
