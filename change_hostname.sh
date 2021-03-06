#!/bin/bash
msgbox "The RFC requires that the hostname contains only:
letters 'a' to 'z'
numbers '0' to '9'
and hyphen (-)
Note that a hostname cannot begin or end with a hyphen.
	
No other char/symbol/punctuation or white-spaces are allowed." 0 0 0
	
CH=`cat /etc/hostname | tr -d " \t\n\r"`
NH=$(whiptail --backtitle "$TITLE" --inputbox "Hostname" 0 40 "$CH" 3>&1 1>&2 2>&3)
	
if [ $? -eq 0 ]; then
	echo $NH > /etc/hostname
	cat /etc/hosts | sed s/"$CH"/"$NH"/g > /tmp/hosts
	mv /tmp/hosts /etc/hosts
	REBOOT=1
fi
msgbox "If your machine acts as a DNS Server, make sure to change the entry for the Name-Server as well."
