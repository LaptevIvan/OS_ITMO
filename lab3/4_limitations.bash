#!/bin/bash

task=./4_add.bash
n=3
pids=()
for ((i=0; i<$n; i++))
do
	$task &
	pids[$i]=$!
done

cpulimit -qbl 10 -p ${pids[0]}
kill -SIGKILL ${pids[2]}

