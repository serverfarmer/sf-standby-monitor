#!/bin/bash
. /opt/farm/scripts/functions.custom

# This script checks every 30 minutes for USB external drives, that are
# not in the standby state - to warn the administrator about the possible
# overheating.
# Tomasz Klim, Apr 2014, Mar 2015, Dec 2017


for device in `/opt/heartbeat/scripts/checks/not-standby.sh`; do
	smartctl -d sat -T permissive -a $device |mail -s "$device is not in standby mode" smart-alerts@`external_domain`
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
