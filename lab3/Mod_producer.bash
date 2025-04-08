#!/bin/bash

LINE=""
handlerPid=$(cat .pid)
Instruction="Enter 'Rus' to receive a Russian greeting\nsimilary 'Eng' - English greeting\n'Fren' - French greeting\n'Span' - Spanish greeting\nEnter a line containing the word TERM to stop execution"
echo -e "$Instruction"

while true; 
do
read -r LINE
case $LINE in
"Rus")
	kill -USR1 $handlerPid
	;;
"Eng")
	kill -USR2 $handlerPid
	;;
"Fren")
	kill -SIGCONT $handlerPid
	;;	
"Span")
	kill -SIGTTIN $handlerPid
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


