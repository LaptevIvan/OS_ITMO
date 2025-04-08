#!/bin/bash

checkN() {
	sudo dmesg -C
	while true
	do
		inTop=$(pgrep "$memScript")
		inDmesg=$(sudo dmesg | grep "$memScript")
		if [[ -n "$inDmesg" ]]
		then
			return 1
		elif [[ -z "$inTop" ]]
		then
			return 0	
		fi	
		sleep 1
	done		
}


k="$1"
r=10000000
let l=66000000/$k
producer="run2.bash"
memScript="newmem.bash"
run="./$producer"

echo "Search for the maximum allowed N"
while [[ $((r - l)) -gt 1 ]]
do
	let m=$l+$(($r-$l))/2
	echo "Current N is $m"
	$run $m	&
	if checkN
	then
		echo "test of this N was passed"
		l=$m
	else 
		echo "test of this N wasn't passed"
		r=$m
		killall -qs SIGKILL "$producer"
		killall -qs SIGKILL "$memScript"
	fi	
done

echo $l


