#!/bin/bash

top -b -n 1 -U $USER | awk '{
	if (NR == 2) {
		countProcesses = $2;
		print countProcesses	
	} else if (NR > 7) {
		pid = $1
		command = $12
		print pid, command;
	}
}' > 1_out

