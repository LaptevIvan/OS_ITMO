#!/bin/bash

LINE=""
accum=1
op=+
LINE=""
echo "Current value = $accum"
(tail -f pipe) |
while true;
do
	read -r LINE
	if [[ $LINE =~ ^[+-]?[[:digit:]]+$ ]]
	then
		LINE="$op$LINE"
		let accum=$accum$LINE
		echo "Current value = $accum"
	elif [[ $LINE == "QUIT" ]]
	then
		echo "Execute is stopped"
		break
	elif [[ $LINE == + ||  $LINE == "*" ]]
	then
		op="$LINE"
	else
		echo "Wrong input. Execute is stopped"
		break			
	fi	
done

