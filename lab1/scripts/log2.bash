#!/bin/bash

file="X_info_warn.log"

grep "(WW)" /var/log/Xorg.0.log | sed "s/(WW)/Warning:/" > $file && grep "(II)" /var/log/Xorg.0.log |  sed "s/(II)/Information:/" >> $file

