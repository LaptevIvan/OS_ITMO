#!/bin/bash

declare -A processes

for dir in /proc/[0-9]*; 
do
  pid=$(basename "$dir")
  if [[ -d "$dir" ]] 
  then
    curRead=$(sudo grep "read_bytes:" "/proc/"$pid"/io"  | awk '{
      readBytes = $2
      print readBytes}')
  	processes[$pid]=$curRead
  fi
done

sleep 60

n=3
resVal=()
resPidCommand=()
for ((i=0; i<$n; i++))
do
	resVal[$i]=-1
done

for pid in "${!processes[@]}";
do
  if [[ -d "/proc/$pid" ]] 
  then
    curRead=$(sudo grep "read_bytes:" "/proc/"$pid"/io" | awk '{
      readBytes = $2
      print readBytes
    }')
    command=$(cat "/proc/"$pid"/comm")
  	let res=$curRead-${processes[$pid]}
  	for ((i=0; i<$n; i++)) 
  	do
  		if [[ $res -gt ${resVal[$i]} ]]
  		then
  			resVal[$i]=$res
  			resPidCommand[$i]="$pid : $command"
  			break
  		fi	
	done
  fi  
done

for ((i=0; i<$n; i++)) 
do
  echo "${resVal[$i]} : ${resPidCommand[$i]}"	
done


