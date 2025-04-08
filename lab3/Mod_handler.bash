#!/bin/bash

echo $$ > .pid

rus()
{
	echo "Привет, мир!"
}

eng()
{
	echo "Hello, world!"
}

fren()
{
	echo "Bonjour, monde!"
}

span()
{
	echo "Hola, mundo!"
}

stop()
{
  echo "Execute is stopped"
  exit
}

trap 'rus' USR1
trap 'eng' USR2
trap 'fren' SIGCONT
trap 'span' SIGTTIN
trap 'stop' SIGTERM

while true
do
	sleep 1
done	

