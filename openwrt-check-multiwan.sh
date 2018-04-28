#!/bin/sh

# This script is intended for checking and switching between 2 WANs in openwrt.
# In this case we are switching between default wan and a second USB_WAN.
# If USB_WAN (mobile usb tethering) is available the router should only use USB_WAN and disable the
# other one.
# If not available then it switches back to the default wan.
# It should be called regularly from cron

usb_available=0
usb_up=0
wan_up=0

# check availability
ifstatus USB_WAN | grep -i available | grep -i true > /dev/null
RETVAL=$?      
[ $RETVAL -eq 0 ] && usb_available=1 
[ $RETVAL -ne 0 ] && usb_available=0 

# check if already up
ifstatus USB_WAN | grep -i up | grep -i true > /dev/null
RETVAL=$?
[ $RETVAL -eq 0 ] && usb_up=1 
[ $RETVAL -ne 0 ] && usb_up=0

# check if already up
ifstatus wan | grep -i up | grep -i true > /dev/null
RETVAL=$?
[ $RETVAL -eq 0 ] && wan_up=1 
[ $RETVAL -ne 0 ] && wan_up=0  
                                
if [ $usb_available -eq 1 ]
then
	if [ $usb_up -eq 0 ] || [ $usb_up -eq 1 ] &&  [ $wan_up -eq 1 ]
	then
		# reconfigure interfaces:
		echo disabling wan interface and enabling usb_wan
		ifdown USB_WAN
		ifdown wan
		ifup USB_WAN
	else
		echo usb_wan is up and wan is down
	fi
fi

if [ $usb_available -eq 0 ]
then
	if [ $wan_up -eq 0 ]
	then
		# reconfigure interfaces:
		echo enabling wan interface and disabling usb_wan
		ifdown USB_WAN
		ifup wan
	else
		echo wan is up and usb_wan is down
	fi
fi
