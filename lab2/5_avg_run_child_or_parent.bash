#!/bin/bash

source ./4_cpu_burst.bash

file=4_5_out
tfile=temp
echo -n "" > $tfile

awk  -F ':' -v out=$tfile ' 
BEGIN{
	lastPpid=-1
	sum=0
	cnt=0
}
{
	split($2, parent, "=")
	split($3, artTable, "=")
	ppid = parent[2]
	art = artTable[2]
	if (ppid != lastPpid) {
		if (NR > 1) {
			printf "Average_Running_Children_of_ParentID=%d is %.6f\n", lastPpid, sum/cnt >> out 	
		}
		lastPpid = ppid
		sum = 0
		cnt = 0
	}
	sum += art
	cnt += 1
	row = $0
	printf "%s\n", row >> out
}
END {
	printf "Average_Running_Children_of_ParentID=%d is %.6f\n", lastPpid, sum >> out
}' $file && mv $tfile $file


