#!/bin/sh

devices=`/opt/farm/ext/standby-monitor/utils/list-physical-drives.sh |grep -vxFf /etc/local/.config/standby.exceptions |grep -v SSD`

for device in $devices; do
	devname=`readlink -f $device`
	if grep -qxF $devname /var/cache/cacti/usb.tmp && [ "`hdparm -C $device 2>&1 |grep standby`" = "" ]; then
		echo $device
	fi
done
