#!/bin/bash

dirAdd=~/test
fileReport=~/report
fileArchived=$dirAdd/archived

mkdir -p $dirAdd

time=$(date "+%Y-%m-%d_%H:%M:%S")
nowData=$(date "+%Y-%m-%d")

echo -n "" > $dirAdd/$time

echo "$(date): test was created successfully" >> $fileReport

foundFiles=$(echo $dirAdd/* | grep -o ".*/[[:digit:]]\{4\}-[[:digit:]]\{2\}-[[:digit:]]\{2\}_[0-9]\{2\}:[[:digit:]]\{2\}:[[:digit:]]\{2\}" | sort)

s=1
cur="-"
taken=""
for file in $foundFiles; 
do
	dataTime=$(basename $file)
	data_time=($(echo "$dataTime" | tr '_' '\n'))	
	data=${data_time[0]}
		
	if [[ $s -eq 1 ]]
	then
		cur=$data
		s=0
	fi

	if [[ $cur != $data ]]
	then
		mkdir -p $fileArchived 
                tar -czf  $cur.tar.gz -C $dirAdd --remove-files $taken 
        	mv $cur.tar.gz $fileArchived	
		taken=""
		cur=$data
	fi
	
	if [[ $data == $nowData ]]
	then
		break
	fi

	taken+=" ${dataTime}" 
done

