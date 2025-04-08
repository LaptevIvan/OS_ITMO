#!/bin/bash

echo $$ > .pid

MODE=":"

accumVal=1

usr1()
{
	MODE="+"
}

usr2()
{
	MODE="*"
}

stop()
{
	echo "Execute is stopped"
	exit
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'stop' SIGTERM

while true; 
do
	case $MODE in
	"+")
		((accumVal+=2))
		MODE=":"
		;;
	"*")
		((accumVal*=2))
		MODE=":"
		;;
	*)
		:
		;;
	esac
	echo "Current value is $accumVal"
	sleep 1
done


