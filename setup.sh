#!/bin/sh
. /opt/farm/scripts/init

if [ "`uname`" != "Linux" ]; then
	echo "skipping standby monitor setup, unsupported system"
	exit 0
elif [ "$HWTYPE" = "container" ] || [ "$HWTYPE" = "lxc" ]; then
	echo "skipping standby monitor setup on container"
	exit 0
fi

/opt/farm/scripts/setup/extension.sh sf-cache-utils
/opt/farm/scripts/setup/extension.sh sf-hardware-utils

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi
