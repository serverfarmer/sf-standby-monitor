#!/bin/sh

if grep -q /opt/farm/ext/standby-monitor/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/ext\/standby-monitor\/cron/d" /etc/crontab
fi
