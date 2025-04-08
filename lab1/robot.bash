#!/bin/bash

w=$1
h=$2
let x=$w/2
let y=$h/2
step=zero

while [[ true ]]
do

if [[ ${step} == q ]] || [[ ${x#-} = $w ]] || [[ ${y#-} = $h ]]
then break
fi

echo "x=${x};y=${y}" 

read -n 1 step

case ${step,,} in
w)
let y+=1
;;
a )
let x-=1
;;
s )
let y-=1
;;
d )
let x+=1
esac

 
done
