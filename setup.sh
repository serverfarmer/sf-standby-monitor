#!/bin/sh

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	sed -i -e "/scripts\/check\/standby.sh/d" /etc/crontab
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi
