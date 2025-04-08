#!/bin/bash

lastBackup=$(find $HOME -maxdepth 1  -type d -regextype grep -regex ".*Backup-[[:digit:]]\{4\}-[[:digit:]]\{2\}-[[:digit:]]\{2\}$" | sort -r | head -n 1)

if [[ -z $lastBackup ]]
then 
	echo "There is no a backup in home directory"
	exit
fi

targetDir=$HOME/restore
mkdir -p $targetDir
find $lastBackup -type f -regextype grep -not -regex  ".*([[:digit:]]\{4\}-[[:digit:]]\{2\}-[[:digit:]]\{2\})$" -exec cp {} $targetDir \;

