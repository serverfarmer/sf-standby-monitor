#!/bin/sh
. /opt/farm/scripts/init

if [ "$OSTYPE" = "freebsd" ] || [ "$OSTYPE" = "netbsd" ]; then
	echo "skipping standby monitor setup, unsupported system"
	exit 0
fi

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi
