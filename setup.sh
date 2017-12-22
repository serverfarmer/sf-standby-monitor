#!/bin/sh
. /opt/farm/scripts/init

if [ "`uname`" != "Linux" ]; then
	echo "skipping standby monitor setup, unsupported system"
	exit 0
elif [ "$HWTYPE" = "container" ] || [ "$HWTYPE" = "lxc" ]; then
	echo "skipping standby monitor setup on container"
	exit 0
fi

touch /var/cache/cacti/usb.tmp
touch /etc/local/.config/standby.exceptions

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi

if ! grep -q /opt/farm/ext/standby-monitor/cron/update.sh /etc/crontab; then
	echo "59 * * * * root /opt/farm/ext/standby-monitor/cron/update.sh" >>/etc/crontab
fi
