#!/bin/sh
. /opt/farm/scripts/init

if [ "`uname`" != "Linux" ] || [ "$OSTYPE" = "qnap" ]; then
	echo "skipping standby monitor configuration (unsupported system)"
	exit 0
elif [ "$HWTYPE" = "container" ] || [ "$HWTYPE" = "lxc" ]; then
	echo "skipping standby monitor configuration (containers do not have access to physical drives)"
	exit 0
fi

/opt/farm/scripts/setup/extension.sh sf-cache-utils
/opt/farm/scripts/setup/extension.sh sf-storage-utils

if ! grep -q /opt/farm/ext/standby-monitor/cron/check.sh /etc/crontab; then
	echo "*/30 * * * * root /opt/farm/ext/standby-monitor/cron/check.sh" >>/etc/crontab
fi
