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

n=10
resVal=()
resUid=()
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
  	let res=$curRead-${processes[$pid]}
  	for ((i=0; i<$n; i++)) 
  	do
  		if [[ $res -gt ${resVal[$i]} ]]
  		then
  			uid=$(grep "Uid:" "/proc/"$pid"/status" | 
  				awk '{uid = $2
  				print uid}')
  			resVal[$i]=$res
  			resUid[$i]=$uid
  			break
  		fi	
	  done
  fi  
done

declare -A sum
max=-1
maxUid=-1
for ((i=0; i<$n; i++)) 
do
	user=${resUid[$i]}
	if [[ -v ${sum[$user]} ]]
	then
		(( sum[$user]+=resVal[$i] ))
	else 
		sum[$user]=${resVal[$i]}
	fi
	
	cur=${sum[$user]}
	if [[ $cur -gt $max ]]
	then
		max=$cur
		maxUid=$user
	fi		
done

echo $maxUid

