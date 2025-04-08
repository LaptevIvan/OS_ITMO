#!/bin/bash

max=-1
maxPid=-1
for dir in /proc/[0-9]*; 
do
  pid=$(basename "$dir")
  if [[ -d "$dir" ]] 
  then
    curMem=$(cat "$dir/status" | grep "VmSize:" | awk '{
      vmSize = $2
      print vmSize
  }')
  	if [[ $curMem -gt $max ]]
  	then
  		max=$curMem
  		maxPid=$pid
  	fi
  fi
done

echo "$maxPid"

top -b -n 1 -o -VIRT | tail -1 | awk '{
  pid = $1
  print pid}'
  
  
  
