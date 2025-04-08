#!/bin/bash


LINE=""
handlerPid=$(cat .pid)
while true; 
do
read -r LINE
case $LINE in
"+")
	kill -USR1 $handlerPid
	;;
"*")
	kill -USR2 $handlerPid
	;;
*"TERM"*)
	kill -SIGTERM $handlerPid
	exit
	;;
*)
	:
	;;	
esac	
done

