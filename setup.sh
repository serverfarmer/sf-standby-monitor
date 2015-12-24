#!/bin/sh

if ! grep -q /opt/sf-standby-monitor/cron/check.sh /etc/crontab; then
	sed -i -e "/scripts\/check\/standby.sh/d" /etc/crontab
	echo "*/30 * * * * root /opt/sf-standby-monitor/cron/check.sh" >>/etc/crontab
fi
