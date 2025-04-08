#!/bin/bash

arr=()
i=0
step=100000
fileOutput="../logs/report.log"
echo -n "" > $fileOutput

while true   
do
	arr+=(1 2 3 4 5 6 7 8 9 10)
	((i++))
	if [[ $i -eq $step ]]
	then
		i=0
		echo "Current size of array is ${#arr[@]}" >> $fileOutput
	fi	
done




