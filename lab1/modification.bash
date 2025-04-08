#!/bin/bash

table=$1

awk -F ',' '
{
  personGroup = $2
  personRes = $3
  gsub(/\./, ",", personRes)
  sumGroups[personGroup] += personRes
  freq[personGroup]++
}

END{
  for (i in sumGroups) {
   res = sumGroups[i] / freq[i] 
   printf "%s\t%.2f\n", i, res
 }
}' $table | sort -k 2 -rn
