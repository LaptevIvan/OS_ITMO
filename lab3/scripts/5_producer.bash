#!/bin/bash

if [[ ! -e pipe ]]
then
	mkfifo pipe
fi

LINE=""
 
while true;
do
	read -r LINE	
	echo "$LINE" > pipe
done

