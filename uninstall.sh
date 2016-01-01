#!/bin/sh

if grep -q /opt/sf-standby-monitor/cron /etc/crontab; then
	sed -i -e "/\/opt\/sf-standby-monitor\/cron/d" /etc/crontab
fi
