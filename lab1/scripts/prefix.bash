#!/bin/bash

a=$1
b=$2
s=0
for ((i=$a; i<=$b; i++))
do
let s+=$i
echo $s
done
