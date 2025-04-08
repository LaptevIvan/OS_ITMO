#!/bin/bash

while [[ true ]]
do
read -r word
if [[ $word != q ]]
then 
	echo ${#word}
	if [[ $word =~ ^[[:alpha:]]+$ ]]
	then
		echo "true"
	else 
		echo "false"
	fi
else break
fi
done
