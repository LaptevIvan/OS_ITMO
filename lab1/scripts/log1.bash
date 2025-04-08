#!/bin/bash

file=system.log

sudo grep "systemd" /var/log/syslog > $file
