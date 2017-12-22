#!/bin/sh

ls /dev/disk/by-path/*usb* 2>/dev/null |grep -v -- -part |xargs -r -n 1 readlink -f
