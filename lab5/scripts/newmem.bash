#!/bin/bash

arr=()
i=0
n="$1"
while [[ $i -lt $n ]]   
do
	arr+=(1 2 3 4 5 6 7 8 9 10)
	((i+=10))
done

