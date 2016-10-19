#!/bin/sh

if [ "$OSTYPE" = "netbsd" ]; then
	echo "skipping standby monitor setup, unsupported system"
	exit 0
fi

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	sed -i -e "/scripts\/check\/standby.sh/d" /etc/crontab
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi
