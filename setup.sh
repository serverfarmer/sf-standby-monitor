#!/bin/sh
. /opt/farm/scripts/init

if [ "`uname`" != "Linux" ]; then
	echo "skipping standby monitor setup, unsupported system"
	exit 0
elif [ "$HWTYPE" = "container" ] || [ "$HWTYPE" = "lxc" ]; then
	echo "skipping standby monitor setup on container"
	exit 0
fi

mkdir -p /var/cache/cacti

# transitional code: rename standby.exceptions to skip-smart.devices
if [ -f /etc/local/.config/standby.exceptions ] && [ ! -f /etc/local/.config/skip-smart.devices ]; then
	mv /etc/local/.config/standby.exceptions /etc/local/.config/skip-smart.devices
fi

touch /etc/local/.config/skip-smart.devices

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi
