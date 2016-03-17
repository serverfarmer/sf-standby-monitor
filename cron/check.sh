#!/bin/bash
. /opt/farm/scripts/functions.custom

# This script checks every 30 minutes, which (mostly external) hard drives, that
# are configured as overheating, are not in the standby state - and if such drives
# are detedted, notifies the administrator.
# Tomasz Klim, Apr 2014, Mar 2015


devices=`cat /opt/farm/ext/standby-monitor/config/devices.conf |grep -v ^# |grep -v ^$`

for device in $devices; do
	if [ -h $device ] && [ "`hdparm -C $device 2>&1 |grep standby`" = "" ]; then
		smartctl -d sat -T permissive -a $device |mail -s "$device is not in standby mode" smart-alerts@`external_domain`
	fi
done


# force standby state:
# hdparm -y /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# query current state:
# hdparm -C /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# disable inactivity sleep timer:
# sdparm --clear STANDBY -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# enable inactivity sleep timer and restore other factory defaults:
# sdparm --defaults     --page=po -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME
# sdparm --set SCT=3000 --page=po -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# check if inactivity sleep timer is enabled and to what delay (3000 = 5 minutes):
# sdparm --get SCT --page=po -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME
