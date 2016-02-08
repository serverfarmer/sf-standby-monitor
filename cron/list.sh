#!/bin/sh

devices=`cat /opt/sf-standby-monitor/config/devices.conf |grep -v ^# |grep -v ^$`

for device in $devices; do
	if [ -h $device ] && [ "`hdparm -C $device 2>&1 |grep standby`" = "" ]; then
		echo $device
	fi
done
