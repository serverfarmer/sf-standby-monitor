#!/bin/sh

devices=`/opt/farm/ext/hardware-utils/storage/list-physical-drives.sh |grep -v SSD |grep -vxFf /etc/local/.config/skip-smart.devices`

file="/var/cache/cacti/usb.tmp"
/opt/farm/ext/hardware-utils/storage/list-usb-drives.sh >$file

for device in $devices; do
	devname=`readlink -f $device`
	if grep -qxF $devname $file && [ "`hdparm -C $device 2>&1 |grep standby`" = "" ]; then
		echo $device
	fi
done
