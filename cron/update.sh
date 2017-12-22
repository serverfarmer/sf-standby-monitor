#!/bin/sh

file="/var/cache/cacti/usb.tmp"

/opt/farm/ext/standby-monitor/utils/list-usb-drives.sh >$file.new
mv -f $file.new $file 2>/dev/null
