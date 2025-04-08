#!/bin/bash

file=./1_datetime.bash
surveillanceFile=~/report

(at -f $file now + 2 minutes
tail -f -n 0 $surveillanceFile | (read v; echo "$v"; killall tail)) &


