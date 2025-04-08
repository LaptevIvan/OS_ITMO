#!/bin/bash

run="./newmem.bash"
defineN="./find2.bash"

k=30
n="$1"
for ((i=0; i<$k; i++))
do
	$run $n &
	sleep 1
done	

